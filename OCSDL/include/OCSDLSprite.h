#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import <OCSDLBase.h>

@class OCSDLTexture;

@interface OCSDLSprite : NSObject
{
   OCSDLTexture *texture;
   OCSDLRect *rect;
   OCSDLPoint center;
}

-(id)init:(OCSDLTexture*)texture rect:(OCSDLRect*)rect center:(OCSDLPoint)center;
-(OCSDLTexture*)texture;
-(OCSDLRect*)rect;
-(OCSDLPoint)center;
@end
