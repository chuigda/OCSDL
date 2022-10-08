#import "OCSDLSurface.h"
#import "OCUtil.h"

@implementation OCSDLSurface
-(id)initWithWindow:(SDL_Window*)window sinkrate:(Sinkrate)sinkrate
{
   OC_INIT_BOILERPLATE({
      surface = SDL_GetWindowSurface(window);
      isOwnedSurface = false;
   })
}

-(id)initWithBMP:(NSString*)fileName
{
   OC_INIT_BOILERPLATE({
      surface = SDL_LoadBMP([fileName cString]);
      isOwnedSurface = true;
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

-(void)dealloc
{
   if (isOwnedSurface) {
      NSLog(@"deallocating surface resource");
      SDL_FreeSurface(surface);
   }
}

@end
