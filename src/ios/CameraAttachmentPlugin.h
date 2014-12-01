//
//  CameraAttachmentPlugin.h
//  CameraAttachmentPlugin
//
//  Created by Francesco Verheye on 21/11/14.
//  Copyright (c) 2014 Cheqroom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import "CameraAttachmentViewController.h"

@interface CameraAttachmentPlugin : CDVPlugin <CameraAttachmentViewControllerDelegate>

- (void)show:(CDVInvokedUrlCommand*)command;

@end
