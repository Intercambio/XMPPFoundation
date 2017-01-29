//
//  XMPPMessageStanza.m
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


#import "XMPPMessageStanza.h"
#import "XMPPJID.h"

@implementation XMPPMessageStanza

+ (void)load
{
    [PXDocument registerElementClass:[XMPPMessageStanza class]
                    forQualifiedName:PXQN(@"jabber:client", @"message")];
}

+ (nonnull PXDocument *)documentWithMessageFrom:(nullable XMPPJID *)from to:(nullable XMPPJID *)to
{
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"message"
                                                         namespace:@"jabber:client"
                                                            prefix:nil];
    if ([document.root isKindOfClass:[XMPPMessageStanza class]]) {
        XMPPMessageStanza *message = (XMPPMessageStanza *)[document root];
        message.from = from;
        message.to = to;
        message.identifier = [[[NSUUID UUID] UUIDString] lowercaseString];
    }
    return document;
}

- (nonnull instancetype)initWithFrom:(nullable XMPPJID *)from to:(nullable XMPPJID *)to {
    PXDocument *document = [[PXDocument alloc] initWithElementName:@"message"
                                                         namespace:@"jabber:client"
                                                            prefix:nil];
    XMPPMessageStanza *message = (XMPPMessageStanza *)[document root];
    message.from = from;
    message.to = to;
    message.identifier = [[[NSUUID UUID] UUIDString] lowercaseString];
    return message;
}

- (XMPPMessageStanzaType)type
{
    NSString *typeString = [self valueForAttribute:@"type"];
    if ([typeString isEqualToString:@"chat"]) {
        return XMPPMessageStanzaTypeChat;
    } else if ([typeString isEqualToString:@"error"]) {
        return XMPPMessageStanzaTypeError;
    } else if ([typeString isEqualToString:@"groupchat"]) {
        return XMPPMessageStanzaTypeGroupchat;
    } else if ([typeString isEqualToString:@"headline"]) {
        return XMPPMessageStanzaTypeHeadline;
    } else if ([typeString isEqualToString:@"normal"]) {
        return XMPPMessageStanzaTypeNormal;
    } else {
        return XMPPMessageStanzaTypeUndefined;
    }
}

- (void)setType:(XMPPMessageStanzaType)type
{
    NSString *typeString = nil;
    switch (type) {
    case XMPPMessageStanzaTypeChat:
        typeString = @"chat";
        break;
    case XMPPMessageStanzaTypeError:
        typeString = @"error";
        break;
    case XMPPMessageStanzaTypeGroupchat:
        typeString = @"groupchat";
        break;
    case XMPPMessageStanzaTypeHeadline:
        typeString = @"headline";
        break;
    case XMPPMessageStanzaTypeNormal:
        typeString = @"normal";
        break;
    case XMPPMessageStanzaTypeUndefined:
    default:
        break;
    }
    [self setValue:typeString forAttribute:@"type"];
}

- (NSString *)originID {
    
    NSDictionary *namespaces = @{@"sid": @"urn:xmpp:sid:0"};
    
    PXElement *originID = [[self nodesForXPath:@"./sid:origin-id" usingNamespaces:namespaces] firstObject];
    if ([originID isKindOfClass:[PXElement class]]) {
        return [originID valueForAttribute:@"id"];
    } else {
        return nil;
    }
}

- (void)setOriginID:(NSString *)originID {
    
    NSDictionary *namespaces = @{@"sid": @"urn:xmpp:sid:0"};
    
    NSArray *nodes = [self nodesForXPath:@"./sid:origin-id" usingNamespaces:namespaces];
    for (PXNode *node in nodes) {
        if ([node isKindOfClass:[PXElement class]]) {
            [node removeFromParent];
        }
    }

    if (originID) {
        PXElement *originIDElement = [self addElementWithName:@"origin-id" namespace:@"urn:xmpp:sid:0" content:nil];
        [originIDElement setValue:originID forAttribute:@"id"];
    }
}

- (NSString *)stanzaIDBy:(XMPPJID *)by {
    NSString *jidString = [[by bareJID] stringValue];
    NSDictionary *namespaces = @{@"sid": @"urn:xmpp:sid:0"};
    for (PXElement *element in [self nodesForXPath:@"./sid:stanza-id" usingNamespaces:namespaces]) {
        if ([element isKindOfClass:[PXElement class]]) {
            if ([[element valueForAttribute:@"by"] isEqual:jidString]) {
                return [element valueForAttribute:@"id"];
            }
        }
    }
    return nil;
}

@end
