//
//  XMPPPresenceStanzaTests.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer.
//
//  This file is part of XMPPFoundation.
//
//  XMPPFoundation is free software: you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the Free
//  Software Foundation, either version 3 of the License, or (at your option)
//  any later version.
//
//  XMPPFoundation is distributed in the hope that it will be useful, but WITHOUT
//  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
//  FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License along with
//  XMPPFoundation. If not, see <http://www.gnu.org/licenses/>.
//
//  Linking this library statically or dynamically with other modules is making
//  a combined work based on this library. Thus, the terms and conditions of the
//  GNU General Public License cover the whole combination.
//
//  As a special exception, the copyright holders of this library give you
//  permission to link this library with independent modules to produce an
//  executable, regardless of the license terms of these independent modules,
//  and to copy and distribute the resulting executable under terms of your
//  choice, provided that you also meet, for each linked independent module, the
//  terms and conditions of the license of that module. An independent module is
//  a module which is not derived from or based on this library. If you modify
//  this library, you must extend this exception to your version of the library.
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
