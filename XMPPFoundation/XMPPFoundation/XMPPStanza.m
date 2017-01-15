//
//  XMPPStanza.m
//  CoreXMPP
//
//  Created by Tobias Kraentzer on 09.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import "XMPPStanza.h"
#import "XMPPJID.h"
#import "XMPPStanzaError.h"

@implementation XMPPStanza

- (XMPPJID *)to
{
    NSString *JIDString = [self valueForAttribute:@"to"];
    if (JIDString) {
        return [[XMPPJID alloc] initWithString:JIDString];
    } else {
        return nil;
    }
}

- (void)setTo:(XMPPJID *)to
{
    NSString *JIDString = [to stringValue];
    [self setValue:JIDString forAttribute:@"to"];
}

- (XMPPJID *)from
{
    NSString *JIDString = [self valueForAttribute:@"from"];
    if (JIDString) {
        return [[XMPPJID alloc] initWithString:JIDString];
    } else {
        return nil;
    }
}

- (void)setFrom:(XMPPJID *)from
{
    NSString *JIDString = [from stringValue];
    [self setValue:JIDString forAttribute:@"from"];
}

- (NSString *)identifier
{
    return [self valueForAttribute:@"id"];
}

- (void)setIdentifier:(NSString *)stanzaID
{
    [self setValue:stanzaID forAttribute:@"id"];
}

- (NSError *)error {
    __block NSError *error = nil;
    [self enumerateElementsUsingBlock:^(PXElement *element, BOOL *stop) {
        if ([element isKindOfClass:[XMPPStanzaError class]]) {
            XMPPStanzaError *stanzaError = (XMPPStanzaError *)element;
            error = stanzaError.error;
            *stop = YES;
        }
    }];
    return error;
}

@end
