#import <Foundation/Foundation.h>
#import "Application.h"
#import "OCSDL.h"
#import "OCSDLRenderer.h"
#import "OCSDLTexture.h"

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
   OCSDLTexture *texture1 = [[OCSDLTexture alloc]
                             init:renderer
                        withImage:@"test1.bmp"];
   OCSDLRect *imageRect = [[OCSDLRect alloc] initX:320 - 32 y:240 - 32 w:64 h:64];
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
               imageRect.x -= 5;
               break;
            case SDLK_RIGHT:
               imageRect.x += 5;
               break;
            case SDLK_UP:
               imageRect.y -= 5;
               break;
            case SDLK_DOWN:
               imageRect.y += 5;
               break;
         }
      }
      OCSDLRect *borderRect = [imageRect copy];
      borderRect.w += 4;
      borderRect.h += 4;
      borderRect.x -= 2;
      borderRect.y -= 2;

      [renderer setColorR:0x00 g:0x00 b:0x00];
      [renderer clear];
      [renderer setColorR:0xcd g:0x00 b:0x00];
      [renderer fillRect:borderRect];
      [renderer renderCopy:texture1 dstRect:imageRect srcRect:nil];
      [renderer present];
   }
   return 0;
}
@end
