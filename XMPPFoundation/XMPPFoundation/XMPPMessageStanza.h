//
//  XMPPMessageStanza.h
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

@import Foundation;

#import "XMPPStanza.h"

typedef NS_ENUM(NSUInteger, XMPPMessageStanzaType) {
    XMPPMessageStanzaTypeUndefined,
    XMPPMessageStanzaTypeChat,
    XMPPMessageStanzaTypeError,
    XMPPMessageStanzaTypeGroupchat,
    XMPPMessageStanzaTypeHeadline,
    XMPPMessageStanzaTypeNormal
};

@interface XMPPMessageStanza : XMPPStanza
+ (nonnull PXDocument *)documentWithMessageFrom:(nullable XMPPJID *)from to:(nullable XMPPJID *)to;
@property (nonatomic, readwrite) XMPPMessageStanzaType type;
@end
