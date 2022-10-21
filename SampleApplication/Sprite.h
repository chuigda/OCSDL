#import <Foundation/Foundation.h>
#import "OCSDLRenderer.h"

typedef enum { MoveBack, MoveFront, MoveLeft, MoveRight } MoveDirection;

BOOL isHorizontalMove(MoveDirection d);
BOOL isVerticalMove(MoveDirection d);

@interface Sprite : NSObject
{
   NSArray *spriteFrameSets;

   BOOL isMoving;
   MoveDirection move;
   unsigned moveSteps;

   BOOL hasPendingMove;
   MoveDirection pendingMove;

   OCSDLPoint currentPos;
   unsigned currentFrameIdx;
}

-(id)init:(NSArray*)frameSets;
-(void)setPosition:(OCSDLPoint)pos;
-(void)orderToMove:(MoveDirection)moveDirection;
-(void)update;
-(void)render:(OCSDLRenderer*)renderer;
@end
