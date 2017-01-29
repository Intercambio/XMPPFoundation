//
//  XMPPJID.m
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


#import "XMPPJID.h"

@implementation XMPPJID

+ (NSRegularExpression *)regularExpression
{
    static NSRegularExpression *expression;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __unused NSError *error = nil;
        expression = [NSRegularExpression regularExpressionWithPattern:@"^(([^@]+)@)?([^/]+)(/(.*))?$"
                                                               options:NSRegularExpressionCaseInsensitive
                                                                 error:&error];
        NSAssert(expression, [error localizedDescription]);
    });
    return expression;
}

#pragma mark Life-cycle

- (nullable instancetype)initWithString:(nullable NSString *)string
{
    if (string == nil) {
        return nil;
    }
    
    NSRegularExpression *expression = [[self class] regularExpression];
    
    NSArray *matches = [expression matchesInString:string
                                           options:NSMatchingReportCompletion
                                             range:NSMakeRange(0, [string length])];
    if ([matches count] == 1) {
        NSTextCheckingResult *match = [matches firstObject];
        NSString *user = [match rangeAtIndex:2].length == 0 ? nil : [string substringWithRange:(NSRange)[match rangeAtIndex:2]];
        NSString *host = [match rangeAtIndex:3].length == 0 ? nil : [string substringWithRange:(NSRange)[match rangeAtIndex:3]];
        NSString *resource = [match rangeAtIndex:5].length == 0 ? nil : [string substringWithRange:(NSRange)[match rangeAtIndex:5]];
        
        if (host) {
            return [self initWithUser:user host:host resource:resource];
        }
    }
    
    return nil;
}

- (nonnull instancetype)initWithUser:(nullable NSString *)user
                                 host:(nonnull NSString *)host
                             resource:(nullable NSString *)resource
{
    self = [super init];
    if (self) {
        _user = [user copy];
        _host = [host copy];
        _resource = [resource copy];
    }
    return self;
}

#pragma mark String Value

- (NSString *)stringValue
{
    if (self.user) {
        if (self.resource) {
            return [NSString stringWithFormat:@"%@@%@/%@", self.user, self.host, self.resource];
        } else {
            return [NSString stringWithFormat:@"%@@%@", self.user, self.host];
        }
    } else {
        return self.host;
    }
}

#pragma mark Bare or Full JID

- (nonnull instancetype)bareJID
{
    return [[XMPPJID alloc] initWithUser:self.user host:self.host resource:nil];
}

- (nonnull instancetype)fullJIDWithResource:(NSString *)resource
{
    return [[XMPPJID alloc] initWithUser:self.user host:self.host resource:resource];
}

#pragma mark NSObject

- (NSString *)description
{
    return self.stringValue;
}

- (NSUInteger)hash
{
    return [_user hash] + [_host hash] + [_resource hash];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[XMPPJID class]]) {
        return [[self stringValue] isEqualToString:[object stringValue]];
    }
    return NO;
}

#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

@end
