//
//  XMPPResultSet.m
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 21.12.16.
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
