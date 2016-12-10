//
//  XMPPStanzaError.m
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 10.12.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import "XMPPStanzaError.h"

NSString * const XMPPStanzaErrorDomain = @"XMPPStanzaErrorDomain";
NSString * const XMPPStanzaErrorDocumentKey = @"XMPPStanzaErrorDocumentKey";
NSString * const XMPPStanzaErrorTypeKey = @"XMPPStanzaErrorTypeKey";

@implementation XMPPStanzaError

+ (NSDictionary *)xmpp_stanzaErrorCodesByErrorName
{
    return @{ @"bad-request" : @(XMPPStanzaErrorCodeBadRequest),
              @"conflict" : @(XMPPStanzaErrorCodeConflict),
              @"feature-not-implemented" : @(XMPPStanzaErrorCodeFeatureNotImplemented),
              @"forbidden" : @(XMPPStanzaErrorCodeForbidden),
              @"gone" : @(XMPPStanzaErrorCodeGone),
              @"internal-server-error" : @(XMPPStanzaErrorCodeInternalServerError),
              @"item-not-found" : @(XMPPStanzaErrorCodeItemNotFound),
              @"jid-malformed" : @(XMPPStanzaErrorCodeJIDMalformed),
              @"not-acceptable" : @(XMPPStanzaErrorCodeNotAcceptable),
              @"not-allowed" : @(XMPPStanzaErrorCodeNotAllowed),
              @"not-authorized" : @(XMPPStanzaErrorCodeNotAuthorithed),
              @"policy-violation" : @(XMPPStanzaErrorCodePolicyViolation),
              @"recipient-unavailable" : @(XMPPStanzaErrorCodeRecipientUnavailable),
              @"redirect" : @(XMPPStanzaErrorCodeRedirect),
              @"registration-required" : @(XMPPStanzaErrorCodeRegistrationRequired),
              @"remote-server-not-found" : @(XMPPStanzaErrorCodeRemoteServerNotFound),
              @"remote-server-timeout" : @(XMPPStanzaErrorCodeRemoteServerTimeout),
              @"resource-constraint" : @(XMPPStanzaErrorCodeResourceConstraint),
              @"service-unavailable" : @(XMPPStanzaErrorCodeServiceUnavailable),
              @"subscription-required" : @(XMPPStanzaErrorCodeSubscriptionRequired),
              @"undefined-condition" : @(XMPPStanzaErrorCodeUndefinedCondition),
              @"unexpected-request" : @(XMPPStanzaErrorCodeUnexpectedRequest) };
}

+ (NSDictionary *)xmpp_descriptionByStanzaErrorCodes
{
    return @{ @(XMPPStanzaErrorCodeBadRequest) : @"Bad Request",
              @(XMPPStanzaErrorCodeConflict) : @"Conflict",
              @(XMPPStanzaErrorCodeFeatureNotImplemented) : @"Feature not implemented",
              @(XMPPStanzaErrorCodeForbidden) : @"Forbidden",
              @(XMPPStanzaErrorCodeGone) : @"Gone",
              @(XMPPStanzaErrorCodeInternalServerError) : @"Internal Server Error",
              @(XMPPStanzaErrorCodeItemNotFound) : @"Item not found",
              @(XMPPStanzaErrorCodeJIDMalformed) : @"JID malformed",
              @(XMPPStanzaErrorCodeNotAcceptable) : @"Not acceptable",
              @(XMPPStanzaErrorCodeNotAllowed) : @"Not allowed",
              @(XMPPStanzaErrorCodeNotAuthorithed) : @"Not authorized",
              @(XMPPStanzaErrorCodePolicyViolation) : @"Policy violation",
              @(XMPPStanzaErrorCodeRecipientUnavailable) : @"Recipient unavailable",
              @(XMPPStanzaErrorCodeRedirect) : @"Redirect",
              @(XMPPStanzaErrorCodeRegistrationRequired) : @"Registration required",
              @(XMPPStanzaErrorCodeRemoteServerNotFound) : @"Remote Server not found",
              @(XMPPStanzaErrorCodeRemoteServerTimeout) : @"Remote Server Timeout",
              @(XMPPStanzaErrorCodeResourceConstraint) : @"Resource Constraint",
              @(XMPPStanzaErrorCodeServiceUnavailable) : @"Service unavailable",
              @(XMPPStanzaErrorCodeSubscriptionRequired) : @"Subscription required",
              @(XMPPStanzaErrorCodeUndefinedCondition) : @"Undefined Condition",
              @(XMPPStanzaErrorCodeUnexpectedRequest) : @"Unexpected Request" };
}

