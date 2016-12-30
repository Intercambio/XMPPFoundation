//
//  XMPPFeature.h
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 30.12.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Feature)
@interface XMPPFeature : NSObject <NSCopying>

#pragma mark Life-cycle
- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithIdentifier:(nonnull NSString *)identifier;

#pragma mark Feature Properties
@property (nonatomic, readonly, nonnull) NSString *identifier;

@end
