//
//  XMPPDataFormFieldTests.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 27.06.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XMPPFoundation/XMPPFoundation.h>

@interface XMPPDataFormFieldTests : XCTestCase

@end

@implementation XMPPDataFormFieldTests

#pragma mark Tests

- (void)testElementSubclass
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XCTAssertTrue([document.root isKindOfClass:[XMPPDataFormField class]]);
}

- (void)testFieldIdentifier
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;

    field.identifier = @"123";
    XCTAssertEqualObjects([field valueForAttribute:@"var"], @"123");

    [field setValue:@"234" forAttribute:@"var"];
    XCTAssertEqualObjects(field.identifier, @"234");

    field.identifier = nil;
    XCTAssertNil([field valueForAttribute:@"var"]);
}

- (void)testFieldType
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;

    field.type = XMPPDataFormFieldTypeBoolean;
    XCTAssertEqualObjects([field valueForAttribute:@"type"], @"boolean");

    [field setValue:@"jid-multi" forAttribute:@"type"];
    XCTAssertEqual(field.type, field.type);

    field.type = XMPPDataFormFieldTypeUndefined;
    XCTAssertNil([field valueForAttribute:@"type"]);
}

- (void)testLabel
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;

    field.label = @"Some Data";
    XCTAssertEqualObjects([field valueForAttribute:@"label"], @"Some Data");

    [field setValue:@"More Data" forAttribute:@"label"];
    XCTAssertEqualObjects(field.label, @"More Data");

    field.label = nil;
    XCTAssertNil([field valueForAttribute:@"label"]);
}

- (void)testText
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;

    [field addElementWithName:@"description" namespace:@"jabber:x:data" content:@"Add something …"];
    XCTAssertEqualObjects(field.text, @"Add something …");

    field.text = @"Please add something.";
    NSArray *descriptionElements = [field nodesForXPath:@"./x:description" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(descriptionElements.count, 1);

    NSString *text = [[descriptionElements firstObject] stringValue];
    XCTAssertEqualObjects(text, @"Please add something.");

    field.text = nil;
    descriptionElements = [field nodesForXPath:@"./x:description" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(descriptionElements.count, 0);
}

- (void)testRequired
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;

    XCTAssertFalse(field.required);

    [field addElementWithName:@"required" namespace:@"jabber:x:data" content:nil];
    XCTAssertTrue(field.required);
    
    field.required = NO;
    NSArray *requiredElements = [field nodesForXPath:@"./x:required" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(requiredElements.count, 0);

    field.required = YES;
    requiredElements = [field nodesForXPath:@"./x:required" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(requiredElements.count, 1);
}

- (void)testManageOptions
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;

    XCTAssertEqual(field.options.count, 0);
    
    [field addElementWithName:@"option" namespace:@"jabber:x:data" content:nil];
    [field addElementWithName:@"option" namespace:@"jabber:x:data" content:nil];

    XCTAssertEqual(field.options.count, 2);

    for (XMPPDataFormOption *option in field.options) {
        [field removeOption:option];
    }

    XCTAssertEqual(field.options.count, 0);

    XMPPDataFormOption *option = [field addOptionWithLabel:@"#1"];
    XCTAssertEqualObjects(option.label, @"#1");
    XCTAssertTrue([field.options containsObject:option]);
}

- (void)testBooleanValue
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;
    field.type = XMPPDataFormFieldTypeBoolean;

    field.value = @(YES);

    NSArray *valueElements = [field nodesForXPath:@"./x:value" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(valueElements.count, 1);

    PXElement *value = [valueElements firstObject];
    XCTAssertEqualObjects(value.stringValue, @"true");

    field.value = @(NO);

    valueElements = [field nodesForXPath:@"./x:value" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(valueElements.count, 1);

    value = [valueElements firstObject];
    XCTAssertEqualObjects(value.stringValue, @"false");

    field.value = nil;
    valueElements = [field nodesForXPath:@"./x:value" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(valueElements.count, 0);

    field.value = @(YES);
    valueElements = [field nodesForXPath:@"./x:value" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    value = [valueElements firstObject];

    [value setStringValue:@"false"];
    XCTAssertEqualObjects(field.value, @NO);

    [value setStringValue:@"true"];
    XCTAssertEqualObjects(field.value, @YES);

    [value setStringValue:@"0"];
    XCTAssertEqualObjects(field.value, @NO);

    [value setStringValue:@"1"];
    XCTAssertEqualObjects(field.value, @YES);
}

- (void)testHiddenValue
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;
    field.type = XMPPDataFormFieldTypeHidden;

    field.value = @"some value";

    NSArray *valueElements = [field nodesForXPath:@"./x:value" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(valueElements.count, 1);

    PXElement *value = [valueElements firstObject];
    XCTAssertEqualObjects(value.stringValue, @"some value");

    [value setStringValue:@"some other value"];
    XCTAssertEqualObjects(value.stringValue, @"some other value");
}

- (void)testJIDMultiValue
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;
    field.type = XMPPDataFormFieldTypeJIDMulti;

    field.value = @[ JID(@"romeo@example.com"), JID(@"juliet@example.com") ];

    NSArray *valueElements = [field nodesForXPath:@"./x:value" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(valueElements.count, 2);

    PXElement *value = [valueElements firstObject];
    XCTAssertEqualObjects(value.stringValue, @"romeo@example.com");

    value = [valueElements lastObject];
    XCTAssertEqualObjects(value.stringValue, @"juliet@example.com");

    [field addElementWithName:@"value" namespace:@"jabber:x:data" content:@"test@example.com"];

    XCTAssertEqual([field.value count], 3);
    XCTAssertTrue([field.value containsObject:JID(@"romeo@example.com")]);
    XCTAssertTrue([field.value containsObject:JID(@"juliet@example.com")]);
    XCTAssertTrue([field.value containsObject:JID(@"test@example.com")]);
}

- (void)testJIDSingleValue
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"field" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataFormField *field = (XMPPDataFormField *)document.root;
    field.type = XMPPDataFormFieldTypeJIDSingle;

    field.value = JID(@"romeo@example.com");

    NSArray *valueElements = [field nodesForXPath:@"./x:value" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(valueElements.count, 1);

    PXElement *value = [valueElements firstObject];
    XCTAssertEqualObjects(value.stringValue, @"romeo@example.com");

    [value setStringValue:@"juliet@example.com"];
    XCTAssertEqualObjects(field.value, JID(@"juliet@example.com"));
}

@end
