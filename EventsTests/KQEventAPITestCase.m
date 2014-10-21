//
//  KQEventAPITestCase.m
//  Events
//
//  Created by Abraao Barros Lacerda on 18/08/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KQURLConnectHelperMock.h"
#import "KQEventAPI.h"
#import "KQCache.h"

@interface KQEventAPITestCase : XCTestCase

@end

@implementation KQEventAPITestCase
KQEventAPI *kq_event;
KQURLConnectHelperMock *conn;

- (void)setUp
{
    [super setUp];
    kq_event = [[KQEventAPI alloc] init];
    conn = [[KQURLConnectHelperMock alloc]init];
    [kq_event setUrlConnectHelper:conn];
    //[kq_event loadData:nil startHandler:nil];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testInitKQEvent{
    XCTAssertNotNil(kq_event, @"The event should't be nil");
}

-(void) testGetSomePropertyWithoutInternetWithCache{
    KQCache *c = [KQCache sharedManager];
    __block NSDictionary *dict;
    [conn fetchContentAtURL:nil withParameters:nil startHandle:nil sucessHandler:^(NSDictionary* finished){
        dict = finished;
    }];
    XCTAssertEqual([kq_event objectForKey:@"name"], @"Nome",@"The name of event should't have matched");
}

-(void) testGetSomeProperty{
    XCTAssertEqual([kq_event objectForKey:@"name"], @"Nome",@"The name of event should't have matched");
}



@end
