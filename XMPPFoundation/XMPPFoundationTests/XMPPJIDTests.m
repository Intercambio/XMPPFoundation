//
//  XMPPJIDTests.m
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 10.12.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XMPPFoundation/XMPPFoundation.h>

@interface XMPPJIDTests : XCTestCase

@end

@implementation XMPPJIDTests


- (void)testJIDFromString
{
    XMPPJID *jid = [[XMPPJID alloc] initWithString:@"foo@example.com/bar"];
    
    XCTAssertEqualObjects(jid.host, @"example.com");
    XCTAssertEqualObjects(jid.user, @"foo");
    XCTAssertEqualObjects(jid.resource, @"bar");
    
    XCTAssertEqualObjects([jid stringValue], @"foo@example.com/bar");
    XCTAssertEqualObjects([[jid bareJID] stringValue], @"foo@example.com");
}

- (void)testJIDFromEmptyString
{
    XMPPJID *jid = [[XMPPJID alloc] initWithString:@""];
    XCTAssertNil(jid);
}

- (void)testJIDWithResource
{
    XMPPJID *jid = [[XMPPJID alloc] initWithString:@"foo@example.com/bar"];
    XCTAssertEqualObjects([[jid fullJIDWithResource:@"foo"] stringValue], @"foo@example.com/foo");
}

- (void)testEqual
{
    XCTAssertEqualObjects([[XMPPJID alloc] initWithString:@"foo@example.com/bar"], [[XMPPJID alloc] initWithString:@"foo@example.com/bar"]);
    XCTAssertNotEqualObjects([[XMPPJID alloc] initWithString:@"foo@example.com/foo"], [[XMPPJID alloc] initWithString:@"foo@example.com/bar"]);
    XCTAssertNotEqualObjects([[XMPPJID alloc] initWithString:@"foo@example.com/foo"], @"foo@example.com/bar");
}

@end
