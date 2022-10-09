#import "OCSDLBase.h"
#import "OCUtil.h"

@implementation OCSDLRect
-(int)x { return inner.x; }
-(int)y { return inner.y; }
-(int)w { return inner.w; }
-(int)h { return inner.h; }
-(void)setX:(int)x { inner.x = x; }
-(void)setY:(int)y { inner.y = y; }
-(void)setW:(int)w { inner.w = w; }
-(void)setH:(int)h { inner.h = h; }

-(id)initFromNative:(SDL_Rect*)native
{
   OC_INIT_BOILERPLATE({
      memcpy(&inner, native, sizeof(SDL_Rect));
   })
}

-(id)initX:(int)x y:(int)y w:(int)w h:(int)h
{
   OC_INIT_BOILERPLATE({
      inner.x = x;
      inner.y = y;
      inner.w = w;
      inner.h = h;
   })
}

-(id)initW:(int)w h:(int)h
{
   return [self initX:0 y:0 w:w h:h];
}

-(SDL_Rect*)nativeHandle
{
   return &inner;
}

-(id)copy
{
   return [[OCSDLRect alloc] initX:self.x y:self.y w:self.w h:self.h];
}

@end
