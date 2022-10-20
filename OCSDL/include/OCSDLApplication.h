#import <Foundation/Foundation.h>

@class OCSDLWindow;
@class OCSDLRenderer;
@class OCSDLQuitEvent;
@class OCSDLKeyboardEvent;
@class OCSDLContext;

@protocol OCSDLApplication
-(void)setWindow:(OCSDLWindow*)window setRenderer:(OCSDLRenderer*)renderer;
-(void)prepare;
-(void)beforePaint;
-(void)paint;
-(BOOL)handleQuitEvent:(OCSDLQuitEvent*)quitEvent;
-(void)handleKeyboardEvent:(OCSDLKeyboardEvent*)keyboardEvent;
-(void)updateFrame;
-(int)targetFrameRate;
@end

@interface OCSDLExecutor : NSObject
{
   OCSDLContext *context;
   OCSDLWindow *window;
   OCSDLRenderer *renderer;
}

-(id)init:(NSString*)windowTitle windowWidth:(int)w windowHeight:(int)h;
-(void)runApplication:(id<OCSDLApplication>)application;
@end
