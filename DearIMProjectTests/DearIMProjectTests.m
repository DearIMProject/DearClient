//
//  DearIMProjectTests.m
//  DearIMProjectTests
//
//  Created by WenMingYan on 2023/9/22.
//

#import <XCTest/XCTest.h>
#import "MYByteBuf.h"

@interface DearIMProjectTests : XCTestCase

@end

@implementation DearIMProjectTests

//- (void)setUp {
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//}
//
//- (void)tearDown {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//}

- (void)testExample {
    MYByteBuf *byte = [[MYByteBuf alloc] initWithCapacity:10];
    [byte writeInt:1];
    int value = [byte readInt];
    NSLog(@"%d",value);
    
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
