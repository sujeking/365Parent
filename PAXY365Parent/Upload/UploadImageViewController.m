//
//  UploadImageViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-03-15
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "UploadImageViewController.h"

#import "UploadOp.h"
#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "InternationalControl.h"

@interface UploadImageViewController ()

@end

@implementation UploadImageViewController
@synthesize imageView;
@synthesize scrollView;
@synthesize imagePicture;
@synthesize btnCamera;
@synthesize btnPhoto;
@synthesize setFlag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        //scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        //scrollView.contentSize = CGSizeMake(320,600 + 100);
        [btnPhoto setFrame:CGRectMake(10, 390 - 80, 300, 44)];
        [btnCamera setFrame:CGRectMake(10, 442 - 80, 300, 44)];
    }
    

    //显示菜单文字
    NSString *getTitle = @"上传图片";
    NSString *getUpload = @"确定";
    NSString *getPicture = @"相册";
    NSString *getCamera = @"拍照";
    langTxtUploadFail = @"上传失败";
    langTxtAlertTitle = @"提醒";
    langTxtAlertOK = @"确定";
    langUploadNULL = @"请选择照片";
    
    langTxtAlertWarning = @"提醒";
    langTxtAlertOK = @"确定";
    langTxtAlertFail = @"失败";
    langTxtNetwork = @"网络连接失败";
    
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = TitleColor;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = getTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    // 上传
    UIImage *backButtonImage = [UIImage imageNamed: @"btn_box_bg.png"];
    UIView *containingBackView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)] autorelease];
    UIButton *backUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backUIButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    [backUIButton setTitle:getUpload forState:UIControlStateNormal];
    [backUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backUIButton.titleLabel.font = [UIFont systemFontOfSize:12];
    backUIButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    [backUIButton addTarget:self action:@selector(checkUpload) forControlEvents:UIControlEventTouchUpInside];
    [containingBackView addSubview:backUIButton];
    UIBarButtonItem *containingBackButton = [[[UIBarButtonItem alloc] initWithCustomView:containingBackView] autorelease];
    self.navigationItem.rightBarButtonItem = containingBackButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = SubBgColor2;
    
    
    //返回
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;

    flag=1;
}

//关闭页面
- (void)closeView
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//从相册中选择
- (IBAction)btnSelectedAlbumPressed:(id)sender
{
    flag++;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //混合类型 photo + movie
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    [self presentViewController:picker animated:YES completion:^{
        //
    }];
}

//拍照
- (IBAction) btnTakePhotoPressed:(id)sender{
    
    flag++;
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
	camera.delegate = self;
	camera.allowsEditing = YES;
	//isCamera = TRUE;
	
	//检查摄像头是否支持摄像机模式
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		camera.sourceType = UIImagePickerControllerSourceTypeCamera;
		camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	}
	else
	{
		NSLog(@"Camera not exist");
		return;
	}
	
    //仅对视频拍摄有效
	camera.videoQuality = UIImagePickerControllerQualityTypeMedium;

    [self presentViewController:camera animated:YES completion:^{
        //
    }];
	[camera release];
    
    
}

//检测上传图片
-(void)checkUpload
{
    if (flag==1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:langTxtAlertWarning
                                                        message:langUploadNULL
                                                       delegate:self
                                              cancelButtonTitle:langTxtAlertOK
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
        [loadingView starRun];
        [self.view addSubview:loadingView];
        
        [NSThread detachNewThreadSelector:@selector(uploadImage) toTarget:self withObject:nil];
    }
}

