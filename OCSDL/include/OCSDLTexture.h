#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import "OCSDLBase.h"

@class OCSDLRenderer;
@class OCSDLSurface;

@interface OCSDLTexture : NSObject
{
   OCSDLRenderer *renderer;
   SDL_Texture *texture;
}

-(id)init:(OCSDLRenderer*)renderer1 fromSurface:(OCSDLSurface*)surface;
-(id)init:(OCSDLRenderer*)renderer withImage:(NSString*)fileName;
-(void)dealloc;

-(SDL_Texture*)nativeHandle;
-(OCSDLPoint)size;
-(NSArray*)spriteSplit:(OCSDLRowColOrder)order rows:(int)rows cols:(int)cols;
-(NSArray*)spriteSplit:(OCSDLRowColOrder)order count:(int)count;
@end
