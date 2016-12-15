//
//  XMPPMessageStanzaTests.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
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

    PXDocument *document = [XMPPMessageStanza documentWithMessageFrom:from to:to];

    XCTAssertTrue([document.root isKindOfClass:[XMPPMessageStanza class]]);
    XMPPMessageStanza *message = (XMPPMessageStanza *)[document root];

    XCTAssertNotNil(message.identifier);
    XCTAssertEqualObjects(message.from, from);
    XCTAssertEqualObjects(message.to, to);

    XCTAssertEqual(message.type, XMPPMessageStanzaTypeUndefined);
}

- (void)testSetType
{
    PXDocument *document = [XMPPMessageStanza documentWithMessageFrom:nil to:nil];
    XMPPMessageStanza *message = (XMPPMessageStanza *)[document root];

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
    PXDocument *document = [XMPPMessageStanza documentWithMessageFrom:nil to:nil];
    XMPPMessageStanza *message = (XMPPMessageStanza *)[document root];

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
    PXDocument *document = [XMPPMessageStanza documentWithMessageFrom:nil to:nil];
    XMPPMessageStanza *message = (XMPPMessageStanza *)[document root];

    PXElement *originID = [message addElementWithName:@"origin-id" namespace:@"urn:xmpp:sid:0" content:nil];
    [originID setValue:@"1245" forAttribute:@"id"];
    
    XCTAssertEqualObjects(message.originID, @"1245");
}

- (void)testStanzaID {
    PXDocument *document = [XMPPMessageStanza documentWithMessageFrom:nil to:nil];
    XMPPMessageStanza *message = (XMPPMessageStanza *)[document root];
    
    PXElement *stanzaID = [message addElementWithName:@"stanza-id" namespace:@"urn:xmpp:sid:0" content:nil];
    [stanzaID setValue:@"1245" forAttribute:@"id"];
    [stanzaID setValue:@"romeo@example.com" forAttribute:@"by"];
    
    XCTAssertEqualObjects([message stanzaIDBy:JID(@"romeo@example.com/foo")], @"1245");
    XCTAssertEqualObjects([message stanzaIDBy:JID(@"romeo@example.com")], @"1245");
    XCTAssertNil([message stanzaIDBy:JID(@"juliet@example.com/foo")]);
}

@end
