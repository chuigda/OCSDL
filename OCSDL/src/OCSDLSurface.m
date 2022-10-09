#import <SDL2/SDL_image.h>
#import "OCSDLSurface.h"
#import "OCUtil.h"

@implementation OCSDLSurface
-(id)initFromNative:(SDL_Surface*)nativeSurface isOwned:(BOOL)isOwned gcAnchor:(NSObject*)anchor
{
   OC_INIT_BOILERPLATE({
      surface = nativeSurface;
      isOwnedSurface = isOwned;
      gcAnchor = anchor;
   })
}

-(id)initWithImage:(NSString*)fileName
{
   OC_INIT_BOILERPLATE({
      surface = IMG_Load([fileName cString]);
      isOwnedSurface = true;
      if (!surface) {
         return nil;
      }
   })
}

-(void)dealloc
{
   if (isOwnedSurface) {
      SDL_FreeSurface(surface);
   }
}

-(SDL_Surface*)nativeHandle
{
   return surface;
}

-(SDL_PixelFormat*)pixelFormat
{
   return surface->format;
}

-(void)setColorKeyR:(uint8_t)r g:(uint8_t)g b:(uint8_t)b
{
   SDL_SetColorKey(surface, SDL_TRUE, SDL_MapRGB(surface->format, r, g, b));
}

-(void)fillRect:(OCSDLRect*)rect r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b
{
   SDL_FillRect(surface,
                rect ? [rect nativeHandle] : NULL,
                SDL_MapRGB(surface->format, r, g, b));
}

-(void)fillRect:(OCSDLRect*)rect r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a
{
   SDL_FillRect(surface,
                rect ? [rect nativeHandle] : NULL,
                SDL_MapRGBA(surface->format, r, g, b, a));
}

-(void)blit:(OCSDLSurface*)src dstRect:(OCSDLRect*)dstRect srcRect:(OCSDLRect*)srcRect
{
   SDL_BlitSurface(src->surface,
                   srcRect ? [srcRect nativeHandle] : NULL,
                   surface,
                   dstRect ? [dstRect nativeHandle] : NULL);
}

-(void)blitScaled:(OCSDLSurface*)src dstRect:(OCSDLRect*)dstRect srcRect:(OCSDLRect*)srcRect
{
   SDL_BlitScaled(src->surface,
                  srcRect ? [srcRect nativeHandle] : NULL,
                  surface,
                  dstRect ? [dstRect nativeHandle] : NULL);
}

-(OCSDLSurface*)convert:(SDL_PixelFormat*)targetFormat
{
   SDL_Surface *converted = SDL_ConvertSurface(surface, targetFormat, 0);
   return [[OCSDLSurface alloc] initFromNative:converted isOwned:true gcAnchor:nil];
}

@end
