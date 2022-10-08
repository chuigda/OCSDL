#import <Foundation/Foundation.h>
#import "Application.h"
#import "OCSDL.h"

@implementation Application
+(int)main:(NSArray*)args
{
   OCSDLContext *ctx = [[OCSDLContext alloc] init];

   OCSDLWindow *window = [[OCSDLWindow alloc] init:@"SDL test" width:640 height:480];
   OCSDLSurface *image = [[OCSDLSurface alloc] initWithBMP:@"test.bmp"];
   if (!(ctx && image)) {
      return -1;
   }

   [window updateWindowSurface];
   [[window surface] blit:image dstRect:NULL srcRect:NULL];
   for (;;) {
      OCSDLEvent *e = [ctx pollEvent];
      if ([e typeId] == SDL_QUIT) {
         break;
      }
      [window updateWindowSurface];
   }
   return 0;
}
@end
