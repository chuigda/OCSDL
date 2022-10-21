#import <Foundation/Foundation.h>
#import "OCSDLRenderer.h"

typedef enum { MoveBack, MoveFront, MoveLeft, MoveRight } MoveDirection;

BOOL isHorizontalMove(MoveDirection d);
BOOL isVerticalMove(MoveDirection d);

@interface Sprite : NSObject
{
   NSArray *spriteFrameSets;
   unsigned spriteFrameSkip;

   BOOL isMoving;
   MoveDirection move;
   unsigned moveSteps;

   OCSDLPoint currentPos;
   unsigned frameCounter;
   unsigned currentFrameIdx;
}

-(id)init:(NSArray*)frameSets;
-(id)init:(NSArray*)frameSets withFrameSkip:(unsigned)frameSkip;
-(void)setPosition:(OCSDLPoint)pos;
-(void)orderToMove:(MoveDirection)moveDirection;
-(void)update;
-(void)render:(OCSDLRenderer*)renderer;
-(void)renderWithBorderBox:(OCSDLRenderer*)renderer;
@end
