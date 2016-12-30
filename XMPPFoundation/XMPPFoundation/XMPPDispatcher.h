//
//  XMPPHandler.h
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 10.12.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

@import Foundation;
@import PureXML;

@class XMPPJID;
@class XMPPFeature;

NS_SWIFT_NAME(Handler)
@protocol XMPPHandler
@end

NS_SWIFT_NAME(ConnectionHandler)
@protocol XMPPConnectionHandler <XMPPHandler>
- (void)didConnect:(nonnull XMPPJID *)JID resumed:(BOOL)resumed features:(nullable NSArray<XMPPFeature *> *)features;
- (void)didDisconnect:(nonnull XMPPJID *)JID;
@end

NS_SWIFT_NAME(MessageHandler)
@protocol XMPPMessageHandler <XMPPHandler>
- (void)handleMessage:(nonnull XMPPMessageStanza *)stanza
           completion:(nullable void (^)(NSError *_Nullable error))completion;
@end

NS_SWIFT_NAME(PresenceHandler)
@protocol XMPPPresenceHandler <XMPPHandler>
- (void)handlePresence:(nonnull XMPPPresenceStanza *)stanza
            completion:(nullable void (^)(NSError *_Nullable error))completion;
@end

NS_SWIFT_NAME(IQHandler)
@protocol XMPPIQHandler <XMPPHandler>
- (void)handleIQRequest:(nonnull XMPPIQStanza *)stanza
                timeout:(NSTimeInterval)timeout
             completion:(nullable void (^)(XMPPIQStanza *_Nullable stanza, NSError *_Nullable error))completion;
@end

NS_SWIFT_NAME(Dispatcher)
@protocol XMPPDispatcher <XMPPConnectionHandler, XMPPMessageHandler, XMPPPresenceHandler, XMPPIQHandler>
- (void)addHandler:(nonnull id<XMPPHandler>)handler;
- (void)addHandler:(nonnull id<XMPPHandler>)handler withIQQueryQNames:(nullable NSArray<PXQName *> *)queryQNames features:(nullable NSArray<XMPPFeature *> *)features;
- (void)removeHandler:(nonnull id<XMPPHandler>)handler;
@end
