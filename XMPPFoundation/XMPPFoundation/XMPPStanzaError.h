//
//  XMPPStanzaError.h
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 10.12.16.
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

extern NSString * _Nonnull const XMPPStanzaErrorDomain NS_SWIFT_NAME(StanzaErrorDomain);
extern NSString * _Nonnull const XMPPStanzaErrorDocumentKey NS_SWIFT_NAME(StanzaErrorDocumentKey);
extern NSString * _Nonnull const XMPPStanzaErrorTypeKey NS_SWIFT_NAME(StanzaErrorTypeKey);

typedef NS_ENUM(NSInteger, XMPPStanzaErrorCode) {
    XMPPStanzaErrorCodeBadRequest,            // bad-request
    XMPPStanzaErrorCodeConflict,              // conflict
    XMPPStanzaErrorCodeFeatureNotImplemented, // feature-not-implemented
    XMPPStanzaErrorCodeForbidden,             // forbidden
    XMPPStanzaErrorCodeGone,                  // gone
    XMPPStanzaErrorCodeInternalServerError,   // internal-server-error
    XMPPStanzaErrorCodeItemNotFound,          // item-not-found
    XMPPStanzaErrorCodeJIDMalformed,          // jid-malformed
    XMPPStanzaErrorCodeNotAcceptable,         // not-acceptable
    XMPPStanzaErrorCodeNotAllowed,            // not-allowed
    XMPPStanzaErrorCodeNotAuthorithed,        // not-authorized
    XMPPStanzaErrorCodePolicyViolation,       // policy-violation
    XMPPStanzaErrorCodeRecipientUnavailable,  // recipient-unavailable
    XMPPStanzaErrorCodeRedirect,              // redirect
    XMPPStanzaErrorCodeRegistrationRequired,  // registration-required
    XMPPStanzaErrorCodeRemoteServerNotFound,  // remote-server-not-found
    XMPPStanzaErrorCodeRemoteServerTimeout,   // remote-server-timeout
    XMPPStanzaErrorCodeResourceConstraint,    // resource-constraint
    XMPPStanzaErrorCodeServiceUnavailable,    // service-unavailable
    XMPPStanzaErrorCodeSubscriptionRequired,  // subscription-required
    XMPPStanzaErrorCodeUndefinedCondition,    // undefined-condition
    XMPPStanzaErrorCodeUnexpectedRequest      // unexpected-request
} NS_SWIFT_NAME(StanzaErrorCode);

typedef NS_ENUM(NSInteger, XMPPStanzaErrorType) {
    XMPPStanzaErrorTypeUndefined,
    XMPPStanzaErrorTypeAuth,
    XMPPStanzaErrorTypeCancel,
    XMPPStanzaErrorTypeContinue,
    XMPPStanzaErrorTypeModify,
    XMPPStanzaErrorTypeWait
} NS_SWIFT_NAME(StanzaErrorType);

NS_SWIFT_NAME(StanzaError)
@interface XMPPStanzaError : PXElement

@property (nonatomic, readwrite) XMPPStanzaErrorType type;
@property (nonatomic, readwrite) XMPPStanzaErrorCode code;
@property (nonatomic, readonly, nullable) NSString *text;

@property (nonatomic, readonly, nonnull) NSError *error;

@end

@interface NSError (XMPPStanzaError)
+ (nullable instancetype)errorWithElement:(nonnull PXElement *)element;
@end
