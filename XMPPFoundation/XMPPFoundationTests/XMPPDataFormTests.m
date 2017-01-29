//
//  XMPPDataFormTests.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 26.06.16.
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
