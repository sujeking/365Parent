//
//  WarningAddViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "WarningAddViewController.h"
#import "UploadOp.h"

//#import "UploadImageViewController.h"

#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "AHReach.h"

#import <ShareSDK/ShareSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "LocalPhotoViewController.h"


@interface WarningAddViewController () <UIActionSheetDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, SelectPhotoDelegate> {
    
    NSMutableArray *_selectPhotos; // 多图选择返回的带有详细信息的照片
}

@property (nonatomic, retain) NSMutableArray *posterImages;

@property (retain, nonatomic) IBOutlet UIView *photosView;

@end

@implementation WarningAddViewController
@synthesize txtContent;
@synthesize txtTitle;
@synthesize imageUpload1;
@synthesize imageUpload2;
@synthesize imageUpload3;
@synthesize imageUpload4;
@synthesize imageUpload5;
@synthesize scrollView;
@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;
@synthesize imageView4;
@synthesize imageView5;
@synthesize activityIndicator;
@synthesize btnPost;
@synthesize lblPlaceholder;
@synthesize lblLimitWords;

/**
 *   懒加载
 */
- (NSMutableArray *)posterImages {
    if ( _posterImages == nil) {
        _posterImages = [[NSMutableArray alloc] init];
        [_posterImages addObject:[UIImage imageNamed:@"default_image_100"]]; // 默认图片
    }
    return _posterImages;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,600 + 100);
    }
    
    NSString *getTempSelectProvinceName = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getTempSelectProvinceName = [defaults objectForKey:@"cloudin_365paxy_selected_provincename"];
        
    }
    
}




//显示弹出消息
-(void)showMessage:(NSString *)message
{
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = message;
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:3];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_upload11"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_upload12"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_upload13"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_upload14"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_upload15"];
    [defaults synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = SubBgColor;
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"上传安全警示台信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
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
    
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    imageView4.contentMode = UIViewContentModeScaleAspectFit;
    imageView5.contentMode = UIViewContentModeScaleAspectFit;
    
    txtContent.layer.borderColor = [UIColor colorWithRed:206/255.0 green:205/255.0 blue:206/255.0 alpha:1.0].CGColor;
    txtContent.layer.borderWidth = 0.5;
    txtContent.layer.cornerRadius = 5.0;
    //[txtContent becomeFirstResponder];
    
    txtContent.delegate = self;
    txtContent.returnKeyType = UIReturnKeyDone;
    
    scrollView.delegate = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:txtTitle];
    // 加载占位图片
    [self reloadPhoto];
}


//关闭页面
- (void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

//按完Done键以后关闭键盘
- (IBAction) txtTitleCodeEditing:(id)sender
{
    [txtContent becomeFirstResponder];
}

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtTitle resignFirstResponder];
    [txtContent resignFirstResponder];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    
    NSString *temp = [textView.text
                      stringByReplacingCharactersInRange:range
                      withString:text];
    
    if (![text isEqualToString:@""])
    {
        lblPlaceholder.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        lblPlaceholder.hidden = NO;
        
    }
    
    if ([text isEqualToString:@"\n"]) {
        [txtContent resignFirstResponder];
        return NO;
    }
    
    
    NSInteger remainTextNum = 100;
    //计算剩下多少文字可以输入
    if(range.location>=100)
    {
        remainTextNum = 0;
        return YES;
    }
    else
    {
        NSString *nsTextContent = temp;
        NSInteger existTextNum = [nsTextContent length];
        remainTextNum =100-existTextNum;
        lblLimitWords.text = [NSString stringWithFormat:@"你还可以输入%ld字",(long)remainTextNum];
        
        return YES;
    }
    
    return YES;
}

//格式化显示输入
-(void)textFiledEditChanged:(NSNotification*)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    
    
    //标题超过25个汉字自动截取
    if (self.txtTitle == textField)
    {
        if(toBeString.length>30){
            txtTitle.text = [toBeString substringWithRange:NSMakeRange(0, 30)];
        }
        
    }
    
}


/*由于联想输入的时候，函数textView:shouldChangeTextInRange:replacementText:无法判断字数，
 因此使用textViewDidChange对TextView里面的字数进行判断
 */
- (void)textViewDidChange:(UITextView *)textView
{
    //该判断用于联想输入
    if (textView.text.length > 100)
    {
        textView.text = [textView.text substringToIndex:100];
    }
}



/**
 *  确定按钮按下
 */
- (IBAction) btnPostPressed: (id) sender
{
    
   // [self checkData];
    
    loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
    [loadingView starRun];
    [self.view addSubview:loadingView];
    
    [NSThread detachNewThreadSelector:@selector(uploadImage) toTarget:self withObject:nil];
//  [self uploadImage];
    
}




