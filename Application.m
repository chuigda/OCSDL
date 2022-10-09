#import <Foundation/Foundation.h>
#import "Application.h"
#import "OCSDL.h"
#import "OCSDLRenderer.h"
#import "OCSDLTexture.h"
#import "OCSDLSprite.h"

@implementation Application
+(int)main:(NSArray*)args
{
   OCSDLContext *ctx = [[OCSDLContext alloc] init];
   OCSDLWindow *window = [[OCSDLWindow alloc]
                          init:@"SDL test"
                         width:640
                        height:480];
   OCSDLRenderer *renderer = [[OCSDLRenderer alloc]
                              initFromWindow:window];
   OCSDLTexture *spriteTexture = [[OCSDLTexture alloc]
                                  init:renderer
                             withImage:@"sprite.png"];
   NSArray *sprites = [spriteTexture spriteSplit:OC_SDL_ROW count:6];
   int currentImage = 0;
   OCSDLPoint pos = { 320, 240 };
   SDL_RendererFlip flip = SDL_FLIP_NONE;

   for (;;) {
      OCSDLEvent *e = [ctx pollEvent];
      if ([e isKindOfClass:[OCSDLQuitEvent class]]) {
         break;
      }

      if ([e isKindOfClass:[OCSDLKeyboardEvent class]]) {
         OCSDLKeyboardEvent *keyboardEvent = (OCSDLKeyboardEvent*)e;
         switch ([keyboardEvent keysym].sym) {
            case SDLK_ESCAPE:
               return 0;
            case SDLK_LEFT:
               flip = SDL_FLIP_HORIZONTAL;
               pos.x -= 3;
               break;
            case SDLK_RIGHT:
               flip = SDL_FLIP_NONE;
               pos.x += 3;
               break;
         }

         currentImage += 1;
         if (currentImage > 5) {
            currentImage = 0;
         }
      }

      OCSDLSprite *sprite = [sprites objectAtIndex:currentImage];

      [renderer clear];
      [renderer renderSprite:sprite pos:pos rotation:0.0 flip:flip];
      [renderer present];
   }
   return 0;
}
@end
