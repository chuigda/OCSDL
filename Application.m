#import <Foundation/Foundation.h>
#import "Application.h"

#import "OCSDL.h"
#import "OCSDLApplication.h"
#import "OCSDLRenderer.h"
#import "OCSDLTexture.h"
#import "OCSDLSprite.h"

@interface GameApplication : NSObject<OCSDLApplication>
{
   OCSDLRenderer *renderer;

   NSArray *walkBackSprites;
   NSArray *walkFrontSprites;
   NSArray *walkLeftSprites;
   NSArray *walkRightSprites;

   NSArray *currentSprite;
   int frameCounter;
   int currentImage;
   OCSDLPoint currentPos;
}

-(void)setWindow:(OCSDLWindow*)window setRenderer:(OCSDLRenderer*)renderer;
-(void)prepare;
-(void)beforePaint;
-(void)paint;
-(BOOL)handleQuitEvent:(OCSDLQuitEvent*)quitEvent;
-(void)handleKeyboardEvent:(OCSDLKeyboardEvent*)keyboardEvent;
-(void)updateFrame;

-(int)targetFrameRate;
@end

@implementation GameApplication
-(void)setWindow:(OCSDLWindow*)window1 setRenderer:(OCSDLRenderer*)renderer1
{
   (void)window1;
   renderer = renderer1;
}

-(void)prepare
{
   OCSDLSurface *spriteSurface = [[OCSDLSurface alloc]
                                  initWithImage:@"./Sprites/Cirno.png"];
   [spriteSurface setColorKeyR:0xff g:0x00 b:0xff];

   OCSDLTexture *spriteTexture = [[OCSDLTexture alloc]
                                  init:renderer
                           fromSurface:spriteSurface];
   NSArray *sprites = [spriteTexture spriteSplit:OC_SDL_ROW rows:4 cols:8];

   walkBackSprites = [sprites subarrayWithRange:NSMakeRange(0, 6)];
   walkFrontSprites = [sprites subarrayWithRange:NSMakeRange(6, 6)];
   walkLeftSprites = [sprites subarrayWithRange:NSMakeRange(12, 6)];
   walkRightSprites = [sprites subarrayWithRange:NSMakeRange(18, 6)];

   currentSprite = walkFrontSprites;
   currentImage = 0;
   currentPos = (OCSDLPoint) { 320, 240 };
}

-(void)beforePaint
{
   [renderer clear];
}

-(void)paint
{
   OCSDLSprite *sprite = [currentSprite objectAtIndex:currentImage];
   [renderer renderSprite:sprite pos:currentPos];
   [renderer present];
}

-(BOOL)handleQuitEvent:(OCSDLQuitEvent*)quitEvent
{
   return true;
}

-(void)handleKeyboardEvent:(OCSDLKeyboardEvent*)keyboardEvent
{
   switch ([keyboardEvent keysym].sym) {
      case SDLK_LEFT:
         if (currentSprite != walkLeftSprites) {
            currentSprite = walkLeftSprites;
            frameCounter = 0;
            currentImage = 0;
         }
         currentPos.x -= 4;
         break;
      case SDLK_RIGHT:
         if (currentSprite != walkRightSprites) {
            currentSprite = walkRightSprites;
            frameCounter = 0;
            currentImage = 0;
         }
         currentPos.x += 4;
         break;
      case SDLK_UP:
         if (currentSprite != walkBackSprites) {
            currentSprite = walkBackSprites;
            frameCounter = 0;
            currentImage = 0;
         }
         currentPos.y -= 5;
         break;
      case SDLK_DOWN:
         if (currentSprite != walkFrontSprites) {
            currentSprite = walkFrontSprites;
            frameCounter = 0;
            currentImage = 0;
         }
         currentPos.y += 5;
         break;
   }
}

-(void)updateFrame
{
   frameCounter += 1;
   if (frameCounter >= 4) {
      frameCounter = 0;
      currentImage += 1;
      if (currentImage >= [currentSprite count]) {
         currentImage = 0;
      }
   }
}

-(int)targetFrameRate
{
   return 30;
}
@end

@implementation Application
+(int)main:(NSArray*)args
{
   (void)args;

   GameApplication *application = [[GameApplication alloc] init];
   OCSDLExecutor *executor = [[OCSDLExecutor alloc]
                              init:@"OCSDL Testing window"
                       windowWidth:640
                      windowHeight:480];
   [executor runApplication:application];

   return 0;
}
@end
