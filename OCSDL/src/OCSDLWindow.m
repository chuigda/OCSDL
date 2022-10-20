#import "OCSDLWindow.h"
#import "OCUtil.h"
#import "OCSDLRenderer.h"
#import "OCSDLEvent.h"
#import "OCSDL.h"

@implementation OCSDLWindow
-(id)init:(NSString*)title width:(int)width height:(int)height
{
   OC_INIT_BOILERPLATE({
      if (SDL_Init(SDL_INIT_VIDEO) != 0) {
         NSLog(@"SDL failed to initialize! SDL_Error() = %s",
               SDL_GetError());
         return nil;
      }

      window = SDL_CreateWindow([title cString],
                                SDL_WINDOWPOS_UNDEFINED,
                                SDL_WINDOWPOS_UNDEFINED,
                                width,
                                height,
                                SDL_WINDOW_SHOWN);
      if (window == NULL) {
         NSLog(@"SDL could not create window! SDL_Error() = %s",
               SDL_GetError());
         return nil;
      }
   })
}

-(OCSDLSurface*)surface
{
   return [[OCSDLSurface alloc]
           initFromNative:SDL_GetWindowSurface(window)
                  isOwned:false
                 gcAnchor:self];
}

-(void)updateWindowSurface
{
   SDL_UpdateWindowSurface(window);
}

-(SDL_Window*)nativeHandle;
{
   return window;
}

-(void)dealloc
{
   NSLog(@"deallocating window");
   SDL_DestroyWindow(window);
}

@end
