//
//  PhotoUploader.m
//  CameraAttachmentPlugin
//
//  Created by Francesco Verheye on 25/11/14.
//  Copyright (c) 2014 Cheqroom. All rights reserved.
//

#import "PhotoUploader.h"

@implementation PhotoUploader{
    NSMutableData *_responseData;
}

-(void) uploadImage:(UIImage*) image andImageWidth:(CGFloat)width andImageHeight:(CGFloat)height toUrl:(NSString*)url
{
    UIImage *resizedImage = [self resizeImage:image newWidth:width newHeight:height];
    
    CGFloat w = resizedImage.size.width;
    CGFloat h = resizedImage.size.height;
    [self uploadImage:resizedImage toUrl:url];
}

-(void) uploadImage:(UIImage*) image toUrl:(NSString*)url
{
    NSString *imageString = [self base64StringFromImage:image];
    
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    imageString = [imageString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString *paramDataString = [NSString stringWithFormat:@"data=%@",imageString];
    NSData* aData = [paramDataString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[aData length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:aData];
    
    // Cast to void to fix warning
    (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURLSessionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSString* response = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    if(self.delegate)
    {
        [self.delegate photoUploader:self didUploadWithResult:response andSuccess:YES];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    if(self.delegate)
    {
        [self.delegate photoUploader:self didUploadWithResult:nil andSuccess:NO];
    }
}

#pragma mark - Util
- (NSString*) base64StringFromImage:(UIImage*)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    return [data base64EncodedStringWithOptions:0];
}

- (UIImage*) resizeImage:(UIImage *)image newWidth:(CGFloat)width newHeight:(CGFloat)height
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]
        && [[UIScreen mainScreen] scale] == 3.0) {
        // Retina
        width = width /3;
        height = height /3;
    } else if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]
               && [[UIScreen mainScreen] scale] == 2.0) {
        // Retina
        width = width / 2;
        height = height / 2 ;
    } else {
        // Not Retina
    }
    
    CGSize sacleSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(sacleSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, sacleSize.width, sacleSize.height)];
    UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}


@end
