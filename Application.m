#import <Foundation/Foundation.h>
#import "Application.h"
#import "OCSDL.h"

@implementation Application
+(int)main:(NSArray*)args
{
   OCSDLContext *ctx = [[OCSDLContext alloc] init];
   OCSDLWindow *window = [[OCSDLWindow alloc] init:@"SDL test" width:640 height:480];
   OCSDLSurface *image1 = [[OCSDLSurface alloc] initWithBMP:@"test1.bmp"];
   OCSDLSurface *image2 = [[OCSDLSurface alloc] initWithBMP:@"test2.bmp"];

   for (;;) {
      OCSDLEvent *e = [ctx pollEvent];
      if ([e isKindOfClass:[OCSDLQuitEvent class]]) {
         break;
      }

      if ([e isKindOfClass:[OCSDLKeyboardEvent class]]) {
         OCSDLKeyboardEvent *keyboardEvent = (OCSDLKeyboardEvent*)e;
         switch ([keyboardEvent keysym].sym) {
            case SDLK_1:
               [[window surface] blit:image1 dstRect:NULL srcRect:NULL];
               break;
            case SDLK_2:
               [[window surface] blit:image2 dstRect:NULL srcRect:NULL];
               break;
         }
      }

      [window updateWindowSurface];
   }
   return 0;
}
@end
