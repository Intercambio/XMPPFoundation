//
//  XMPPMessageStanza.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
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
