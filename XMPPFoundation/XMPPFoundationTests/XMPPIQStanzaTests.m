//
//  XMPPIQStanzaTests.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XMPPFoundation/XMPPFoundation.h>

@interface XMPPIQStanzaTests : XCTestCase

@end

@implementation XMPPIQStanzaTests

- (void)testSetType
{
    PXDocument *document = [XMPPIQStanza documentWithIQFrom:nil to:nil];
    XMPPIQStanza *iq = (XMPPIQStanza *)[document root];

    iq.type = XMPPIQStanzaTypeUndefined;
    XCTAssertNil([iq valueForAttribute:@"type"]);

    iq.type = XMPPIQStanzaTypeGet;
    XCTAssertEqualObjects([iq valueForAttribute:@"type"], @"get");

    iq.type = XMPPIQStanzaTypeSet;
    XCTAssertEqualObjects([iq valueForAttribute:@"type"], @"set");

    iq.type = XMPPIQStanzaTypeError;
    XCTAssertEqualObjects([iq valueForAttribute:@"type"], @"error");

    iq.type = XMPPIQStanzaTypeResult;
    XCTAssertEqualObjects([iq valueForAttribute:@"type"], @"result");

    iq.type = XMPPIQStanzaTypeUndefined;
    XCTAssertNil([iq valueForAttribute:@"type"]);
}

- (void)testGetType
{
    PXDocument *document = [XMPPIQStanza documentWithIQFrom:nil to:nil];
    XMPPIQStanza *iq = (XMPPIQStanza *)[document root];

    XCTAssertEqual(iq.type, XMPPIQStanzaTypeUndefined);

    [iq setValue:@"get" forAttribute:@"type"];
    XCTAssertEqual(iq.type, XMPPIQStanzaTypeGet);

    [iq setValue:@"set" forAttribute:@"type"];
    XCTAssertEqual(iq.type, XMPPIQStanzaTypeSet);

    [iq setValue:@"error" forAttribute:@"type"];
    XCTAssertEqual(iq.type, XMPPIQStanzaTypeError);

    [iq setValue:@"result" forAttribute:@"type"];
    XCTAssertEqual(iq.type, XMPPIQStanzaTypeResult);

    [iq setValue:@"xxx" forAttribute:@"type"];
    XCTAssertEqual(iq.type, XMPPIQStanzaTypeUndefined);

    [iq setValue:nil forAttribute:@"type"];
    XCTAssertEqual(iq.type, XMPPIQStanzaTypeUndefined);
}

- (void)testErrorResponse
{
    PXDocument *document = [XMPPIQStanza documentWithIQFrom:JID(@"romeo@example.com")
                                                         to:JID(@"juliet@example.com")];
    
    XMPPIQStanza *request = (XMPPIQStanza *)[document root];
    request.identifier = @"123";
    
    NSError *error = [NSError errorWithDomain:XMPPStanzaErrorDomain
                                         code:XMPPStanzaErrorCodeNotAllowed
                                     userInfo:nil];
    
    XMPPIQStanza *response = [request responseWithError:error];
    
    XCTAssertEqualObjects(response.to, JID(@"romeo@example.com"));
    XCTAssertEqualObjects(response.from, JID(@"juliet@example.com"));
    XCTAssertEqualObjects(response.identifier, @"123");
    
    XCTAssertEqualObjects(response.error.domain, XMPPStanzaErrorDomain);
    XCTAssertEqual(response.error.code, XMPPStanzaErrorCodeNotAllowed);
}

@end
