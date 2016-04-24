//
//  ____Tests.m
//  知乎日报Tests
//
//  Created by Jz on 16/4/7.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RequestTool.h"
#import "LeftMenuViewModel.h"

#define WAIT do {\\
[self expectationForNotification:@"RSBaseTest" object:nil handler:nil];\\
[self waitForExpectationsWithTimeout:30 handler:nil];\\
} while (0)

#define NOTIFY \\
[[NSNotificationCenter defaultCenter]postNotificationName:@"RSBaseTest" object:nil]

@interface ____Tests : XCTestCase

@end

@implementation ____Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testGetThemes{
    [[RequestTool shardRequest]getThemesWithSuccess:^(id requestData) {
        XCTAssertNotNil(requestData,@"返回出错");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"JZTest" object:nil];
    } andfail:^(NSError *error) {
        NSLog(@"%@",error);
        XCTAssertNil(error,@"请求出错");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"JZTest" object:nil];

    }];
    
    [self expectationForNotification:@"JZTest" object:nil handler:nil];
    [self waitForExpectationsWithTimeout:30 handler:nil];
}

- (void)testLeftViewModel{
//    LeftMenuViewModel *viewModle = [[LeftMenuViewModel alloc]initWithThemes];
    LeftMenuViewModel *viewModel = [[LeftMenuViewModel alloc]init];
    [self expectationForNotification:@"JZTest" object:nil handler:nil];
    [self waitForExpectationsWithTimeout:30 handler:nil];
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
