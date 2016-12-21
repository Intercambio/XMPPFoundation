//
//  XMPPResultSet.m
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 21.12.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import "XMPPResultSet.h"

NSString *const XMPPResultSetNamespace = @"http://jabber.org/protocol/rsm";

@implementation XMPPResultSet

+ (void)load
{
    [PXDocument registerElementClass:[XMPPResultSet class]
                    forQualifiedName:PXQN(XMPPResultSetNamespace, @"set")];
}

#pragma mark Properties

- (NSInteger)max {
    NSString *stringValue = [[[self nodesForXPath:@"./x:max" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject] stringValue];
    return [stringValue integerValue];
}

- (void)setMax:(NSInteger)max {
    PXElement *element = [[self nodesForXPath:@"./x:max" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject];
    if (element) {
        [element setStringValue:[NSString stringWithFormat:@"%ld", (long)max]];
    } else {
        [self addElementWithName:@"max" namespace:XMPPResultSetNamespace content:[NSString stringWithFormat:@"%ld", (long)max]];
    }
}

- (NSString *)before {
    return [[[self nodesForXPath:@"./x:before" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject] stringValue];
}

- (void)setBefore:(NSString *)before {
    PXElement *element = [[self nodesForXPath:@"./x:before" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject];
    if (element) {
        [element setStringValue:[before length] > 0 ? before : nil];
    } else {
        [self addElementWithName:@"before" namespace:XMPPResultSetNamespace content:[before length] > 0 ? before : nil];
    }
}

- (NSString *)after {
    return [[[self nodesForXPath:@"./x:after" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject] stringValue];
}

- (void)setAfter:(NSString *)after {
    PXElement *element = [[self nodesForXPath:@"./x:after" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject];
    if (element) {
        [element setStringValue:[after length] > 0 ? after : nil];
    } else {
        [self addElementWithName:@"after" namespace:XMPPResultSetNamespace content:[after length] > 0 ? after : nil];
    }
}

- (NSInteger)count {
    NSString *stringValue = [[[self nodesForXPath:@"./x:count" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject] stringValue];
    return [stringValue integerValue];
}

- (void)setCount:(NSInteger)count {
    PXElement *element = [[self nodesForXPath:@"./x:count" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject];
    if (element) {
        [element setStringValue:[NSString stringWithFormat:@"%ld", (long)count]];
    } else {
        [self addElementWithName:@"count" namespace:XMPPResultSetNamespace content:[NSString stringWithFormat:@"%ld", (long)count]];
    }
}

- (NSString *)first {
    return [[[self nodesForXPath:@"./x:first" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject] stringValue];
}

- (void)setFirst:(NSString *)first {
    PXElement *element = [[self nodesForXPath:@"./x:first" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject];
    if (element) {
        if (first) {
            [element setStringValue:first];
        } else {
            [element removeFromParent];
        }
    } else if (first) {
        [self addElementWithName:@"first" namespace:XMPPResultSetNamespace content:first];
    }
}

- (NSString *)last {
    return [[[self nodesForXPath:@"./x:last" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject] stringValue];
}

- (void)setLast:(NSString *)last {
    PXElement *element = [[self nodesForXPath:@"./x:last" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject];
    if (element) {
        if (last) {
            [element setStringValue:last];
        } else {
            [element removeFromParent];
        }
    } else if (last) {
        [self addElementWithName:@"last" namespace:XMPPResultSetNamespace content:last];
    }
}

@end

@implementation PXElement (XMPPResultSet)

- (XMPPResultSet *)resultSet {
    return [[self nodesForXPath:@"./x:set" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }] firstObject];
}

- (void)setResultSet:(XMPPResultSet *)resultSet {
    
    NSArray *nodes = [self nodesForXPath:@"./x:set" usingNamespaces:@{ @"x" : XMPPResultSetNamespace }];
    for (PXElement *element in nodes) {
        [element removeFromParent];
    }
    
    if (resultSet) {
        [self addElement:resultSet];
    }
}

- (nonnull XMPPResultSet *)addResultSetWithMax:(NSInteger)max before:(nonnull NSString *)before {
    XMPPResultSet *set = (XMPPResultSet *)[self addElementWithName:@"set" namespace:XMPPResultSetNamespace content:nil];
    set.max = max;
    set.before = before;
    return set;
}

- (nonnull XMPPResultSet *)addResultSetWithMax:(NSInteger)max after:(nonnull NSString *)after {
    XMPPResultSet *set = (XMPPResultSet *)[self addElementWithName:@"set" namespace:XMPPResultSetNamespace content:nil];
    set.max = max;
    set.after = after;
    return set;
}

@end
