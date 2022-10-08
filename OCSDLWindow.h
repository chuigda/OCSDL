#import <Foundation/Foundation.h>
#import "OCSDLSurface.h"

#include <SDL2/SDL.h>

@interface OCSDLWindow : NSObject
{
   SDL_Window *window;
   OCSDLSurface *surface;
}

-(id)init:(NSString*)title width:(int)width height:(int)height;
-(OCSDLSurface*)surface;
-(void)updateWindowSurface;
-(void)dealloc;

@end
