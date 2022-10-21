#import <Foundation/Foundation.h>

#import "OCSDLApplication.h"
#import "OCSDLWindow.h"
#import "OCSDLRenderer.h"
#import "OCSDLContext.h"
#import "OCUtil.h"

@implementation OCSDLExecutor
-(id)init:(NSString*)windowTitle windowWidth:(int)w windowHeight:(int)h
{
   OC_INIT_BOILERPLATE({
      context = [[OCSDLContext alloc] init];
      if (!context) {
         return nil;
      }

      window = [[OCSDLWindow alloc] init:windowTitle width:w height:h];
      if (!window) {
         return nil;
      }

      renderer = [[OCSDLRenderer alloc] initFromWindow:window];
      if (!renderer) {
         return nil;
      }
   })
}

-(void)runApplication:(id<OCSDLApplication>)application
{
   [application setWindow:self->window setRenderer:self->renderer];
   [application prepare];

   int targetFPS = [application targetFrameRate];
   if (targetFPS == 0) {
      targetFPS = 30;
   }
   int frameSkip = 1000 / targetFPS;

   for (;;) {
      unsigned startTime = SDL_GetTicks();

      [application beforePaint];
      OCSDLEvent *e;
      while ((e = [context pollEvent])) {
         if ([e isKindOfClass:[OCSDLQuitEvent class]]) {
            if ([application handleQuitEvent:(OCSDLQuitEvent*)e] == true) {
               return;
            }
         }

         if ([e isKindOfClass:[OCSDLKeyboardEvent class]]) {
            [application handleKeyboardEvent:(OCSDLKeyboardEvent*)e];
         }
      }
      [application updateFrame];
      [application paint];

      unsigned endTime = SDL_GetTicks();
      unsigned elapsed = endTime - startTime;
      if (elapsed > frameSkip) {
         NSLog(@"w: main thread overloaded (elapsed %ums, expected %ums)", elapsed, frameSkip);
      } else {
         SDL_Delay(frameSkip - elapsed);
      }
   }
}
@end
