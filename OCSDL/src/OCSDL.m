#import "../include/OCSDL.h"
#import "../include/OCUtil.h"

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
   SDL_PollEvent(&e);
   return [OCSDLEvent fromNative:e];
}

-(void)dealloc
{
   NSLog(@"OCSDL: uninitializing SDL context");
   SDL_Quit();
}
@end
