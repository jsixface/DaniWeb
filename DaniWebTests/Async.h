//
//  Async.h
//  DaniWeb
//
//  Created by Arumugam Jeganathan on 7/9/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#ifndef DaniWeb_Async_h
#define DaniWeb_Async_h
// Set the flag for a block completion handler
#define StartBlock() __block BOOL waitingForBlock = YES

// Set the flag to stop the loop
#define EndBlock() waitingForBlock = NO

// Wait and loop until flag is set
#define WaitUntilBlockCompletes() WaitWhile(waitingForBlock)

// Macro - Wait for condition to be NO/false in blocks and asynchronous calls
#define WaitWhile(condition) \
do { \
while(condition) { \
[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]]; \
} \
} while(0)


#endif
