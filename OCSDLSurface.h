#import <Foundation/Foundation.h>

#include <SDL2/SDL.h>
#include "Sinkrate.h"

@interface OCSDLSurface : NSObject
{
   SDL_Surface *surface;
}

-(id)initWithWindow:(SDL_Window*)window sinkrate:(Sinkrate)sinkrate;
-(id)initWithBMP:(NSString*)fileName;
-(void)dealloc;

-(void)fillRectRGB:(SDL_Rect*)rect r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b;
-(void)blit:(OCSDLSurface*)src dstRect:(SDL_Rect*)dstRect srcRect:(SDL_Rect*)srcRect;
@end
