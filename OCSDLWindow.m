#import "OCSDLWindow.h"
#import "OCUtil.h"

@implementation OCSDLWindow
{
   SDL_Window *window;
   OCSDLSurface *surface;
}

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

      surface = [[OCSDLSurface alloc]
         initWithWindow:window
               sinkrate:SecretInternalsDoNotUseOrYouWillBeFired];
      [surface fillRectRGB:NULL r:0xFF g:0xFF b:0xFF];
   })
}

-(OCSDLSurface*)surface
{
   return surface;
}

-(void)updateWindowSurface
{
   SDL_UpdateWindowSurface(window);
}

OC_DEALLOC_BOILERPLATE({
   SDL_DestroyWindow(window);
})

@end

