//
//  XMPPPresenceStanzaTests.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XMPPFoundation/XMPPFoundation.h>

@interface XMPPPresenceStanzaTests : XCTestCase

@end

@implementation XMPPPresenceStanzaTests

- (void)testSetType
{
    XMPPPresenceStanza *presence = [[XMPPPresenceStanza alloc] initWithFrom:nil to:nil];

    presence.type = XMPPPresenceStanzaTypeUndefined;
    XCTAssertNil([presence valueForAttribute:@"type"]);

    presence.type = XMPPPresenceStanzaTypeError;
    XCTAssertEqualObjects([presence valueForAttribute:@"type"], @"error");

    presence.type = XMPPPresenceStanzaTypeProbe;
    XCTAssertEqualObjects([presence valueForAttribute:@"type"], @"probe");

    presence.type = XMPPPresenceStanzaTypeSubscribe;
    XCTAssertEqualObjects([presence valueForAttribute:@"type"], @"subscribe");

    presence.type = XMPPPresenceStanzaTypeSubscribed;
    XCTAssertEqualObjects([presence valueForAttribute:@"type"], @"subscribed");

    presence.type = XMPPPresenceStanzaTypeUnavailable;
    XCTAssertEqualObjects([presence valueForAttribute:@"type"], @"unavailable");

    presence.type = XMPPPresenceStanzaTypeUnsubscribe;
    XCTAssertEqualObjects([presence valueForAttribute:@"type"], @"unsubscribe");

    presence.type = XMPPPresenceStanzaTypeUnsubscribed;
    XCTAssertEqualObjects([presence valueForAttribute:@"type"], @"unsubscribed");

    presence.type = XMPPPresenceStanzaTypeUndefined;
    XCTAssertNil([presence valueForAttribute:@"type"]);
}

- (void)testGetType
{
    XMPPPresenceStanza *presence = [[XMPPPresenceStanza alloc] initWithFrom:nil to:nil];

    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeUndefined);

    [presence setValue:@"error" forAttribute:@"type"];
    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeError);

    [presence setValue:@"probe" forAttribute:@"type"];
    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeProbe);

    [presence setValue:@"subscribe" forAttribute:@"type"];
    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeSubscribe);

    [presence setValue:@"subscribed" forAttribute:@"type"];
    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeSubscribed);

    [presence setValue:@"unavailable" forAttribute:@"type"];
    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeUnavailable);

    [presence setValue:@"unsubscribe" forAttribute:@"type"];
    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeUnsubscribe);

    [presence setValue:@"unsubscribed" forAttribute:@"type"];
    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeUnsubscribed);

    [presence setValue:@"xxx" forAttribute:@"type"];
    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeUndefined);

    [presence setValue:nil forAttribute:@"type"];
    XCTAssertEqual(presence.type, XMPPPresenceStanzaTypeUndefined);
}

@end
