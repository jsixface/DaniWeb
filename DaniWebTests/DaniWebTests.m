//
//  DaniWebTests.m
//  DaniWebTests
//
//  Created by Arumugam Jeganathan on 2/26/14.
//  Copyright (c) 2014 DaniWeb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Restkit/Restkit.h>
#import "DWForum.h"
#import "DWConfigurator.h"
#import "Async.h"

@interface DaniWebTests : XCTestCase

@end

@implementation DaniWebTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [DWConfigurator config];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    //test start
    
    StartBlock();
    
    [[RKObjectManager sharedManager] getObjectsAtPathForRouteNamed:@"forums"
                                                            object:nil
                                                        parameters:nil
                                                           success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                               NSLog(@"%@", mappingResult.dictionary[@"data"]);
                                                               EndBlock();
                                                           }
                                                           failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                               NSLog(@"error happened %@", error);
                                                               EndBlock();
                                                           }];

    WaitUntilBlockCompletes();
}

@end
