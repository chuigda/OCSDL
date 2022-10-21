#import <SDL2/SDL_image.h>
#import "OCSDLContext.h"
#import "OCUtil.h"

@implementation OCSDLContext
-(id)init
{
   OC_INIT_BOILERPLATE({
      NSLog(@"OCSDL: initializing SDL context");
      if (SDL_Init(SDL_INIT_VIDEO) != 0) {
         return nil;
      }
   })
}

-(OCSDLEvent*)pollEvent
{
   SDL_Event e;
   if (!SDL_PollEvent(&e)) {
      return nil;
   }
   return [OCSDLEvent fromNative:e];
}

-(void)dealloc
{
   NSLog(@"OCSDL: uninitializing SDL context");
   IMG_Quit();
   SDL_Quit();
}
@end
