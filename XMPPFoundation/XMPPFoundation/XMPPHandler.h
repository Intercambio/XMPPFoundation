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

NS_SWIFT_NAME(DispatcherHandler)
@protocol XMPPDispatcherHandler <NSObject>
@optional
- (void)didAddConnectionTo:(nonnull XMPPJID *)JID NS_SWIFT_NAME(didAddConnection(_:));
- (void)didRemoveConnectionTo:(nonnull XMPPJID *)JID NS_SWIFT_NAME(didRemoveConnection(_:));
- (void)didConnect:(nonnull XMPPJID *)JID resumed:(BOOL)resumed;
- (void)didDisconnect:(nonnull XMPPJID *)JID;
@end

NS_SWIFT_NAME(IQHandler)
@protocol XMPPIQHandler <NSObject>
- (void)handleIQRequest:(nonnull PXDocument *)document
                timeout:(NSTimeInterval)timeout
             completion:(nullable void (^)(PXDocument *_Nullable response, NSError *_Nullable error))completion;
@end

NS_SWIFT_NAME(MessageHandler)
@protocol XMPPMessageHandler <NSObject>
- (void)handleMessage:(nonnull PXDocument *)document
           completion:(nullable void (^)(NSError *_Nullable error))completion;
@end

NS_SWIFT_NAME(PresenceHandler)
@protocol XMPPPresenceHandler <NSObject>
- (void)handlePresence:(nonnull PXDocument *)document
            completion:(nullable void (^)(NSError *_Nullable error))completion;
@end
