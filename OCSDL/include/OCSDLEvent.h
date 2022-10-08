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
-(uint32_t)timestamp;
-(SDL_Event)nativeEvent;
@end

@interface OCSDLUnknownEvent : OCSDLEvent
-(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate;
@end

@interface OCSDLQuitEvent : OCSDLEvent
-(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate;
@end

@interface OCSDLKeyboardEvent : OCSDLEvent
-(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate;

-(uint32_t)windowId;
-(uint8_t)state;
-(uint8_t)repeat;
-(SDL_Keysym)keysym;
@end
