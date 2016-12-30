//
//  XMPPFeature.m
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 30.12.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import "XMPPFeature.h"

@implementation XMPPFeature

- (nonnull instancetype)initWithIdentifier:(nonnull NSString *)identifier
{
    self = [super init];
    if (self) {
        _identifier = [identifier copy];
    }
    return self;
}

#pragma mark NSObject

- (NSString *)description
{
    return _identifier;
}

- (NSUInteger)hash
{
    return [_identifier hash];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[XMPPFeature class]]) {
        return [_identifier isEqualToString: [(XMPPFeature *)object identifier]];
    }
    return NO;
}

#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

@end
