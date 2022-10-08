#define OC_INIT_BOILERPLATE(CODE) \
   self = [super init];           \
   if (!self) {                   \
      return nil;                 \
   }                              \
   {                              \
      CODE                        \
   }                              \
   return self;

#define OC_DEALLOC_BOILERPLATE(CODE) \
   -(void)dealloc                    \
   {                                 \
      {                              \
         CODE                        \
      }                              \
   }
