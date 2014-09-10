//
//  EventsTests.m
//  EventsTests
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//


/*
    Script de teste DataConnect
 
 */
#import <XCTest/XCTest.h>

@interface EventsTests : XCTestCase

@end

@implementation EventsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    int x = 123;
    void (^printXandY)(int) = ^(int y){
        printf("%d %d\n", x, y);
    };
    
    printXandY(456);
}

@end
