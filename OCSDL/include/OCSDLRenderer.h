#import <Foundation/Foundation.h>
#import <SDL2/SDL.h>
#import "OCSDLWindow.h"

@class OCSDLTexture;

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
-(void)renderCopy:(OCSDLTexture*)texture dstRect:(OCSDLRect*)dstRect srcRect:(OCSDLRect*)srcRect;
@end
