//
//  XMPPStanza.h
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

@import Foundation;
@import PureXML;

@class XMPPJID;

NS_SWIFT_NAME(Stanza)
@interface XMPPStanza : PXElement
@property (nonatomic, readwrite, copy, nullable) XMPPJID *to;
@property (nonatomic, readwrite, copy, nullable) XMPPJID *from;
@property (nonatomic, readwrite, copy, nullable) NSString *identifier;
@property (nonatomic, readonly, nullable) NSError *error;
@end
