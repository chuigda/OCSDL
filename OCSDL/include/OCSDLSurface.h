#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import "OCSDLBase.h"

@interface OCSDLSurface : NSObject
{
   SDL_Surface *surface;
   BOOL isOwnedSurface;
   NSObject *gcAnchor;
}

-(id)initFromNative:(SDL_Surface*)surface isOwned:(BOOL)isOwned gcAnchor:(NSObject*)anchor;
-(id)initWithImage:(NSString*)fileName;
-(void)dealloc;

-(SDL_PixelFormat*)pixelFormat;
-(void)fillRect:(OCSDLRect*)rect r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b;
-(void)fillRect:(OCSDLRect*)rect r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a;
-(void)blit:(OCSDLSurface*)src dstRect:(OCSDLRect*)dstRect srcRect:(OCSDLRect*)srcRect;
-(void)blitScaled:(OCSDLSurface*)src dstRect:(OCSDLRect*)dstRect srcRect:(OCSDLRect*)srcRect;
-(OCSDLSurface*)convert:(SDL_PixelFormat*)targetFormat;
@end
