//
//  XMPPDataForm.h
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


@import Foundation;
@import PureXML;

#import "XMPPDataFormField.h"

typedef NS_ENUM(NSUInteger, XMPPDataFormType) {
    XMPPDataFormTypeUndefined,
    XMPPDataFormTypeCancel,
    XMPPDataFormTypeForm,
    XMPPDataFormTypeResult,
    XMPPDataFormTypeSubmit
} NS_SWIFT_NAME(DataFormType);

NS_SWIFT_NAME(DataForm)
@interface XMPPDataForm : PXElement

@property (nonatomic, readwrite) NSString *_Nullable identifier;
@property (nonatomic, readwrite) XMPPDataFormType type;
@property (nonatomic, readwrite) NSString *_Nullable title;
@property (nonatomic, readwrite) NSString *_Nullable instructions;

#pragma mark Manage Fields
@property (nonatomic, readonly) NSArray<XMPPDataFormField *> *_Nonnull fields;
- (nonnull XMPPDataFormField *)addFieldWithType:(XMPPDataFormFieldType)type
                                     identifier:(nonnull NSString *)identifier NS_SWIFT_NAME(add(type:identifier:));
- (void)removeField:(nonnull XMPPDataFormField *)field NS_SWIFT_NAME(remove(_:));

- (nullable XMPPDataFormField *)fieldWithIdentifier:(nonnull NSString *)identifier NS_SWIFT_NAME(field(identifier:));
@end

@interface PXElement (XMPPDataForm)
- (nonnull XMPPDataForm *)addFormWith:(XMPPDataFormType)type identifier:(nullable NSString *)identifier;
@end