//上传图片
- (void)uploadImage
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString* getTime = [formatter stringFromDate:date];
    NSString *getImageName = [NSString stringWithFormat:@"cloudin_365paxy_%@.png",getTime];
    
    //图片路径
    NSDate* date2 = [NSDate date];
    NSDateFormatter* formatter2 = [[[NSDateFormatter alloc] init] autorelease];
    [formatter2 setDateFormat:@"yyyy/MM/dd"];
    NSString *getPath = [formatter2 stringFromDate:date2];
    
    NSString *getImgPath = [NSString stringWithFormat:@"/%@/%@",getPath,getImageName];
    
    //上传图片
    UploadOp *upload = [[[UploadOp alloc] init] autorelease];
    upload.imageToSend = self.imagePicture;
    //op.imageToSend = [UIImage imageWithContentsOfFile:@"/Volumes/Projects/Projects/Sunyong/PhotoNotes/PhotoNotes/images/Default.png"];
    upload.notesToSend = getImageName;
    NSString *result = [upload uploading];
    if ([result isEqualToString:@"Success"]) {
        
        //保存
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *saveImgName = [NSString stringWithFormat:@"cloudin_365paxy_upload_img_%@",setFlag];
        NSString *saveMessage = [NSString stringWithFormat:@"cloudin_365paxy_message_upload%@",setFlag];
        [defaults setObject:getImgPath forKey:saveImgName];
        [defaults setObject:setFlag forKey:saveMessage];//消息提醒
        [defaults setObject:[NSString stringWithFormat:@"http://img.365paxy.org.cn%@",getImgPath] forKey:@"cloudin_365paxy_headimage"];
        [defaults synchronize];
        
        //[self updateImage:getImgPath];
        
        [self closeView];
        
        NSLog(@"ImageURL=%@",getImgPath);
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:langTxtAlertWarning
                                                        message:langTxtUploadFail
                                                       delegate:self
                                              cancelButtonTitle:langTxtAlertOK
                                              otherButtonTitles:nil];
        [alert show];
    }
    NSLog(@"Result of Uploading: %@", result);
    
    [loadingView stopRun];
}


#pragma mark -
#pragma mark ImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        //
    }];
    
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	
	if([mediaType isEqualToString:@"public.movie"])			//被选中的是视频
	{
		NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
		targetURL = url;		//视频的储存路径
		
		if (isCamera)
		{
			//保存视频到相册
			ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
			[library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:nil];
			[library release];
		}
		
		//获取视频的某一帧作为预览
        [self getPreViewImg:url];
	}
	else if([mediaType isEqualToString:@"public.image"])	//被选中的是图片
	{
        //获取照片实例
		UIImage *image = [[info objectForKey:UIImagePickerControllerEditedImage] retain];
		
        NSString *fileName = [[NSString alloc] init];
        
        if ([info objectForKey:UIImagePickerControllerReferenceURL]) {
            fileName = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
            //ReferenceURL的类型为NSURL 无法直接使用  必须用absoluteString 转换，照相机返回的没有UIImagePickerControllerReferenceURL，会报错
            fileName = [self getFileName:fileName];
        }
        else
        {
            fileName = [self timeStampAsString];
        }
		
        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        [myDefault setValue:fileName forKey:@"fileName"];
		if (isCamera) //判定，避免重复保存
		{
			//保存到相册
			ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
			[library writeImageToSavedPhotosAlbum:[image CGImage]
									  orientation:(ALAssetOrientation)[image imageOrientation]
								  completionBlock:nil];
			[library release];
		}
        
        self.imagePicture = image;
		
		[self performSelector:@selector(saveImg:) withObject:image afterDelay:0.0];
		[image release];
	}
	else
	{
		NSLog(@"Error media type");
		return;
	}
	isCamera = FALSE;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	NSLog(@"Cancle it");
	isCamera = FALSE;
    [picker dismissViewControllerAnimated:YES completion:^{
        //
    }];
}


#pragma mark -
#pragma mark userFunc

-(void)getPreViewImg:(NSURL *)url
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    [self performSelector:@selector(saveImg:) withObject:img afterDelay:0.1];
    [img release];
}

-(NSString *)getFileName:(NSString *)fileName
{
	NSArray *temp = [fileName componentsSeparatedByString:@"&ext="];
	NSString *suffix = [temp lastObject];
	
	temp = [[temp objectAtIndex:0] componentsSeparatedByString:@"?id="];
	
	NSString *name = [temp lastObject];
	
	name = [name stringByAppendingFormat:@".%@",suffix];
	return name;
}

-(void)saveImg:(UIImage *) image
{
	NSLog(@"Review Image");
	imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;

}

-(NSString *)timeStampAsString
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEE-MMM-d"];
    NSString *locationString = [df stringFromDate:nowDate];
    return [locationString stringByAppendingFormat:@".png"];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