//检测数据
- (void)checkData
{
    AHReach *reach = [AHReach reachForDefaultHost];
    if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        NSString *getTitle = txtTitle.text;
        NSString *getContent = txtContent.text;
        
        if (getTitle.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入标题！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else if(getTitle.length>30){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"标题不能超过30个汉字！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else if(getContent.length>500){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"描述不能超过500个汉字！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else {
            
            [self postData];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"网络连接失败！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

//提交数据
- (void)postData
{
     NSString *getTitle = txtTitle.text;
     NSString *getDesc = txtContent.text;
    
    @try {
        NSString *getUserID = nil;
        NSString *getLat = nil;
        NSString *getLng = nil;
        NSString *getAddress = nil;
        NSString *getImage11 = nil;
        NSString *getImage12 = nil;
        NSString *getImage13 = nil;
        NSString *getImage14 = nil;
        NSString *getImage15 = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
            getLat = [defaults objectForKey:@"cloudin_365paxy_lat"];
            getLng = [defaults objectForKey:@"cloudin_365paxy_lng"];
            getAddress = [defaults objectForKey:@"cloudin_365paxy_address"];
            getImage11 = [defaults objectForKey:@"cloudin_365paxy_upload_img_11"];
            getImage12 = [defaults objectForKey:@"cloudin_365paxy_upload_img_12"];
            getImage13 = [defaults objectForKey:@"cloudin_365paxy_upload_img_13"];
            getImage14 = [defaults objectForKey:@"cloudin_365paxy_upload_img_14"];
            getImage15 = [defaults objectForKey:@"cloudin_365paxy_upload_img_15"];
        }
        
        if (getLat==nil) {
            getLat = DefaultLat;
        }
        if (getLng==nil) {
            getLng = DefaultLng;
        }
        
        if (getImage11==nil) {
            getImage11 = @"none";
        }
        if (getImage12==nil) {
            getImage12 = @"none";
        }
        if (getImage13==nil) {
            getImage13 = @"none";
        }
        if (getImage14==nil) {
            getImage14 = @"none";
        }
        if (getImage15==nil) {
            getImage15 = @"none";
        }
        
        //提交
        NSString *urlString = [NSString stringWithFormat:@"%@?uid=%@&lat=%@&lng=%@&address=%@&title=%@&img=%@&img2=%@&img3=%@&img4=%@&img5=%@&desc=%@",WarningAddUrl,getUserID,getLat,getLng,getAddress,getTitle,getImage11,getImage12,getImage13,getImage14,getImage15,getDesc];
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSLog(@"URL=%@",urlString);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"Results"];
        NSLog(@"Count=%lu",(unsigned long)[loginStatus count]);
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getStatus = [statusDict objectForKey:@"Status"];
            
            if ([getStatus isEqualToString:@"1"]) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"1" forKey:@"cloudin_365paxy_message_warning"];
                [defaults synchronize];
                
                [self closeView];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"发布失败！"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
}



//上传图片
- (void)uploadImage
{
    
    for (int i = 0; i < self.posterImages.count - 1 ; i ++) {
        [NSThread sleepForTimeInterval:1.0f];
        
        UIImage *image = self.posterImages[i];
        NSString *setFlag  = [NSString stringWithFormat:@"1%d",i+1];
        
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
        
       // upload.imageToSend = self.imagePicture;
        upload.imageToSend = image;
        
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
            
            
            NSLog(@"ImageURL=%@",getImgPath);
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"上传失败"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        NSLog(@"Result of Uploading: %@", result);
        
        [loadingView stopRun];
    }
    
    [self checkData];
}






// 图片按钮被按下
- (IBAction) btnUploadPressed: (id) sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"相机", nil];
    
    [sheet showInView:self.view];
    
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {  // 打开相册
        [self openAlbum];
    } else if (buttonIndex == 1) {  // 打开相机
        [self openCamera];
    }
}

/**
 *  拍照
 */
- (void)openCamera {
    if ( ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  相册
 */
- (void)openAlbum {
    if ( ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    LocalPhotoViewController *pick = [[LocalPhotoViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:nil action:nil];
    pick.selectPhotoDelegate = self;
    pick.selectPhotos = _selectPhotos;
    [self.navigationController pushViewController:pick animated:YES];
}

#pragma mark - SelectAlbumDelegate 选择多张图片后返回数组
- (void)getSelectedPhoto:(NSMutableArray *)photos {
    
    //   [self.posterImages removeAllObjects];
    
    // 移除倒数第一个前面的所有图片，最后一个为占位图
    NSRange range;
    range.location = 0;
    range.length = self.posterImages.count - 1;
    [self.posterImages removeObjectsInRange:range];
    
    _selectPhotos = photos;
    
    for (int i = 0; i < _selectPhotos.count; i ++) {
        ALAsset *asset = _selectPhotos[i];
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        CGImageRef posterImageRef = [rep fullResolutionImage];
        UIImage *posterImage = [UIImage imageWithCGImage:posterImageRef];
        
        [self.posterImages insertObject:posterImage atIndex:self.posterImages.count - 1];  // 插入到倒数第二张
    }
    
    [self reloadPhoto];
    
}

/**
 *  加载图片
 */
- (void) reloadPhoto {
    int j = 0;
    for (int i = 0; i < self.photosView.subviews.count; i ++) {
        
        if ([self.photosView.subviews[i] isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = self.photosView.subviews[i];
            if (j < self.posterImages.count) {
                UIImage *image= self.posterImages[j];
                imageView.image = image;
            } else {
                imageView.image = [[UIImage alloc] init];
            }
            j++;
        }
    }
    
}


#pragma mark - 相机代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (image.imageOrientation!=UIImageOrientationUp) {
        image=[UIImage imageWithCGImage:image.CGImage scale:1.0f orientation:UIImageOrientationUp];
    }
    
    // 保存照片
    [self.posterImages insertObject:image atIndex:self.posterImages.count - 1]; // 插入到倒数第二张图片
    
    [self reloadPhoto];
}




- (void)dealloc {
    [_photosView release];
    [super dealloc];
}
@end
