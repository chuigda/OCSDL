#import "OCSDLSprite.h"
#import "OCUtil.h"

@implementation OCSDLSprite
-(id)init:(OCSDLTexture*)texture1 rect:(OCSDLRect*)rect1 center:(OCSDLPoint)center1
{
   OC_INIT_BOILERPLATE({
      texture = texture1;
      rect = rect1;
      center = center1;
   })
}

-(OCSDLTexture*)texture
{
   return texture;
}

-(OCSDLRect*)rect
{
   return rect;
}

-(OCSDLPoint)center
{
   return center;
}

@end
