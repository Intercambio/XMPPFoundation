//
//  XMPPIQStanza.h
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

@import Foundation;

#import "XMPPStanza.h"

typedef NS_ENUM(NSUInteger, XMPPIQStanzaType) {
    XMPPIQStanzaTypeUndefined,
    XMPPIQStanzaTypeGet,
    XMPPIQStanzaTypeSet,
    XMPPIQStanzaTypeResult,
    XMPPIQStanzaTypeError
} NS_SWIFT_NAME(IQStanzaType);

NS_SWIFT_NAME(IQStanza)
@interface XMPPIQStanza : XMPPStanza
- (nonnull instancetype)initWithType:(XMPPIQStanzaType)type
                                from:(nullable XMPPJID *)from
                                  to:(nullable XMPPJID *)to;

@property (nonatomic, readwrite) XMPPIQStanzaType type;

- (nonnull XMPPIQStanza *)response NS_SWIFT_NAME(makeResponse());
- (nonnull XMPPIQStanza *)responseWithError:(nullable NSError *)error NS_SWIFT_NAME(makeResponse(with:));

@end
