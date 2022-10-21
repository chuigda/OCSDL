#import "Sprite.h"
#import "OCUtil.h"

BOOL isHorizontalMove(MoveDirection d) {
   return d == MoveLeft || d == MoveRight;
}

BOOL isVerticalMove(MoveDirection d) {
   return d == MoveFront || d == MoveBack;
}

@implementation Sprite
-(id)init:(NSArray*)frameSets
{
   OC_INIT_BOILERPLATE({
      if ([frameSets count] < 4) {
         NSLog(@"e: sprite should at least have 4 frame sets");
         return nil;
      }
      spriteFrameSets = frameSets;
      isMoving = false;
      hasPendingMove = false;
      currentFrameIdx = 0;
   })
}

-(void)setPosition:(OCSDLPoint)pos
{
   currentPos = pos;
}

-(void)orderToMove:(MoveDirection)moveDirection
{
   if (isMoving) {
      hasPendingMove = true;
      pendingMove = moveDirection;
   } else {
      isMoving = true;
      move = moveDirection;
      moveSteps = 0;
   }
}

-(void)update
{
   if (isMoving) {
      NSArray *currentFrameSet = (NSArray*)[spriteFrameSets objectAtIndex:(unsigned)move];
      unsigned frameSetSize = [currentFrameSet count];

      currentFrameIdx = (currentFrameIdx + 1) % frameSetSize;

      switch (move) {
         case MoveBack:
            currentPos.y -= 2;
            break;
         case MoveFront:
            currentPos.y += 2;
            break;
         case MoveLeft:
            currentPos.x -= 2;
            break;
         case MoveRight:
            currentPos.x += 2;
            break;
      }
      moveSteps += 1;
      if ((isHorizontalMove(move) && moveSteps >= 16)
          || (isVerticalMove(move) && moveSteps >= 10)) {
         if (hasPendingMove) {
            hasPendingMove = false;
            if (pendingMove != move) {
               currentFrameIdx = 0;
            }
            move = pendingMove;
         } else {
            currentFrameIdx = 0;
            isMoving = false;
         }
      }
   }
}

-(void)render:(OCSDLRenderer*)renderer
{
   NSArray *currentFrameSet = (NSArray*)[spriteFrameSets objectAtIndex:(unsigned)move];
   OCSDLSprite *currentSprite = (OCSDLSprite*)[currentFrameSet objectAtIndex:currentFrameIdx];

   [renderer renderSprite:currentSprite pos:currentPos];
   [renderer setColorR:0xff g:0x00 b:0x00];
   [renderer strokeRect:[[OCSDLRect alloc]
      initX:currentPos.x - 16
          y:currentPos.y
          w:32
          h:20]];
}
@end
