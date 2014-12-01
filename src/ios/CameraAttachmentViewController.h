//
//  CameraAttachmentViewController.h
//  CameraAttachmentPlugin
//
//  Created by Francesco Verheye on 21/11/14.
//  Copyright (c) 2014 Cheqroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoUploader.h"
#import "CameraAttachmentConfig.h"

@class CameraAttachmentViewController;

@protocol CameraAttachmentViewControllerDelegate <NSObject>

-(void) cameraAttachmentVC:(CameraAttachmentViewController*)cameraAttachmentVC onClosed:(BOOL)fromCancel andUploadResult:(NSString*)uploadResult;

@end


@interface CameraAttachmentViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, PhotoUploaderDelegate>

-(instancetype) initWithConfig:(CameraAttachmentConfig*)config;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) id<CameraAttachmentViewControllerDelegate> delegate;


@end
