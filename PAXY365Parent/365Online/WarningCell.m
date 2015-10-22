//
//  WarningCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/17.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "WarningCell.h"

#import "WarningEntity.h"
#import "Common.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface WarningCell ()

@end

@implementation WarningCell
@synthesize lblTitle;
@synthesize lblDistance;
@synthesize lblName;
@synthesize newsImage;
@synthesize activityIndicator;
@synthesize lblStatus;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    //lblBGColor.backgroundColor = SubBgColor;
    
    if ([object isKindOfClass:[WarningEntity class]])
    {
        WarningEntity *data = (WarningEntity *)object;
        
        lblTitle.text = data.SafeTitle;
        lblTitle.textColor = TxtBlack;

        lblDistance.text = [NSString stringWithFormat:@"%@%@",data.Distance,data.Unit];
        lblDistance.textColor = TxtGray;

        lblName.text = [NSString stringWithFormat:@"%@",data.SchoolInfo];
        lblName.textColor = TxtGray;
        
        NSString *getStatus = data.SafeStatus;
        if ([getStatus isEqualToString:@"1"]) {
            getStatus = @"已审核";
            lblStatus.textColor = TxtBlue;
        }
        else if ([getStatus isEqualToString:@"2"]) {
            getStatus = @"已拒绝";
            lblStatus.textColor = TxtYellow;
        }
        else {
            getStatus = @"审核中";
            lblStatus.textColor = TxtBlack;
        }
        
        NSString *flagStatus = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            flagStatus = [defaults objectForKey:@"cloudin_365paxy_warning_status"];
            if ([flagStatus isEqualToString:@"1"]) {
                //隐藏状态
                lblStatus.hidden = TRUE;
                lblName.text = data.AddDate;
            }
            else{
                //显示状态
                lblStatus.hidden = FALSE;
                lblStatus.text = getStatus;
                lblName.text = data.AddDate;
            }
        }
        
        
        NSString *getHeadImageURL = data.SafeImage;
        if ([getHeadImageURL rangeOfString:@".png"].location !=NSNotFound) {
            getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
        }
        else if ([getHeadImageURL rangeOfString:@".jpg"].location !=NSNotFound) {
            getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
        }
        NSLog(@"Image:%@",getHeadImageURL);

        [self.newsImage setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                       placeholderImage:[UIImage imageNamed:@"default_image_90_70.png"] options:SDWebImageProgressiveDownload
                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                   //加载图片及指示器效果
                                   if (!activityIndicator) {
                                       [newsImage addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                       activityIndicator.center = newsImage.center;
                                       [activityIndicator startAnimating];
                                   }
                               } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                   //清除指示器效果
                                   [activityIndicator removeFromSuperview];
                                   activityIndicator = nil;
                               }];
        //newsImage.contentMode = UIViewContentModeScaleAspectFill;
        newsImage.layer.masksToBounds = YES;
        newsImage.layer.cornerRadius = 5.0;
    }
}


/**
 *  修正图片方向【对于网路图片无效】
 *
 *  @param aImage.imageOrientation 图片
 *
 *  @return
 */
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}



-(void) dealloc
{
    [super dealloc];
}


@end
