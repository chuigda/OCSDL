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

- (void)renderCopy:(OCSDLTexture *)texture dstRect:(OCSDLRect *)dstRect srcRect:(OCSDLRect *)srcRect {
   SDL_RenderCopy(renderer,
                  [texture nativeHandle],
                  srcRect ? [srcRect nativeHandle] : NULL,
                  dstRect ? [dstRect nativeHandle] : NULL);
}

@end
