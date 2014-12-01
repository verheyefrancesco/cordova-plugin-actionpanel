//
//  ActionPanelConfig.h
//  HellowWorld
//
//  Created by Francesco Verheye on 01/12/14.
//
//

#import <Foundation/Foundation.h>

@interface ActionPanelConfig : NSObject

-(instancetype) initWithDictionary:(NSMutableDictionary*)dict;


@property(nonatomic) NSString* title;
@property(nonatomic) NSArray* actions;
@property(nonatomic) NSString* cancelButtonText;

-(NSArray*) actionTextArray;

-(NSString*) actionIdFromActionAtIndex:(NSInteger)index;

@end
