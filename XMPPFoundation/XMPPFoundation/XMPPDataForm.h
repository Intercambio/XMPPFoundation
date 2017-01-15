//
//  XMPPDataForm.h
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 26.06.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
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
