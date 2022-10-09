#import "OCSDLRenderer.h"
#import "OCUtil.h"
#import "OCSDLTexture.h"

@implementation OCSDLRenderer
-(id)initFromWindow:(OCSDLWindow*)nativeWindow
{
   OC_INIT_BOILERPLATE({
      self->window = nativeWindow;
      renderer = SDL_CreateRenderer([window nativeHandle], -1, SDL_RENDERER_ACCELERATED);
   })
}

-(void)dealloc
{
   SDL_DestroyRenderer(renderer);
}

-(SDL_Renderer*)nativeHandle
{
   return renderer;
}

-(void)clear
{
   SDL_RenderClear(renderer);
}

-(void)present
{
   SDL_RenderPresent(renderer);
}

-(void)renderCopy:(OCSDLTexture *)texture dstRect:(OCSDLRect *)dstRect srcRect:(OCSDLRect *)srcRect {
   SDL_RenderCopy(renderer,
                  [texture nativeHandle],
                  srcRect ? [srcRect nativeHandle] : NULL,
                  dstRect ? [dstRect nativeHandle] : NULL);
}

-(void)setColorR:(uint8_t)r g:(uint8_t)g b:(uint8_t)b
{
   [self setColorR:r g:g b:b a:0xFF];
}

-(void)setColorR:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a
{
   SDL_SetRenderDrawColor(renderer, r, g, b, a);
}

-(void)fillRect:(OCSDLRect*)rect
{
   SDL_RenderFillRect(renderer, rect ? [rect nativeHandle] : NULL);
}

-(void)drawLine:(OCSDLPoint)fromPoint to:(OCSDLPoint)toPoint
{
   SDL_RenderDrawLine(renderer, fromPoint.x, fromPoint.y, toPoint.x, toPoint.y);
}

-(void)drawPoint:(OCSDLPoint)point;
{
   SDL_RenderDrawPoint(renderer, point.x, point.y);
}

@end