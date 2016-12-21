//
//  XMPPDataFormTests.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 26.06.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XMPPFoundation/XMPPFoundation.h>

@interface XMPPDataFormTests : XCTestCase

@end

@implementation XMPPDataFormTests

#pragma mark Tests

- (void)testElementSubclass
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"x" namespace:@"jabber:x:data" prefix:nil];
    XCTAssertTrue([document.root isKindOfClass:[XMPPDataForm class]]);
}

- (void)testFormType
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"x" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataForm *form = (XMPPDataForm *)document.root;

    form.type = XMPPDataFormTypeForm;
    XCTAssertEqualObjects([form valueForAttribute:@"type"], @"form");

    [form setValue:@"submit" forAttribute:@"type"];
    XCTAssertEqual(form.type, XMPPDataFormTypeSubmit);

    form.type = XMPPDataFormTypeUndefined;
    XCTAssertNil([form valueForAttribute:@"type"]);
}

- (void)testFormTitle
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"x" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataForm *form = (XMPPDataForm *)document.root;

    [form addElementWithName:@"title" namespace:@"jabber:x:data" content:@"My Form"];
    XCTAssertEqualObjects(form.title, @"My Form");

    form.title = @"Your Form";
    NSArray *titleElements = [form nodesForXPath:@"./x:title" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(titleElements.count, 1);

    NSString *title = [[titleElements firstObject] stringValue];
    XCTAssertEqualObjects(title, @"Your Form");
}

- (void)testFormInstructions
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"x" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataForm *form = (XMPPDataForm *)document.root;

    [form addElementWithName:@"instructions" namespace:@"jabber:x:data" content:@"Add your Data."];
    XCTAssertEqualObjects(form.instructions, @"Add your Data.");

    form.instructions = @"Please fillout the form.";
    NSArray *instructionsElements = [form nodesForXPath:@"./x:instructions" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    XCTAssertEqual(instructionsElements.count, 1);

    NSString *instructions = [[instructionsElements firstObject] stringValue];
    XCTAssertEqualObjects(instructions, @"Please fillout the form.");
}

- (void)testManageFields
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"x" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataForm *form = (XMPPDataForm *)document.root;

    XCTAssertEqual(form.fields.count, 0);

    [form addElementWithName:@"field" namespace:@"jabber:x:data" content:nil];
    [form addElementWithName:@"field" namespace:@"jabber:x:data" content:nil];

    XCTAssertEqual(form.fields.count, 2);
    
    for (XMPPDataFormField *field in form.fields) {
        [form removeField:field];
    }

    XCTAssertEqual(form.fields.count, 0);
    
    XMPPDataFormField *field = [form addFieldWithType:XMPPDataFormFieldTypeBoolean identifier:@"123"];
    
    XCTAssertEqualObjects(field.identifier, @"123");
    XCTAssertEqual(field.type, XMPPDataFormFieldTypeBoolean);
    XCTAssertTrue([form.fields containsObject:field]);
}

- (void)testNamespace
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"x" namespace:@"jabber:x:data" prefix:nil];
    XMPPDataForm *form = (XMPPDataForm *)document.root;

    XCTAssertNil(form.identifier);

    XMPPDataFormField *field = [form addFieldWithType:XMPPDataFormFieldTypeHidden identifier:@"FORM_TYPE"];
    field.value = @"http://example.com/ns_1";

    XCTAssertEqualObjects(form.identifier, @"http://example.com/ns_1");

    form.identifier = @"http://example.com/ns_2";

    XCTAssertEqualObjects([[form.fields firstObject] value], @"http://example.com/ns_2");
    XCTAssertEqualObjects([[form.fields firstObject] identifier], @"FORM_TYPE");
    XCTAssertEqual([[form.fields firstObject] type], XMPPDataFormFieldTypeHidden);
    
    form.identifier = nil;
    
    XCTAssertEqual(form.fields.count, 0);
}

@end
