//
//  XMPPStanzaError.h
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 10.12.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
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
