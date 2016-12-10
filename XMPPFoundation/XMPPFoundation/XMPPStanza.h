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

@interface XMPPStanza : PXElement
@property (nonatomic, readwrite, copy, nullable) XMPPJID *to;
@property (nonatomic, readwrite, copy, nullable) XMPPJID *from;
@property (nonatomic, readwrite, copy, nullable) NSString *stanzaID;
@property (nonatomic, readonly, nullable) NSError *error;
@end
