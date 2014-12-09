//
//  ActionPanelPlugin.m
//  ActionPanelPlugin
//
//  Created by Francesco Verheye on 1/12/14.
//  Copyright (c) 2014 Cheqroom. All rights reserved.
//

#import "ActionPanelPlugin.h"
#import "ActionPanelConfig.h"
#import "Action.h"

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
    Action *action;
    if(_config.actions.count > buttonIndex)
    {
        action = [_config.actions objectAtIndex:buttonIndex];
        [self jsActionSelected:action];
    } else{
        [self jsActionCancelled];
    }
}

#pragma mark - JS API
-(void) jsActionSelected:(Action*)action
{
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    [resultDic setValue:action.Id forKey:@"id"];
    [resultDic setValue:action.text forKey:@"text"];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:resultDic options:0 error:&err];
    NSString * result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"&#34;"];
    
    NSString* jsCallback = [NSString stringWithFormat:@"actionPanelPlugin._actionSelected(\"%@\");", result];
    [self.commandDelegate evalJs:jsCallback];
}

-(void) jsActionCancelled
{
    NSString* jsCallback = @"actionPanelPlugin._actionCancelled();";
    [self.commandDelegate evalJs:jsCallback];
}

@end
