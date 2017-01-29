//
//  XMPPDataFormOptionTests.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 27.06.16.
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

@interface XMPPDataFormOptionTests : XCTestCase

@end

@implementation XMPPDataFormOptionTests

#pragma mark Tests

- (void)testElementSubclass
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"option" namespace:@"jabber:x:data" prefix:nil];
    XCTAssertTrue([document.root isKindOfClass:[XMPPDataFormOption class]]);
}

- (void)testLabel
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"option" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormOption *option = (XMPPDataFormOption *)document.root;

    [option setValue:@"Password" forAttribute:@"label"];
    XCTAssertEqualObjects(option.label, @"Password");

    option.label = @"Your Password";
    XCTAssertEqualObjects([option valueForAttribute:@"label"], @"Your Password");
    
    option.label = nil;
    XCTAssertNil([option valueForAttribute:@"label"]);
}

- (void)testValue
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"option" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormOption *option = (XMPPDataFormOption *)document.root;

    XCTAssertNil(option.value);
    option.value = @"123";

    NSArray *valueElements = [option nodesForXPath:@"./x:value" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual([valueElements count], 1);
    XCTAssertEqualObjects([[valueElements firstObject] stringValue], @"123");

    [[valueElements firstObject] setStringValue:@"234"];
    XCTAssertEqualObjects(option.value, @"234");
}

@end
