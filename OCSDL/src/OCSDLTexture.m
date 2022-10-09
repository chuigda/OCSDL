#import <SDL2/SDL_image.h>
#import "OCSDLSurface.h"
#import "OCSDLTexture.h"
#import "OCSDLSprite.h"
#import "OCSDLRenderer.h"
#import "OCUtil.h"
#import "Sinkrate.h"

@implementation OCSDLTexture
-(id)init:(OCSDLRenderer*)renderer1 fromNative:(SDL_Texture*)nativeTexture secret:(Sinkrate)sinkrate
{
   OC_INIT_BOILERPLATE({
      renderer = renderer1;
      texture = nativeTexture;
   })
}

-(id)init:(OCSDLRenderer*)renderer1 fromSurface:(OCSDLSurface*)surface
{
   SDL_Texture *nativeTexture = SDL_CreateTextureFromSurface([renderer1 nativeHandle],
                                                             [surface nativeHandle]);
   if (!nativeTexture) {
      return nil;
   }

   return [self init:renderer1
          fromNative:nativeTexture
              secret:SecretInternalsDoNotUseOrYouWillBeFired];
}

-(id)init:(OCSDLRenderer*)renderer1 withImage:(NSString*)fileName
{
   SDL_Texture *nativeTexture = IMG_LoadTexture([renderer1 nativeHandle], [fileName cString]);
   if (!nativeTexture) {
      return nil;
   }

   return [self init:renderer1
          fromNative:nativeTexture
              secret:SecretInternalsDoNotUseOrYouWillBeFired];
}

-(void)dealloc
{
   SDL_DestroyTexture(texture);
}

-(SDL_Texture*)nativeHandle
{
   return texture;
}

-(OCSDLPoint)size
{
   OCSDLPoint ret;
   SDL_QueryTexture(texture, NULL, NULL, &ret.x, &ret.y);
   return ret;
}

-(NSArray*)spriteSplit:(OCSDLRowColOrder)order rows:(int)rows cols:(int)cols
{
   OCSDLPoint size = [self size];
   if (size.y % rows != 0) {
      NSLog(@"w: spriteSplit: %d resident rows", size.y % rows);
   }

   if (size.x % cols != 0) {
      NSLog(@"w: spriteSplit: %d resident cols", size.x % rows);
   }

   int width = size.x / cols;
   int height = size.y / rows;
   if (width & 0x01) {
      NSLog(@"w: spriteSPlit: sprite width is odd and may cause problem");
   }
   if (height & 0x01) {
      NSLog(@"w: spriteSPlit: sprite height is odd and may cause problem");
   }

   int cx = width / 2;
   int cy = height / 2;

   NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:rows * cols];
   if (order == OC_SDL_COL) {
      for (int col = 0; col < cols; col++) {
         for (int row = 0; row < rows; row++) {
            int x = cx + width * col;
            int y = cy * height * row;
            [ret addObject:[[OCSDLSprite alloc] init:self
                                                rect:[[OCSDLRect alloc] initX:x
                                                                            y:y
                                                                            w:width
                                                                            h:height]
                                              center:(OCSDLPoint) { cx, cy }]];
         }
      }
   } else {
      for (int row = 0; row < rows; row++) {
         for (int col = 0; col < cols; col++) {
            int x = cx + width * col;
            int y = cy * height * row;
            [ret addObject:[[OCSDLSprite alloc] init:self
                                                rect:[[OCSDLRect alloc] initX:x
                                                                            y:y
                                                                            w:width
                                                                            h:height]
                                              center:(OCSDLPoint) { cx, cy }]];
         }
      }
   }
   return ret;
}

-(NSArray*)spriteSplit:(OCSDLRowColOrder)order count:(int)count
{
   if (order == OC_SDL_COL) {
      return [self spriteSplit:order rows:count cols:1];
   } else {
      return [self spriteSplit:order rows:1 cols:count];
   }
}

@end
