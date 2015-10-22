//
//  UploadImageViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-03-15
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "GPRoundView.h"

@interface UploadImageViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIScrollView *scrollView;
    UIImageView *imageView;
    UIImage *imagePicture;
    
    NSURL *targetURL;
	BOOL isCamera;
    
    int flag;
    
    UIButton *btnPhoto;
    UIButton *btnCamera;
    
    NSString *setFlag;
    
    //加载进度条
    GPRoundView *loadingView;
    
    //多语言定义显示
    NSString *langTxtAlertTitle;
    NSString *langTxtAlertOK;
    NSString *langTxtUploadFail;
    NSString *langUploadNULL;
    
    NSString *langTxtAlertWarning;
    NSString *langTxtAlertFail;
    NSString *langTxtNetwork;
}

@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) IBOutlet UIImageView *imageView;
@property (nonatomic,retain) IBOutlet UIImage *imagePicture;
@property (nonatomic,retain) IBOutlet UIButton *btnPhoto;
@property (nonatomic,retain) IBOutlet UIButton *btnCamera;

-(void)getPreViewImg:(NSURL *)url;
-(NSString *)getFileName:(NSString *)fileName;
-(NSString *)timeStampAsString;

@property (nonatomic,retain) NSString *setFlag;

@end