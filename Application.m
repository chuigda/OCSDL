#import <Foundation/Foundation.h>
#import "Application.h"
#import "OCSDL.h"
#import "OCSDLRenderer.h"
#import "OCSDLTexture.h"
#import "OCSDLSprite.h"

@implementation Application
+(int)main:(NSArray*)args
{
   (void)args;

   OCSDLContext *ctx = [[OCSDLContext alloc] init];
   OCSDLWindow *window = [[OCSDLWindow alloc]
                          init:@"SDL test"
                         width:640
                        height:480];
   OCSDLRenderer *renderer = [[OCSDLRenderer alloc]
                              initFromWindow:window];
   OCSDLSurface *spriteSurface = [[OCSDLSurface alloc]
                                  initWithImage:@"./Sprites/Cirno.png"];
   [spriteSurface setColorKeyR:0xff g:0x00 b:0xff];
   OCSDLTexture *spriteTexture = [[OCSDLTexture alloc]
                                  init:renderer
                           fromSurface:spriteSurface];
   NSArray *sprites = [spriteTexture spriteSplit:OC_SDL_ROW rows:4 cols:8];

   NSArray *walkBackSprites = [sprites subarrayWithRange:NSMakeRange(0, 6)];
   NSArray *walkFrontSprites = [sprites subarrayWithRange:NSMakeRange(6, 6)];
   NSArray *walkLeftSprites = [sprites subarrayWithRange:NSMakeRange(12, 6)];
   NSArray *walkRightSprites = [sprites subarrayWithRange:NSMakeRange(18, 6)];

   NSArray *currentSprite = walkFrontSprites;
   int currentImage = 0;
   OCSDLPoint pos = { 320, 240 };

   for (;;) {
      [renderer clear];

      OCSDLEvent *e;
      while ((e = [ctx pollEvent])) {
         if ([e isKindOfClass:[OCSDLQuitEvent class]]) {
            return 0;
         }

         if ([e isKindOfClass:[OCSDLKeyboardEvent class]]) {
            OCSDLKeyboardEvent *keyboardEvent = (OCSDLKeyboardEvent *) e;
            switch ([keyboardEvent keysym].sym) {
               case SDLK_ESCAPE:
                  return 0;

               case SDLK_LEFT:
                  if (currentSprite != walkLeftSprites) {
                     currentSprite = walkLeftSprites;
                     currentImage = 0;
                  }
                  pos.x -= 8;
                  break;
               case SDLK_RIGHT:
                  if (currentSprite != walkRightSprites) {
                     currentSprite = walkRightSprites;
                     currentImage = 0;
                  }
                  pos.x += 8;
                  break;
               case SDLK_UP:
                  if (currentSprite != walkBackSprites) {
                     currentSprite = walkBackSprites;
                     currentImage = 0;
                  }
                  pos.y -= 10;
                  break;
               case SDLK_DOWN:
                  if (currentSprite != walkFrontSprites) {
                     currentSprite = walkFrontSprites;
                     currentImage = 0;
                  }
                  pos.y += 10;
                  break;
            }
            break;
         }
      }

      currentImage += 1;
      if (currentImage >= [currentSprite count]) {
         currentImage = 0;
      }

      OCSDLSprite *sprite = [currentSprite objectAtIndex:currentImage];

      [renderer renderSprite:sprite pos:pos];
      [renderer present];
      SDL_Delay(50);
   }
}
@end
