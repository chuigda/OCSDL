#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import "OCSDLWindow.h"

@class OCSDLTexture;
@class OCSDLSprite;

@interface OCSDLRenderer : NSObject
{
   OCSDLWindow *window;
   SDL_Renderer *renderer;
}

-(id)initFromWindow:(OCSDLWindow*)nativeWindow;
-(void)dealloc;

-(SDL_Renderer*)nativeHandle;
-(void)clear;
-(void)present;
-(void)setViewport:(OCSDLRect*)viewport;
-(void)renderCopy:(OCSDLTexture*)texture dstRect:(OCSDLRect*)dstRect srcRect:(OCSDLRect*)srcRect;
-(void)renderSprite:(OCSDLSprite*)sprite pos:(OCSDLPoint)pos;
-(void)setColorR:(uint8_t)r g:(uint8_t)g b:(uint8_t)b;
-(void)setColorR:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a;
-(void)fillRect:(OCSDLRect*)rect;
-(void)drawLine:(OCSDLPoint)fromPoint to:(OCSDLPoint)toPoint;
-(void)drawPoint:(OCSDLPoint)point;
@end
