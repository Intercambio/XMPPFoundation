//
//  XMPPDataForm.m
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


#import "XMPPDataForm.h"

@implementation XMPPDataForm

+ (void)load
{
    [PXDocument registerElementClass:[XMPPDataForm class]
                    forQualifiedName:PXQN(@"jabber:x:data", @"x")];
}

#pragma mark Properties

- (XMPPDataFormType)type
{
    NSString *typeString = [self valueForAttribute:@"type"];

    if ([typeString isEqualToString:@"cancel"]) {
        return XMPPDataFormTypeCancel;
    } else if ([typeString isEqualToString:@"form"]) {
        return XMPPDataFormTypeForm;
    } else if ([typeString isEqualToString:@"result"]) {
        return XMPPDataFormTypeResult;
    } else if ([typeString isEqualToString:@"submit"]) {
        return XMPPDataFormTypeSubmit;
    } else {
        return XMPPDataFormTypeUndefined;
    }
}

- (void)setType:(XMPPDataFormType)type
{
    switch (type) {
    case XMPPDataFormTypeCancel:
        [self setValue:@"cancel" forAttribute:@"type"];
        break;

    case XMPPDataFormTypeForm:
        [self setValue:@"form" forAttribute:@"type"];
        break;

    case XMPPDataFormTypeResult:
        [self setValue:@"result" forAttribute:@"type"];
        break;

    case XMPPDataFormTypeSubmit:
        [self setValue:@"submit" forAttribute:@"type"];
        break;

    default:
        [self setValue:nil forAttribute:@"type"];
        break;
    }
}

- (NSString *)title
{
    NSArray *nodes = [self nodesForXPath:@"./x:title" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    return [[nodes firstObject] stringValue];
}

- (void)setTitle:(NSString *)title
{
    NSArray *nodes = [self nodesForXPath:@"./x:title" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    for (PXElement *element in nodes) {
        [element removeFromParent];
    }

    if (title) {
        [self addElementWithName:@"title" namespace:@"jabber:x:data" content:title];
    }
}

- (NSString *)instructions
{
    NSArray *nodes = [self nodesForXPath:@"./x:instructions" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    return [[nodes firstObject] stringValue];
}

- (void)setInstructions:(NSString *)instructions
{
    NSArray *nodes = [self nodesForXPath:@"./x:instructions" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
    for (PXElement *element in nodes) {
        [element removeFromParent];
    }

    if (instructions) {
        [self addElementWithName:@"instructions" namespace:@"jabber:x:data" content:instructions];
    }
}

- (NSString *)identifier
{
    for (XMPPDataFormField *field in self.fields) {
        if (field.type == XMPPDataFormFieldTypeHidden &&
            [field.identifier isEqualToString:@"FORM_TYPE"] &&
            [field.value isKindOfClass:[NSString class]]) {
            return field.value;
        }
    }

    return nil;
}

- (void)setIdentifier:(NSString *)identifier
{
    for (XMPPDataFormField *field in self.fields) {
        if (field.type == XMPPDataFormFieldTypeHidden &&
            [field.identifier isEqualToString:@"FORM_TYPE"]) {
            [self removeField:field];
        }
    }

    if (identifier) {
        XMPPDataFormField *field = [self addFieldWithType:XMPPDataFormFieldTypeHidden identifier:@"FORM_TYPE"];
        field.value = identifier;
    }
}

#pragma mark Manage Fields

- (NSArray<XMPPDataFormField *> *)fields
{
    return [self nodesForXPath:@"./x:field" usingNamespaces:@{ @"x" : @"jabber:x:data" }];
}

- (XMPPDataFormField *)addFieldWithType:(XMPPDataFormFieldType)type
                             identifier:(NSString *)identifier
{
    XMPPDataFormField *field = (XMPPDataFormField *)[self addElementWithName:@"field"
                                                                   namespace:@"jabber:x:data"
                                                                     content:nil];
    if ([field isKindOfClass:[XMPPDataFormField class]]) {
        field.type = type;
        field.identifier = identifier;
    }
    return field;
}

- (void)removeField:(XMPPDataFormField *)field
{
    if (field.parent == self) {
        [field removeFromParent];
    }
}

- (XMPPDataFormField *)fieldWithIdentifier:(NSString *)identifier
{
    for (XMPPDataFormField *field in self.fields) {
        if ([field.identifier isEqualToString:identifier]) {
            return field;
        }
    }
    return nil;
}

@end

@implementation PXElement (XMPPDataForm)

- (nonnull XMPPDataForm *)addFormWith:(XMPPDataFormType)type identifier:(nullable NSString *)identifier {
    XMPPDataForm *form = (XMPPDataForm *)[self addElementWithName:@"x" namespace:@"jabber:x:data" content:nil];
    form.type = type;
    form.identifier = identifier;
    return  form;
}

@end
