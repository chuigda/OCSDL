#import <Foundation/Foundation.h>

#include <SDL2/SDL.h>
#include "Sinkrate.h"

@interface OCSDLEvent : NSObject
{
   SDL_Event event;
}

+(id)fromNative:(SDL_Event)nativeEvent;
-(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate;
-(uint32_t)typeId;
-(SDL_Event)native;
@end

@interface OCSDLUnknownEvent : OCSDLEvent
-(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate;
@end

@interface OCSDLQuitEvent : OCSDLEvent
-(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate;
-(uint32_t)timestamp;
@end
