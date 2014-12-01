//
//  ActionPanelPlugin.m
//  ActionPanelPlugin
//
//  Created by Francesco Verheye on 1/12/14.
//  Copyright (c) 2014 Cheqroom. All rights reserved.
//

#import "ActionPanelPlugin.h"
#import "ActionPanelConfig.h"

@implementation ActionPanelPlugin{
    ActionPanelConfig *_config;
}

- (void)show:(CDVInvokedUrlCommand*)command
{
    NSMutableDictionary *options = [command argumentAtIndex:0];
    
    [self createConfigWithOptions:options];
    
    [self showActionSheet];
}

-(void) createConfigWithOptions:(NSMutableDictionary*)options
{
    _config = [[ActionPanelConfig alloc] initWithDictionary:options];
}

-(void) showActionSheet
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:_config.title
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];

    NSArray *actionTextArr = [_config actionTextArray];
    for (NSString *title in actionTextArr)
    {
        [actionSheet addButtonWithTitle:title];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:_config.cancelButtonText];
    
    [actionSheet showInView:self.viewController.view];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *actionId = [_config actionIdFromActionAtIndex:buttonIndex];
    [self jsActionSelected:actionId];
}

#pragma mark - JS API
-(void) jsActionSelected:(NSString*)actionId
{
    NSString* jsCallback = [NSString stringWithFormat:@"actionPanelPlugin._actionSelected(\"%@\");", actionId];
    [self.commandDelegate evalJs:jsCallback];
}

@end
