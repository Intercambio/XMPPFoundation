//
//  XMPPResultSet.h
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 21.12.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

@import Foundation;
@import PureXML;

@interface XMPPResultSet : PXElement
@property (nonatomic, readwrite) NSInteger max;
@property (nonatomic, readwrite, nullable) NSString *before;
@property (nonatomic, readwrite, nullable) NSString *after;

@property (nonatomic, readwrite) NSInteger count;
@property (nonatomic, readwrite, nullable) NSString *first;
@property (nonatomic, readwrite, nullable) NSString *last;
@end

@interface PXElement (XMPPResultSet)
@property (nonatomic, readwrite, nullable) XMPPResultSet *resultSet;
@end
