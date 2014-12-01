//
//  ActionPanelPlugin.m
//  ActionPanelPlugin
//
//  Created by Francesco Verheye on 1/12/14.
//  Copyright (c) 2014 Cheqroom. All rights reserved.
//

#import "ActionPanelPlugin.h"

@implementation ActionPanelPlugin{
}

- (void)show:(CDVInvokedUrlCommand*)command
{
    NSMutableDictionary *options = [command argumentAtIndex:0];
    
    //[self createConfigWithOptions:options];
    
    //[self showCameraAttachmentViewController];
    
    /*
     // B-OFFICE
     _uploadUrl = @"http://10.0.1.31:8500/upload/upload";
     // C-OFFICE
     _uploadUrl = @"http://192.168.9.108/upload/upload";
     */
}

-(void) createConfigWithOptions:(NSMutableDictionary*)options
{
    _config = [[CameraAttachmentConfig alloc] initWithDictionary:options];
}

-(void) showCameraAttachmentViewController
{
    _cameraAttachmentViewController = [[CameraAttachmentViewController alloc] initWithConfig:_config];
    _cameraAttachmentViewController.delegate = self;
    [self.viewController presentViewController:_cameraAttachmentViewController animated:YES completion:nil];
}

#pragma mark - JS API
-(void) jsUploadCancelled
{
    NSString* jsCallback = @"actionPanelPlugin._actionCanceled();";
    [self.commandDelegate evalJs:jsCallback];
}

- (void)jsUploadWithResult:(NSString*)result
{
    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"&#34;"];
    NSString* jsCallback = [NSString stringWithFormat:@"actionPanelPlugin._actionSelected(\"%@\");", result];
    [self.commandDelegate evalJs:jsCallback];
}

@end
