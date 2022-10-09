#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>

@class OCSDLRenderer;

@interface OCSDLTexture : NSObject
{
   OCSDLRenderer *renderer;
   SDL_Texture *texture;
   BOOL isOwnedTexture;
}

-(id)init:(OCSDLRenderer*)renderer fromNative:(SDL_Texture*)nativeTexture isOwned:(BOOL)isOwned;
-(id)init:(OCSDLRenderer*)renderer withImage:(NSString*)fileName;
-(void)dealloc;

-(SDL_Texture*)nativeHandle;
@end
