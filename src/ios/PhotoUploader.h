//
//  PhotoUploader.h
//  CameraAttachmentPlugin
//
//  Created by Francesco Verheye on 25/11/14.
//  Copyright (c) 2014 Cheqroom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PhotoUploader;

@protocol PhotoUploaderDelegate <NSObject>

-(void) photoUploader:(PhotoUploader*)photoUploader didUploadWithResult:(NSString*)result andSuccess:(BOOL)success;

@end


@interface PhotoUploader : NSObject <NSURLSessionDataDelegate>

-(void) uploadImage:(UIImage*) image toUrl:(NSString*)url;

-(void) uploadImage:(UIImage*) image andImageWidth:(CGFloat)width andImageHeight:(CGFloat)height toUrl:(NSString*)url;


@property (nonatomic) id<PhotoUploaderDelegate> delegate;


@end
