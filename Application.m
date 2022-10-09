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
               currentImage -= 1;
               break;
            case SDLK_RIGHT:
               currentImage += 1;
               break;
         }
         if (currentImage > 5) {
            currentImage = 0;
         } else if (currentImage < 0) {
            currentImage = 5;
         }
      }

      OCSDLSprite *sprite = [sprites objectAtIndex:currentImage];

      [renderer clear];
      [renderer renderSprite:sprite pos:(OCSDLPoint) { 320, 240 }];
      [renderer present];
   }
   return 0;
}
@end