+ (void)load
{
    [PXDocument registerElementClass:[XMPPStanzaError class]
                    forQualifiedName:PXQN(@"jabber:client", @"error")];
}

- (XMPPStanzaErrorType)type
{
    NSString *typeString = [self valueForAttribute:@"type"];
    if ([typeString isEqualToString:@"auth"]) {
        return XMPPStanzaErrorTypeAuth;
    } else if ([typeString isEqualToString:@"cancel"]) {
        return XMPPStanzaErrorTypeCancel;
    } else if ([typeString isEqualToString:@"continue"]) {
        return XMPPStanzaErrorTypeContinue;
    } else if ([typeString isEqualToString:@"modify"]) {
        return XMPPStanzaErrorTypeModify;
    } else if ([typeString isEqualToString:@"wait"]) {
        return XMPPStanzaErrorTypeWait;
    } else {
        return XMPPStanzaErrorTypeUndefined;
    }
}

- (void)setType:(XMPPStanzaErrorType)type
{
    NSString *typeString = nil;
    switch (type) {
        case XMPPStanzaErrorTypeAuth:
            typeString = @"auth";
            break;
        case XMPPStanzaErrorTypeCancel:
            typeString = @"cancel";
            break;
        case XMPPStanzaErrorTypeContinue:
            typeString = @"continue";
            break;
        case XMPPStanzaErrorTypeModify:
            typeString = @"modify";
            break;
        case XMPPStanzaErrorTypeWait:
            typeString = @"wait";
            break;
        case XMPPStanzaErrorTypeUndefined:
        default:
            break;
    }
    [self setValue:typeString forAttribute:@"type"];
}

- (XMPPStanzaErrorCode)code {
    if (self.numberOfElements > 0) {
        PXElement *definedCondition = [self elementAtIndex:0];
        if ([definedCondition.namespace isEqual: @"urn:ietf:params:xml:ns:xmpp-stanzas"]) {
            NSDictionary *errorCodes = [[self class] xmpp_stanzaErrorCodesByErrorName];
            return [errorCodes[definedCondition.name] integerValue] ?: XMPPStanzaErrorCodeUndefinedCondition;
        }
    }
    return XMPPStanzaErrorCodeUndefinedCondition;
}

- (NSString *)text {
    __block NSString *text = nil;
    [self enumerateElementsUsingBlock:^(PXElement *element, BOOL *stop) {
        if ([element.qualifiedName isEqual:PXQN(@"urn:ietf:params:xml:ns:xmpp-stanzas", @"text")]) {
            text = element.stringValue;
            *stop = YES;
        }
    }];
    return text;
}

- (NSError *)error {
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    
    NSInteger code = self.code;
    NSString *text = self.text;
    
    NSDictionary *errorDescriptions = [[self class] xmpp_descriptionByStanzaErrorCodes];
    
    userInfo[NSLocalizedDescriptionKey] = text ?: errorDescriptions[@(code)];
    userInfo[XMPPStanzaErrorTypeKey] = @(self.type);
    userInfo[XMPPStanzaErrorDocumentKey] = [[PXDocument alloc] initWithElement:self];
    
    return [NSError errorWithDomain:XMPPStanzaErrorDomain
                               code:code
                           userInfo:userInfo];
}

@end
