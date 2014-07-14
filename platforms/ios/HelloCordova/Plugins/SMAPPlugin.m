//
//  SMAPPlugin.m
//  PhoneGapTest
//
//  Created by temp on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SMAPPlugin.h"

#import <Cordova/CDVJSON.h>

#import <CIMA/CIMA.h>

@interface SmapObject : NSObject {
@private
    NSString *callbackId;
    bool isJSON;
}

@property (nonatomic, retain) NSString *callbackId;
@property (nonatomic, assign) bool isJSON;


- (id) initWithCallbackId:(NSString*)callbackId isJSON:(BOOL)isJSON;

+ (SmapObject*) smapObjectWithCallbackId:(NSString*)callbackId isJSON:(BOOL)isJSON;

@end

@implementation SmapObject

@synthesize callbackId;
@synthesize isJSON;

- (id) initWithCallbackId:(NSString*)_callbackId isJSON:(BOOL)_isJSON
{
    if ((self = [super init]))
    {
        self.callbackId = _callbackId;
        self.isJSON     = _isJSON;
    }
    
    return self;
}

- (void) dealloc
{
    //[callbackId release];
    
    //[super dealloc];
}

+ (SmapObject*) smapObjectWithCallbackId:(NSString*)_callbackId isJSON:(BOOL)_isJSON
{
    return [[SmapObject alloc] initWithCallbackId:_callbackId isJSON:_isJSON];
}


@end

@implementation SMAPPlugin 

