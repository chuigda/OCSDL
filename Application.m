#import <Foundation/Foundation.h>
#import "Application.h"
#import "OCSDL.h"
#import "OCSDLRenderer.h"
#import "OCSDLTexture.h"

@implementation Application
+(int)main:(NSArray*)args
{
   OCSDLContext *ctx = [[OCSDLContext alloc] init];
   OCSDLWindow *window = [[OCSDLWindow alloc] init:@"SDL test" width:640 height:480];
   OCSDLRenderer *renderer = [[OCSDLRenderer alloc] initFromWindow:window];
   OCSDLTexture *texture1 = [[OCSDLTexture alloc] init:renderer withImage:@"test1.bmp"];
   OCSDLTexture *texture2 = [[OCSDLTexture alloc] init:renderer withImage:@"test2.bmp"];

   OCSDLRect *windowRect = [[OCSDLRect alloc] initW:640 h:480];
   OCSDLTexture *currentTexture = texture1;
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
            case SDLK_1:
               currentTexture = texture1;
               break;
            case SDLK_2:
               currentTexture = texture2;
               break;
         }
      }

      [renderer clear];
      [renderer renderCopy:currentTexture dstRect:windowRect srcRect:nil];
      [renderer present];
   }
   return 0;
}
@end
