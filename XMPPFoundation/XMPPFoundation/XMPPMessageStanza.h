//
//  XMPPMessageStanza.h
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


@import Foundation;

#import "XMPPStanza.h"

typedef NS_ENUM(NSUInteger, XMPPMessageStanzaType) {
    XMPPMessageStanzaTypeUndefined,
    XMPPMessageStanzaTypeChat,
    XMPPMessageStanzaTypeError,
    XMPPMessageStanzaTypeGroupchat,
    XMPPMessageStanzaTypeHeadline,
    XMPPMessageStanzaTypeNormal
} NS_SWIFT_NAME(MessageStanzaType);

NS_SWIFT_NAME(MessageStanza)
@interface XMPPMessageStanza : XMPPStanza
- (nonnull instancetype)initWithFrom:(nullable XMPPJID *)from to:(nullable XMPPJID *)to;
@property (nonatomic, readwrite) XMPPMessageStanzaType type;
@property (nonatomic, readwrite, nullable) NSString *originID;
- (nullable NSString *)stanzaIDBy:(nonnull XMPPJID *)by;
@end
