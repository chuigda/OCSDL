#import <Foundation/Foundation.h>
#import <SDL2/SDL_rect.h>

typedef SDL_Point OCSDLPoint;

typedef enum {
   OC_SDL_ROW,
   OC_SDL_COL
} OCSDLRowColOrder;

@interface OCSDLRect : NSObject
{
   SDL_Rect inner;
}

@property(nonatomic) int x;
@property(nonatomic) int y;
@property(nonatomic) int w;
@property(nonatomic) int h;

-(id)initFromNative:(SDL_Rect*)native;
-(id)initX:(int)x y:(int)y w:(int)w h:(int)h;
-(id)initW:(int)w h:(int)h;
-(SDL_Rect*)nativeHandle;
-(id)copy;
@end
