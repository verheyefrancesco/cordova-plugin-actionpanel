//
//  CameraAttachmentConfig.m
//  HelloWorld
//
//  Created by Francesco Verheye on 26/11/14.
//
//

#import "CameraAttachmentConfig.h"

@implementation CameraAttachmentConfig

-(instancetype) initWithDictionary:(NSMutableDictionary*)dict
{
    self = [super init];
    if(self)
    {
        [self setDefaults];
        
        if([dict objectForKey:@"uploadUrl"])
        {
            self.uploadUrl = [dict objectForKey:@"uploadUrl"];
        }
        if([dict objectForKey:@"cancelButtonText"])
        {
            self.cancelButtonText = [dict objectForKey:@"cancelButtonText"];
        }
        if([dict objectForKey:@"usePhotoButtonText"])
        {
            self.usePhotoButtonText = [dict objectForKey:@"usePhotoButtonText"];
        }
        if([dict objectForKey:@"retakeButtonText"])
        {
            self.retakeButtonText = [dict objectForKey:@"retakeButtonText"];
        }
        if([dict objectForKey:@"uploadingMessage"])
        {
            self.uploadingMessage = [dict objectForKey:@"uploadingMessage"];
        }
        if([dict objectForKey:@"photoSize"])
        {
            self.photoSize = [dict objectForKey:@"photoSize"];
        }
        
    }
    return self;
}

-(void) setDefaults
{
    self.uploadUrl = @"your_upload_url";
    self.cancelButtonText = @"Cancel";
    self.usePhotoButtonText = @"Use Photo";
    self.retakeButtonText = @"Retake";
    self.uploadingMessage = @"Uploading";
    self.photoSize = @"medium";
}
@end
