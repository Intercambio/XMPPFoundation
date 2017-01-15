//
//  XMPPDataFormOptionTests.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 27.06.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
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
