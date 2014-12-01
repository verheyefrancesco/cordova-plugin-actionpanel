//
//  ActionPanelConfig.m
//  HellowWorld
//
//  Created by Francesco Verheye on 01/12/14.
//
//

#import "ActionPanelConfig.h"
#import "Action.h"

@implementation ActionPanelConfig

-(instancetype) initWithDictionary:(NSMutableDictionary*)dict
{
    self = [super init];
    if(self)
    {
        [self setDefaults];
        
        if([dict objectForKey:@"title"])
        {
            self.title = [dict objectForKey:@"title"];
        }
        if([dict objectForKey:@"cancelButtonText"])
        {
            self.cancelButtonText = [dict objectForKey:@"cancelButtonText"];
        }
        if([dict objectForKey:@"actions"])
        {
            NSMutableArray *theActions = [NSMutableArray array];
            NSArray *arrActions = [dict objectForKey:@"actions"];
            for(NSDictionary *dic in arrActions)
            {
                NSString *Id = [dic objectForKey:@"id"];
                NSString *text = [dic objectForKey:@"text"];
                
                if( Id && text){
                    Action *action = [[Action alloc] init];
                    action.Id = Id;
                    action.text = text;
                    
                    [theActions addObject:action];
                }
            }
            self.actions = theActions;
        }
    }
    return self;
}

-(void) setDefaults
{
    self.title = @"Actions";
    self.actions = [NSArray array];
    self.cancelButtonText = @"Cancel";
}

-(NSArray*) actionTextArray
{
    NSMutableArray *textArr = [NSMutableArray array];
    
    for(Action *action in self.actions)
    {
        [textArr addObject:action.text];
    }
    return textArr;
}

-(NSString*) actionIdFromActionAtIndex:(NSInteger)index
{
    if(self.actions.count > index)
    {
        return ((Action*)[self.actions objectAtIndex:index]).Id;
    }
    return nil;
}

@end
