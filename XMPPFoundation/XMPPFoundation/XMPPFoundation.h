//
//  XMPPFoundation.h
//  XMPPFoundation
//
//  Created by Tobias Kräntzer on 10.12.16.
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

#import <Foundation/Foundation.h>

//! Project version number for XMPPFoundation.
FOUNDATION_EXPORT double XMPPFoundationVersionNumber;

//! Project version string for XMPPFoundation.
FOUNDATION_EXPORT const unsigned char XMPPFoundationVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <XMPPFoundation/PublicHeader.h>

#import <XMPPFoundation/XMPPJID.h>
#import <XMPPFoundation/XMPPStanza.h>
#import <XMPPFoundation/XMPPMessageStanza.h>
#import <XMPPFoundation/XMPPPresenceStanza.h>
#import <XMPPFoundation/XMPPIQStanza.h>
#import <XMPPFoundation/XMPPStanzaError.h>
#import <XMPPFoundation/XMPPDispatcher.h>
#import <XMPPFoundation/XMPPDataForm.h>
#import <XMPPFoundation/XMPPDataFormField.h>
#import <XMPPFoundation/XMPPDataFormOption.h>
#import <XMPPFoundation/XMPPResultSet.h>
#import <XMPPFoundation/XMPPFeature.h>
