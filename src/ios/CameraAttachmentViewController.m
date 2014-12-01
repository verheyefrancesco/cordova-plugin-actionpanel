//
//  CameraAttachmentViewController.m
//  CameraAttachmentPlugin
//
//  Created by Francesco Verheye on 21/11/14.
//  Copyright (c) 2014 Cheqroom. All rights reserved.
//

#import "CameraAttachmentViewController.h"

@interface CameraAttachmentViewController ()

@end

@implementation CameraAttachmentViewController{
    UIImagePickerController *_pictureViewController;
    PhotoUploader *_uploader;
    CameraAttachmentConfig *_config;
}

-(instancetype) initWithConfig:(CameraAttachmentConfig*)config
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"CameraAttachmentViewController" bundle:nil];
    } else {
        self = [super initWithNibName:@"CameraAttachmentViewController_iPad" bundle:nil];
    }
    if(self)
    {
        _config = config;
        
        //_config.photoSizeWidth = -1;
        //_config.photoSizeHeight = -1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_pictureViewController)
    {
        [self showTakePictureViewController];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showTakePictureViewController
{
    _pictureViewController = [[UIImagePickerController alloc] init];
    _pictureViewController.delegate = self;
    _pictureViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:_pictureViewController animated:NO completion:NULL];
}

#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    self.containerView.hidden = NO;
    [self.activityIndicator startAnimating];
    self.messageLabel.text = _config.uploadingMessage;
    
    [picker dismissViewControllerAnimated:NO completion:NULL];
    
    [self uploadImage:image];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
    if(self.delegate)
    {
        [self.delegate cameraAttachmentVC:self onClosed:YES andUploadResult:@""];
    }
}

-(void) uploadImage:(UIImage*)image
{
    _uploader = [[PhotoUploader alloc] init];
    _uploader.delegate = self;
    
    _config.photoSize = @"medium";
    
    if([_config.photoSize isEqualToString:@"small"])
    {
        [self uploadSmallImage:image];
    }
    else if([_config.photoSize isEqualToString:@"medium"])
    {
        [self uploadMediumImage:image];
    }
    else if([_config.photoSize isEqualToString:@"large"])
    {
        [_uploader uploadImage:image toUrl:_config.uploadUrl];
    }
}

-(void) uploadSmallImage:(UIImage*)image
{
    if(image.size.width > image.size.height)
    {
        [_uploader uploadImage:image andImageWidth:640 andImageHeight:480 toUrl:_config.uploadUrl];
    } else
    {
        [_uploader uploadImage:image andImageWidth:480 andImageHeight:640 toUrl:_config.uploadUrl];
    }
}

-(void) uploadMediumImage:(UIImage*)image
{
    
    if(image.size.width > image.size.height)
    {
        [_uploader uploadImage:image andImageWidth:1024 andImageHeight:768 toUrl:_config.uploadUrl];
    } else
    {
        [_uploader uploadImage:image andImageWidth:768 andImageHeight:1024 toUrl:_config.uploadUrl];
    }
}

#pragma mark - PhotoUploaderDelegate
-(void) photoUploader:(PhotoUploader *)photoUploader didUploadWithResult:(NSString *)result andSuccess:(BOOL)success
{
    if(self.delegate)
    {
        [self.delegate cameraAttachmentVC:self onClosed:NO andUploadResult:result];
    }
}

#pragma mark - Device Orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

@end
