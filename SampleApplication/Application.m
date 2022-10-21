#import <Foundation/Foundation.h>

#import "OCSDL.h"
#import "OCSDLApplication.h"
#import "OCSDLRenderer.h"
#import "OCSDLTexture.h"

#import "Application.h"
#import "Sprite.h"

@interface GameApplication : NSObject<OCSDLApplication>
{
   OCSDLRenderer *renderer;

   Sprite *playerSprite;
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
   NSArray *frames = [spriteTexture spriteSplit:OC_SDL_ROW rows:4 cols:8];

   NSArray *walkBackFrames = [frames subarrayWithRange:NSMakeRange(0, 6)];
   NSArray *walkFrontFrames = [frames subarrayWithRange:NSMakeRange(6, 6)];
   NSArray *walkLeftFrames = [frames subarrayWithRange:NSMakeRange(12, 6)];
   NSArray *walkRightFrames = [frames subarrayWithRange:NSMakeRange(18, 6)];

   NSArray *frameSets = [[NSArray alloc]
                         initWithObjects:walkBackFrames, walkFrontFrames, walkLeftFrames, walkRightFrames, nil];

   playerSprite = [[Sprite alloc] init:frameSets];

   OCSDLPoint point;
   point.x = 320;
   point.y = 240;
   [playerSprite setPosition:point];
}

-(void)beforePaint
{
   [renderer setColorR:0x00 g:0x00 b:0x00];
   [renderer clear];
}

-(void)paint
{
   [playerSprite render:renderer];
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
         [playerSprite orderToMove:MoveLeft];
         break;
      case SDLK_RIGHT:
         [playerSprite orderToMove:MoveRight];
         break;
      case SDLK_UP:
         [playerSprite orderToMove:MoveBack];
         break;
      case SDLK_DOWN:
         [playerSprite orderToMove:MoveFront];
         break;
   }
}

-(void)updateFrame
{
   [playerSprite update];
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
