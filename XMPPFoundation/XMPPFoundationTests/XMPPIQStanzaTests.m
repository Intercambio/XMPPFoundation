//
//  XMPPIQStanzaTests.m
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

@interface XMPPIQStanzaTests : XCTestCase

@end

@implementation XMPPIQStanzaTests

- (void)testSetType
{
    XMPPIQStanza *iq = [[XMPPIQStanza alloc] initWithType:XMPPIQStanzaTypeUndefined from:nil to:nil];

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
    XMPPIQStanza *iq = [[XMPPIQStanza alloc] initWithType:XMPPIQStanzaTypeUndefined from:nil to:nil];

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
    XMPPIQStanza *request = [[XMPPIQStanza alloc] initWithType:XMPPIQStanzaTypeGet
                                                          from:JID(@"romeo@example.com")
                                                            to:JID(@"juliet@example.com")];
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
