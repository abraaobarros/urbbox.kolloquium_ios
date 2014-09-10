//
//  KQHTMLParser.m
//  Events
//
//  Created by Abraao Barros Lacerda on 20/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface KQHTMLParser : XCTestCase

@end

@implementation KQHTMLParser

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
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:@"http://kolloquium.herokuapp.com"];
}

@end
