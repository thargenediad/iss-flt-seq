//
//  SMAPPlugin.h
//  PhoneGapTest
//
//  Created by temp on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <CIMA/CIMA.h>

@interface SMAPPlugin : CDVPlugin <CIMASmapServiceDelegate>
{
}
 
- (void) log:(CDVInvokedUrlCommand*)command;
- (void) sendRequest:(CDVInvokedUrlCommand*)command;
- (void) sendJSON:(CDVInvokedUrlCommand*)command;
- (void) signout:(CDVInvokedUrlCommand*)command;

@end