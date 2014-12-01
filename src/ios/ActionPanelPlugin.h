//
//  ActionPanelPlugin.h
//  ActionPanelPlugin
//
//  Created by Francesco Verheye on 1/12/14.
//  Copyright (c) 2014 Cheqroom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface ActionPanelPlugin : CDVPlugin 

- (void)show:(CDVInvokedUrlCommand*)command;

@end
