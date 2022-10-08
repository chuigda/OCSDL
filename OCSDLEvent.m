#import "OCSDLEvent.h"
#import "OCUtil.h"

@implementation OCSDLEvent : NSObject
{
   SDL_Event event;
}

+(id)fromNative:(SDL_Event)nativeEvent
{
   switch (nativeEvent.type) {
      case SDL_QUIT:
         return [[OCSDLQuitEvent alloc]
                 initPrivate:nativeEvent
                 sinkrate:SecretInternalsDoNotUseOrYouWillBeFired];
      default:
         return [[OCSDLUnknownEvent alloc]
                 initPrivate:nativeEvent
                 sinkrate:SecretInternalsDoNotUseOrYouWillBeFired];
   }
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

-(SDL_Event)native
{
   return event;
}

@end

#define OC_EVENT_INIT_BOILERPLATE(CODE)                      \
   self = [super initPrivate:nativeEvent sinkrate:sinkrate]; \
   if (!self) {                                              \
      return nil;                                            \
   }                                                         \
   {                                                         \
      CODE                                                   \
   }                                                         \
   return self;

@implementation OCSDLUnknownEvent : OCSDLEvent
-(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate
{
   OC_EVENT_INIT_BOILERPLATE({})
}
@end

@implementation OCSDLQuitEvent : OCSDLEvent
-(id)initPrivate:(SDL_Event)nativeEvent sinkrate:(Sinkrate)sinkrate
{
   OC_EVENT_INIT_BOILERPLATE({})
}

-(uint32_t)timestamp
{
   return event.quit.timestamp;
}
@end

