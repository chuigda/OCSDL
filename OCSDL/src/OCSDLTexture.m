#import <SDL2/SDL_image.h>
#import "OCSDLTexture.h"
#import "OCUtil.h"
#import "OCSDLRenderer.h"

@implementation OCSDLTexture
-(id)init:(OCSDLRenderer*)renderer1 fromNative:(SDL_Texture*)nativeTexture isOwned:(BOOL)isOwned;
{
   OC_INIT_BOILERPLATE({
      renderer = renderer1;
      texture = nativeTexture;
      isOwnedTexture = isOwned;
   })
}

-(id)init:(OCSDLRenderer*)renderer1 withImage:(NSString*)fileName
{
   OC_INIT_BOILERPLATE({
      renderer = renderer1;
      texture = IMG_LoadTexture([renderer nativeHandle], [fileName cString]);
      isOwnedTexture = true;
   })
}

-(void)dealloc
{
   if (isOwnedTexture) {
      SDL_DestroyTexture(texture);
   }
}

-(SDL_Texture*)nativeHandle
{
   return texture;
}
@end
