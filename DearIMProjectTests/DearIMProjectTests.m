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

- (void)testOne {
    MYByteBuf *byte = [[MYByteBuf alloc] initWithCapacity:10];
    [byte writeInt:1];
    int value = [byte readInt];
    XCTAssertEqual(value, 1);
}

- (void)testFF {
    MYByteBuf *byte = [[MYByteBuf alloc] initWithCapacity:10];
    [byte writeInt:(1 + 0xFF)];
    int value = [byte readInt];
    XCTAssertEqual(value, 1 +0xFF);
}

- (void)testLong {
    MYByteBuf *byte = [[MYByteBuf alloc] initWithCapacity:10];
    [byte writeLong:(1 + 0xFF)];
    long value = [byte readLong];
    XCTAssertEqual(value, 1 +0xFF);
}


- (void)testMultiRead {
    MYByteBuf *byte = [[MYByteBuf alloc] initWithCapacity:10];
    [byte writeLong:(1 + 0xFF)];
    [byte writeInt:(1 + 0xFF)];
    
    long value1 = [byte readLong];
    int value2 = [byte readInt];
    XCTAssertEqual(value1, 1 +0xFF);
    XCTAssertEqual(value2, 1 +0xFF);
    
}

- (void)testString {
    MYByteBuf *byte = [[MYByteBuf alloc] initWithCapacity:32];
    NSString *string = @"abcdefghijklmn";
    [byte writeString:string];
    
    NSString *result = [byte readStringWithLength:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"result = %@",result);
    
}


- (void)testToId {
    MYByteBuf *byte = [[MYByteBuf alloc] initWithCapacity:32];
    long fromId = 11223344;
    [byte writeLong:fromId];
}

@end
