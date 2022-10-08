#import <Foundation/Foundation.h>
#import "OCSDLSurface.h"
#import "OCSDLWindow.h"
#import "OCSDLEvent.h"

@interface OCSDLContext : NSObject
-(id)init;
-(OCSDLEvent*)pollEvent;
-(void)dealloc;
@end
