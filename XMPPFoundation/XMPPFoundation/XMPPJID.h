//
//  XMPPJID.h
//  CoreXMPP
//
//  Created by Tobias Kräntzer on 18.01.16.
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


#import <Foundation/Foundation.h>

#define JID(x) [[XMPPJID alloc] initWithString:x]

NS_SWIFT_NAME(JID)
@interface XMPPJID : NSObject <NSCopying>

#pragma mark Life-cycle
- (nonnull instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithString:(nullable NSString *)string NS_SWIFT_NAME(init(_:));

- (nonnull instancetype)initWithUser:(nullable NSString *)user
                                 host:(nonnull NSString *)host
                             resource:(nullable NSString *)resource NS_DESIGNATED_INITIALIZER;

#pragma mark JID Properties
@property (readonly) NSString *_Nullable user;
@property (readonly) NSString *_Nonnull host;
@property (readonly) NSString *_Nullable resource;

#pragma mark String Value
@property (readonly) NSString *_Nonnull stringValue;

#pragma mark Bare or Full JID
- (nonnull instancetype)bareJID;
- (nonnull instancetype)fullJIDWithResource:(nonnull NSString *)resource NS_SWIFT_NAME(fullJID(resource:));

@end
