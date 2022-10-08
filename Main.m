#import <Foundation/Foundation.h>
#import "Application.h"

int main(int argc, char **argv) {
   NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
   NSMutableArray *args = [[NSMutableArray alloc] initWithCapacity:argc];
   for (int i = 0; i < argc; i++) {
      [args addObject:[[NSString alloc] initWithCString:argv[i]]];
   }

   int ret = [Application main:args];
   [pool drain];
   return ret;
}
