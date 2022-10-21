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

   Sprite *marisaSprite;
   Sprite *cirnoSprite;
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
   {
      OCSDLSurface *spriteSurface = [[OCSDLSurface alloc]
                                     initWithImage:@"./Sprites/Marisa.png"];
      [spriteSurface setColorKeyR:0xff g:0x00 b:0xff];
      OCSDLTexture *spriteTexture = [[OCSDLTexture alloc]
                                     init:renderer
                              fromSurface:spriteSurface];
      NSArray *frames = [spriteTexture spriteSplit:OC_SDL_ROW rows:11 cols:8];
      NSArray *walkBackFrames = [frames subarrayWithRange:NSMakeRange(0, 6)];
      NSArray *walkFrontFrames = [frames subarrayWithRange:NSMakeRange(6, 6)];
      NSArray *walkLeftFrames = [frames subarrayWithRange:NSMakeRange(12, 6)];
      NSArray *walkRightFrames = [frames subarrayWithRange:NSMakeRange(18, 6)];

      NSArray *frameSets = [[NSArray alloc]
                            initWithObjects:walkBackFrames, walkFrontFrames, walkLeftFrames, walkRightFrames, nil];
      marisaSprite = [[Sprite alloc] init:frameSets withFrameSkip:1];
      [marisaSprite setPosition:(OCSDLPoint) { 320 - 32, 220 }];
   }

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
      cirnoSprite = [[Sprite alloc] init:frameSets withFrameSkip:1];
      [cirnoSprite setPosition:(OCSDLPoint) {320 + 32, 220 }];
   }
}

-(void)beforePaint
{
   [renderer setColorR:0x00 g:0x00 b:0x00];
   [renderer clear];
}

-(void)paint
{
   [marisaSprite renderWithBorderBox:renderer];
   [cirnoSprite renderWithBorderBox:renderer];
   [renderer present];
}

-(BOOL)handleQuitEvent:(OCSDLQuitEvent*)quitEvent
{
   return true;
}

-(void)handleKeyboardEvent:(OCSDLKeyboardEvent*)keyboardEvent
{
   if (keyboardEvent.state != SDL_RELEASED) {
      switch ([keyboardEvent keysym].sym) {
         case SDLK_a:
            [marisaSprite orderToMove:MoveLeft];
            break;
         case SDLK_d:
            [marisaSprite orderToMove:MoveRight];
            break;
         case SDLK_w:
            [marisaSprite orderToMove:MoveBack];
            break;
         case SDLK_s:
            [marisaSprite orderToMove:MoveFront];
            break;

         case SDLK_LEFT:
            [cirnoSprite orderToMove:MoveLeft];
            break;
         case SDLK_RIGHT:
            [cirnoSprite orderToMove:MoveRight];
            break;
         case SDLK_UP:
            [cirnoSprite orderToMove:MoveBack];
            break;
         case SDLK_DOWN:
            [cirnoSprite orderToMove:MoveFront];
            break;
      }
   }
}

-(void)updateFrame
{
   [marisaSprite update];
   [cirnoSprite update];
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
