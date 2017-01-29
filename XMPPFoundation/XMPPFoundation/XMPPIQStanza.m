//
//  XMPPIQStanza.m
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


#import "XMPPIQStanza.h"

@implementation XMPPIQStanza

+ (void)load
{
    [PXDocument registerElementClass:[XMPPIQStanza class]
                    forQualifiedName:PXQN(@"jabber:client", @"iq")];
}

+ (nonnull PXDocument *)documentWithIQFrom:(nullable XMPPJID *)from to:(nullable XMPPJID *)to
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"iq"
                                                         namespace:@"jabber:client"
                                                            prefix:nil];
    if ([document.root isKindOfClass:[XMPPIQStanza class]]) {
        XMPPIQStanza *iq = (XMPPIQStanza *)[document root];
        iq.from = from;
        iq.to = to;
        iq.identifier = [[[NSUUID UUID] UUIDString] lowercaseString];
    }
    return document;
}

- (nonnull instancetype)initWithType:(XMPPIQStanzaType)type
                                from:(nullable XMPPJID *)from
                                  to:(nullable XMPPJID *)to
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"iq"
                                                         namespace:@"jabber:client"
                                                            prefix:nil];
    
    XMPPIQStanza *iq = (XMPPIQStanza *)[document root];
    iq.from = from;
    iq.to = to;
    iq.type = type;
    iq.identifier = [[[NSUUID UUID] UUIDString] lowercaseString];
    return iq;
}

- (XMPPIQStanzaType)type
{
    NSString *typeString = [self valueForAttribute:@"type"];
    if ([typeString isEqualToString:@"get"]) {
        return XMPPIQStanzaTypeGet;
    } else if ([typeString isEqualToString:@"set"]) {
        return XMPPIQStanzaTypeSet;
    } else if ([typeString isEqualToString:@"error"]) {
        return XMPPIQStanzaTypeError;
    } else if ([typeString isEqualToString:@"result"]) {
        return XMPPIQStanzaTypeResult;
    } else {
        return XMPPIQStanzaTypeUndefined;
    }
}

- (void)setType:(XMPPIQStanzaType)type
{
    NSString *typeString = nil;
    switch (type) {
    case XMPPIQStanzaTypeGet:
        typeString = @"get";
        break;
    case XMPPIQStanzaTypeSet:
        typeString = @"set";
        break;
    case XMPPIQStanzaTypeError:
        typeString = @"error";
        break;
    case XMPPIQStanzaTypeResult:
        typeString = @"result";
        break;
    case XMPPIQStanzaTypeUndefined:
    default:
        break;
    }
    [self setValue:typeString forAttribute:@"type"];
}

- (nonnull XMPPIQStanza *)response {
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"iq"
                                                         namespace:@"jabber:client"
                                                            prefix:nil];
    XMPPIQStanza *iq = (XMPPIQStanza *)[document root];
    iq.from = self.to;
    iq.to = self.from;
    iq.identifier = self.identifier;
    iq.type = XMPPIQStanzaTypeResult;
    return iq;
}

- (nonnull XMPPIQStanza *)responseWithError:(nullable NSError *)error {
    XMPPIQStanza *iq = [self response];
    iq.error = error;
    iq.type = XMPPIQStanzaTypeError;
    return iq;
}

@end
