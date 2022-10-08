#import "OCSDLSurface.h"
#import "OCUtil.h"

@implementation OCSDLSurface
{
   SDL_Surface *surface;
}

-(id)initWithWindow:(SDL_Window*)window sinkrate:(Sinkrate)sinkrate
{
   OC_INIT_BOILERPLATE({
      surface = SDL_GetWindowSurface(window);
   })
}

-(id)initWithBMP:(NSString*)fileName
{
   OC_INIT_BOILERPLATE({
      surface = SDL_LoadBMP([fileName cString]);
      if (!surface) {
         return nil;
      }
   })
}

-(void)fillRectRGB:(SDL_Rect*)rect r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b
{
   SDL_FillRect(surface, rect, SDL_MapRGB(surface->format, r, g, b));
}

-(void)blit:(OCSDLSurface*)src dstRect:(SDL_Rect*)dstRect srcRect:(SDL_Rect*)srcRect
{
   SDL_BlitSurface(src->surface, srcRect, surface, dstRect);
}

OC_DEALLOC_BOILERPLATE({
   SDL_FreeSurface(surface);
})

@end
