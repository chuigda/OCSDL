#import "OCSDLEvent.h"
#import "OCUtil.h"

@implementation OCSDLEvent : NSObject

+(id)fromNative:(SDL_Event)nativeEvent
{
   #define CASE_TYPEID_RET(TYPEID, OCTYPE)  \
      case TYPEID:                          \
         return [[OCTYPE alloc]             \
                 initPrivate:nativeEvent    \
                 sinkrate:SecretInternalsDoNotUseOrYouWillBeFired];

   #pragma clang diagnostic push
   #pragma ide diagnostic ignored "bugprone-branch-clone"
   switch (nativeEvent.type) {
      CASE_TYPEID_RET(SDL_QUIT, OCSDLQuitEvent)
      CASE_TYPEID_RET(SDL_KEYDOWN, OCSDLKeyboardEvent)
      CASE_TYPEID_RET(SDL_KEYUP, OCSDLKeyboardEvent)
      default:
         return [[OCSDLUnknownEvent alloc]
                 initPrivate:nativeEvent
                 sinkrate:SecretInternalsDoNotUseOrYouWillBeFired];
   }
   #pragma clang diagnostic pop

   #undef CASE_TYPEID_RET
}

-(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate
{
   OC_INIT_BOILERPLATE({
      event = nativeEvent;
   })
}

-(uint32_t)typeId
{
   return event.type;
}

-(uint32_t)timestamp
{
   return event.quit.timestamp;
}

-(SDL_Event)nativeEvent
{
   return event;
}

-(void)dealloc
{
   [super dealloc];
}
@end

#define OC_EVENT_INIT_BOILERPLATE(CODE)                                \
   -(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate \
   {                                                                   \
      self = [super initPrivate:nativeEvent sinkrate:sinkrate];        \
      if (!self) {                                                     \
         return nil;                                                   \
      }                                                                \
      {                                                                \
         CODE                                                          \
      }                                                                \
      return self;                                                     \
   }

@implementation OCSDLUnknownEvent : OCSDLEvent
OC_EVENT_INIT_BOILERPLATE({})
@end

@implementation OCSDLQuitEvent : OCSDLEvent
OC_EVENT_INIT_BOILERPLATE({})
@end

@implementation OCSDLKeyboardEvent : OCSDLEvent
OC_EVENT_INIT_BOILERPLATE({})

-(uint32_t)windowId
{
   return event.key.windowID;
}

-(uint8_t)state
{
   return event.key.state;
}

-(uint8_t)repeat
{
   return event.key.repeat;
}

-(SDL_Keysym)keysym
{
   return event.key.keysym;
}
@end
