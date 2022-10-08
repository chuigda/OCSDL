#import <Foundation/Foundation.h>
#import "Application.h"

int main(int argc, char **argv) {
   @autoreleasepool {
      NSMutableArray *args = [[NSMutableArray alloc] initWithCapacity:argc];
      for (int i = 0; i < argc; i++) {
         [args addObject:[[NSString alloc] initWithCString:argv[i]]];
      }

      return [Application main:args];
   }
}
