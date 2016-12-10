//
//  XMPPPresenceStanza.h
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

@import Foundation;

#import "XMPPStanza.h"

typedef NS_ENUM(NSUInteger, XMPPPresenceStanzaType) {
    XMPPPresenceStanzaTypeUndefined,
    XMPPPresenceStanzaTypeError,
    XMPPPresenceStanzaTypeProbe,
    XMPPPresenceStanzaTypeSubscribe,
    XMPPPresenceStanzaTypeSubscribed,
    XMPPPresenceStanzaTypeUnavailable,
    XMPPPresenceStanzaTypeUnsubscribe,
    XMPPPresenceStanzaTypeUnsubscribed
} NS_SWIFT_NAME(PresenceStanzaType);

NS_SWIFT_NAME(PresenceStanza)
@interface XMPPPresenceStanza : XMPPStanza
+ (nonnull PXDocument *)documentWithPresenceFrom:(nullable XMPPJID *)from to:(nullable XMPPJID *)to NS_SWIFT_NAME(makeDocumentWithPresenceStanza(from:to:));
@property (nonatomic, readwrite) XMPPPresenceStanzaType type;
@end
