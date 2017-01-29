//
//  XMPPStanza.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
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


#import "XMPPStanza.h"
#import "XMPPJID.h"
#import "XMPPStanzaError.h"

@implementation XMPPStanza

- (XMPPJID *)to
{
    NSString *JIDString = [self valueForAttribute:@"to"];
    if (JIDString) {
        return [[XMPPJID alloc] initWithString:JIDString];
    } else {
        return nil;
    }
}

- (void)setTo:(XMPPJID *)to
{
    NSString *JIDString = [to stringValue];
    [self setValue:JIDString forAttribute:@"to"];
}

- (XMPPJID *)from
{
    NSString *JIDString = [self valueForAttribute:@"from"];
    if (JIDString) {
        return [[XMPPJID alloc] initWithString:JIDString];
    } else {
        return nil;
    }
}

- (void)setFrom:(XMPPJID *)from
{
    NSString *JIDString = [from stringValue];
    [self setValue:JIDString forAttribute:@"from"];
}

- (NSString *)identifier
{
    return [self valueForAttribute:@"id"];
}

- (void)setIdentifier:(NSString *)stanzaID
{
    [self setValue:stanzaID forAttribute:@"id"];
}

- (NSError *)error {
    __block NSError *error = nil;
    [self enumerateElementsUsingBlock:^(PXElement *element, BOOL *stop) {
        if ([element isKindOfClass:[XMPPStanzaError class]]) {
            XMPPStanzaError *stanzaError = (XMPPStanzaError *)element;
            error = stanzaError.error;
            *stop = YES;
        }
    }];
    return error;
}

- (void)setError:(NSError *)error {

    [self enumerateElementsUsingBlock:^(PXElement *element, BOOL *stop) {
        if ([element isKindOfClass:[XMPPStanzaError class]]) {
            [element removeFromParent];
            *stop = YES;
        }
    }];
    
    XMPPStanzaError *errorElement = (XMPPStanzaError *)[self addElementWithName:@"error" namespace:@"jabber:client" content:nil];
    
    errorElement.type = XMPPStanzaErrorTypeUndefined;
    if ([error.domain isEqualToString:XMPPStanzaErrorDomain]) {
        errorElement.code = error.code;
    } else {
        errorElement.code = XMPPStanzaErrorTypeUndefined;
    }
}

@end
