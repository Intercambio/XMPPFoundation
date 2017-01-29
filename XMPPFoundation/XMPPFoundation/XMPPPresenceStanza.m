//
//  XMPPPresenceStanza.m
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


#import "XMPPPresenceStanza.h"

@implementation XMPPPresenceStanza

+ (void)load
{
    [PXDocument registerElementClass:[XMPPPresenceStanza class]
                    forQualifiedName:PXQN(@"jabber:client", @"presence")];
}

+ (nonnull PXDocument *)documentWithPresenceFrom:(nullable XMPPJID *)from to:(nullable XMPPJID *)to
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"presence"
                                                         namespace:@"jabber:client"
                                                            prefix:nil];
    if ([document.root isKindOfClass:[XMPPPresenceStanza class]]) {
        XMPPPresenceStanza *presence = (XMPPPresenceStanza *)[document root];
        presence.from = from;
        presence.to = to;
        presence.identifier = [[[NSUUID UUID] UUIDString] lowercaseString];
    }
    return document;
}

- (nonnull instancetype)initWithFrom:(nullable XMPPJID *)from to:(nullable XMPPJID *)to {
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"presence"
                                                         namespace:@"jabber:client"
                                                            prefix:nil];
    XMPPPresenceStanza *presence = (XMPPPresenceStanza *)[document root];
    presence.from = from;
    presence.to = to;
    presence.identifier = [[[NSUUID UUID] UUIDString] lowercaseString];
    return presence;
}

- (XMPPPresenceStanzaType)type
{
    NSString *typeString = [self valueForAttribute:@"type"];
    if ([typeString isEqualToString:@"error"]) {
        return XMPPPresenceStanzaTypeError;
    } else if ([typeString isEqualToString:@"probe"]) {
        return XMPPPresenceStanzaTypeProbe;
    } else if ([typeString isEqualToString:@"subscribe"]) {
        return XMPPPresenceStanzaTypeSubscribe;
    } else if ([typeString isEqualToString:@"subscribed"]) {
        return XMPPPresenceStanzaTypeSubscribed;
    } else if ([typeString isEqualToString:@"unavailable"]) {
        return XMPPPresenceStanzaTypeUnavailable;
    } else if ([typeString isEqualToString:@"unsubscribe"]) {
        return XMPPPresenceStanzaTypeUnsubscribe;
    } else if ([typeString isEqualToString:@"unsubscribed"]) {
        return XMPPPresenceStanzaTypeUnsubscribed;
    } else {
        return XMPPPresenceStanzaTypeUndefined;
    }
}

- (void)setType:(XMPPPresenceStanzaType)type
{
    NSString *typeString = nil;
    switch (type) {
    case XMPPPresenceStanzaTypeError:
        typeString = @"error";
        break;
    case XMPPPresenceStanzaTypeProbe:
        typeString = @"probe";
        break;
    case XMPPPresenceStanzaTypeSubscribe:
        typeString = @"subscribe";
        break;
    case XMPPPresenceStanzaTypeSubscribed:
        typeString = @"subscribed";
        break;
    case XMPPPresenceStanzaTypeUnavailable:
        typeString = @"unavailable";
        break;
    case XMPPPresenceStanzaTypeUnsubscribe:
        typeString = @"unsubscribe";
        break;
    case XMPPPresenceStanzaTypeUnsubscribed:
        typeString = @"unsubscribed";
        break;
    case XMPPPresenceStanzaTypeUndefined:
    default:
        break;
    }
    [self setValue:typeString forAttribute:@"type"];
}

@end
