//
//  XMPPStanzaError.m
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

- (void)setCode:(XMPPStanzaErrorCode)code {
    if (self.numberOfElements > 0) {
        PXElement *definedCondition = [self elementAtIndex:0];
        if ([definedCondition.namespace isEqual: @"urn:ietf:params:xml:ns:xmpp-stanzas"]) {
            [definedCondition removeFromParent];
        }
    }
    
    __block NSString *errorName = @"undefined-condition";
    NSDictionary *errorCodes = [[self class] xmpp_stanzaErrorCodesByErrorName];
    [errorCodes enumerateKeysAndObjectsUsingBlock:^(NSString *name, NSNumber *codeValue, BOOL * _Nonnull stop) {
        if ([codeValue integerValue] == code) {
            errorName = name;
            *stop = YES;
        }
    }];
    
    [self addElementWithName:errorName
                   namespace:@"urn:ietf:params:xml:ns:xmpp-stanzas"
                     content:nil];
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

@implementation NSError (XMPPStanzaError)

+ (nullable instancetype)errorWithElement:(nonnull PXElement *)element
{
    XMPPStanzaErrorCode code = XMPPStanzaErrorCodeUndefinedCondition;
    if ([element.namespace isEqual: @"urn:ietf:params:xml:ns:xmpp-stanzas"]) {
        NSDictionary *errorCodes = [XMPPStanzaError xmpp_stanzaErrorCodesByErrorName];
        code = [errorCodes[element.name] integerValue] ?: XMPPStanzaErrorCodeUndefinedCondition;
    }
    return  [NSError errorWithDomain:XMPPStanzaErrorDomain code:code userInfo:nil];
}

@end