- (void) log:(CDVInvokedUrlCommand*)command
{
    NSString *callbackId = [command callbackId];
    
    NSString *errorStr = nil;
    
    CIMALogLevelType logLevel = CIMALogLevelDebug;
    if ([command.arguments count] >= 1)
    {
        NSString *level = [command argumentAtIndex:0];
        
        if ([level caseInsensitiveCompare:@"ERROR"] == NSOrderedSame)
        {
            logLevel = CIMALogLevelError;
        }
        else if ([level caseInsensitiveCompare:@"WARN"] == NSOrderedSame)
        {
            logLevel = CIMALogLevelWarn;
        }
        else if ([level caseInsensitiveCompare:@"INFO"] == NSOrderedSame)
        {
            logLevel = CIMALogLevelInfo;
        }
        else if ([level caseInsensitiveCompare:@"DEBUG"] == NSOrderedSame)
        {
            logLevel = CIMALogLevelDebug;
        }
        else
        {
            errorStr = [NSString stringWithFormat:@"Unknown level '%@'", level];
        }
    }
    
    NSString *message = @"";
    if ([command.arguments count] >= 2)
    {
        message = [command argumentAtIndex:1];
    }
    else
    {
        errorStr = @"No error message";
    }
    
    if (errorStr)
    {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[errorStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        [self writeJavascript:[pluginResult toErrorCallbackString:callbackId]];
    }
    else
    {    
        CIMAService *cimaService = [CIMAService sharedInstance];
        [cimaService logMessageWithLevel:logLevel timestamp:[NSDate date] message:message messageLocation:@""];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        
        [self writeJavascript:[pluginResult toSuccessCallbackString:callbackId]];
    }
}


- (void) sendRequest:(CDVInvokedUrlCommand*)command
{
    SmapObject *smapObject = [SmapObject smapObjectWithCallbackId:[command callbackId] isJSON:NO];
    
    NSString *errorStr = nil;
    
    NSString *url = nil;
    if ([command.arguments count] >= 1)
    {
        url = [command argumentAtIndex:0];
    }
    
    CIMATransportMethodType transportMethod = CIMATransportMethodDefault;
    if ([command.arguments count] >= 2)
    {
        NSString *method = [command argumentAtIndex:1];
        
        if ([method caseInsensitiveCompare:@"GET"] == NSOrderedSame)
        {
            transportMethod = CIMATransportMethodHttpGet;
        }
        else if ([method caseInsensitiveCompare:@"POST"] == NSOrderedSame)
        {
            transportMethod = CIMATransportMethodHttpPost;
        }
        else if ([method caseInsensitiveCompare:@"PUT"] == NSOrderedSame)
        {
            transportMethod = CIMATransportMethodHttpPut;
        }
        else if ([method caseInsensitiveCompare:@"DELETE"] == NSOrderedSame)
        {
            transportMethod = CIMATransportMethodHttpDelete;
        }
        else
        {
            errorStr = [NSString stringWithFormat:@"Unknown method '%@'", method];
        }
    }
    
    NSString *data = nil;
    if (([command.arguments count] >= 3) && ([command argumentAtIndex:2] != [NSNull null]))
    {
        data = [command argumentAtIndex:2];
    }
    
    if (errorStr)
    {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[errorStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        [self writeJavascript:[pluginResult toErrorCallbackString:smapObject.callbackId]];
    }
    else
    {    
        CIMAService *cimaService = [CIMAService sharedInstance];
        CIMARequest *request = [CIMARequest requestWithUrl:url method:transportMethod headers:nil data:[data dataUsingEncoding:NSUTF8StringEncoding]];
        [cimaService sendRequest:request delegate:self object:smapObject];
    }
}
- (void) sendJSON:(CDVInvokedUrlCommand*)command
{
    SmapObject *smapObject = [SmapObject smapObjectWithCallbackId:[command callbackId] isJSON:YES];
    
    NSString *errorStr = nil;
    
    NSString *url = nil;
    if ([command.arguments count] >= 1)
    {
        url = [command argumentAtIndex:0];
    }
    
    CIMATransportMethodType transportMethod = CIMATransportMethodDefault;
    if ([command.arguments count] >= 2)
    {
        NSString *method = [command argumentAtIndex:1];
        
        if ([method caseInsensitiveCompare:@"GET"] == NSOrderedSame)
        {
            transportMethod = CIMATransportMethodHttpGet;
        }
        else if ([method caseInsensitiveCompare:@"POST"] == NSOrderedSame)
        {
            transportMethod = CIMATransportMethodHttpPost;
        }
        else if ([method caseInsensitiveCompare:@"PUT"] == NSOrderedSame)
        {
            transportMethod = CIMATransportMethodHttpPut;
        }
        else if ([method caseInsensitiveCompare:@"DELETE"] == NSOrderedSame)
        {
            transportMethod = CIMATransportMethodHttpDelete;
        }
        else
        {
            errorStr = [NSString stringWithFormat:@"Unknown method '%@'", method];
        }
    }
    
    NSString *data = nil;
    data = [(NSDictionary*)[command argumentAtIndex:2] JSONString];
    
    if (errorStr)
    {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[errorStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        [self writeJavascript:[pluginResult toErrorCallbackString:smapObject.callbackId]];
    }
    else
    {    
        CIMAService *cimaService = [CIMAService sharedInstance];
        CIMARequest *request = [CIMARequest requestWithUrl:url method:transportMethod headers:nil data:[data dataUsingEncoding:NSUTF8StringEncoding]];
        [cimaService sendRequest:request delegate:self object:smapObject];
    }
}

- (void) signout:(CDVInvokedUrlCommand*)command
{
    NSString *callbackId = [command callbackId];
    
    CIMAService *cimaService = [CIMAService sharedInstance];
    
    //[cimaService endSession];
    [cimaService logoutUser];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    
    [self writeJavascript:[pluginResult toSuccessCallbackString:callbackId]];
}

#pragma mark -
#pragma mark CIMASmapServiceDelegate Methods

- (void) smapServiceDidFinish:(CIMASmapMessageData*)smapMessageData
{
    SmapObject *smapObject = (SmapObject*) smapMessageData.object;
    
    CDVPluginResult* pluginResult = nil;
    if (smapObject.isJSON)
    {
        NSDictionary *jsonDict = (NSDictionary*) [smapMessageData.response.dataAsString JSONObject];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonDict];
    }
    else
    {
        NSString *responseString = [smapMessageData.response dataAsString];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:responseString];
    }

    
    NSString *js = [pluginResult toSuccessCallbackString:smapObject.callbackId];
    [self writeJavascript:js];
}

- (void) smapServiceDidFail:(CIMASmapMessageData*)smapMessageData
{
    SmapObject *smapObject = (SmapObject*) smapMessageData.object;
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[@"CIMA messaging error" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [self writeJavascript:[pluginResult toErrorCallbackString:smapObject.callbackId]];
}

@end