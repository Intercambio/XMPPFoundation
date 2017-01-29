//
//  XMPPMessageStanzaTests.m
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

@interface XMPPMessageStanzaTests : XCTestCase

@end

@implementation XMPPMessageStanzaTests

- (void)testDocumentWithMessage
{
    XMPPJID *from = JID(@"romeo@example.com");
    XMPPJID *to = JID(@"juliet@example.com");
    
    XMPPMessageStanza *message = [[XMPPMessageStanza alloc] initWithFrom:from to:to];

    XCTAssertNotNil(message.identifier);
    XCTAssertEqualObjects(message.from, from);
    XCTAssertEqualObjects(message.to, to);

    XCTAssertEqual(message.type, XMPPMessageStanzaTypeUndefined);
}

- (void)testSetType
{
    XMPPMessageStanza *message = [[XMPPMessageStanza alloc] initWithFrom:nil to:nil];

    message.type = XMPPMessageStanzaTypeUndefined;
    XCTAssertNil([message valueForAttribute:@"type"]);

    message.type = XMPPMessageStanzaTypeChat;
    XCTAssertEqualObjects([message valueForAttribute:@"type"], @"chat");

    message.type = XMPPMessageStanzaTypeError;
    XCTAssertEqualObjects([message valueForAttribute:@"type"], @"error");

    message.type = XMPPMessageStanzaTypeGroupchat;
    XCTAssertEqualObjects([message valueForAttribute:@"type"], @"groupchat");

    message.type = XMPPMessageStanzaTypeHeadline;
    XCTAssertEqualObjects([message valueForAttribute:@"type"], @"headline");

    message.type = XMPPMessageStanzaTypeNormal;
    XCTAssertEqualObjects([message valueForAttribute:@"type"], @"normal");

    message.type = XMPPMessageStanzaTypeUndefined;
    XCTAssertNil([message valueForAttribute:@"type"]);
}

- (void)testGetType
{
    XMPPMessageStanza *message = [[XMPPMessageStanza alloc] initWithFrom:nil to:nil];
    XCTAssertEqual(message.type, XMPPMessageStanzaTypeUndefined);

    [message setValue:@"chat" forAttribute:@"type"];
    XCTAssertEqual(message.type, XMPPMessageStanzaTypeChat);

    [message setValue:@"error" forAttribute:@"type"];
    XCTAssertEqual(message.type, XMPPMessageStanzaTypeError);

    [message setValue:@"groupchat" forAttribute:@"type"];
    XCTAssertEqual(message.type, XMPPMessageStanzaTypeGroupchat);

    [message setValue:@"headline" forAttribute:@"type"];
    XCTAssertEqual(message.type, XMPPMessageStanzaTypeHeadline);

    [message setValue:@"normal" forAttribute:@"type"];
    XCTAssertEqual(message.type, XMPPMessageStanzaTypeNormal);

    [message setValue:@"xxx" forAttribute:@"type"];
    XCTAssertEqual(message.type, XMPPMessageStanzaTypeUndefined);

    [message setValue:nil forAttribute:@"type"];
    XCTAssertEqual(message.type, XMPPMessageStanzaTypeUndefined);
}

- (void)testOriginID {
    XMPPMessageStanza *message = [[XMPPMessageStanza alloc] initWithFrom:nil to:nil];

    PXElement *originID = [message addElementWithName:@"origin-id" namespace:@"urn:xmpp:sid:0" content:nil];
    [originID setValue:@"1245" forAttribute:@"id"];
    
    XCTAssertEqualObjects(message.originID, @"1245");
    
    message.originID = @"678";
    
    XCTAssertEqualObjects(message.originID, @"678");
}

- (void)testStanzaID {
    XMPPMessageStanza *message = [[XMPPMessageStanza alloc] initWithFrom:nil to:nil];
    
    PXElement *stanzaID = [message addElementWithName:@"stanza-id" namespace:@"urn:xmpp:sid:0" content:nil];
    [stanzaID setValue:@"1245" forAttribute:@"id"];
    [stanzaID setValue:@"romeo@example.com" forAttribute:@"by"];
    
    XCTAssertEqualObjects([message stanzaIDBy:JID(@"romeo@example.com/foo")], @"1245");
    XCTAssertEqualObjects([message stanzaIDBy:JID(@"romeo@example.com")], @"1245");
    XCTAssertNil([message stanzaIDBy:JID(@"juliet@example.com/foo")]);
}

@end
