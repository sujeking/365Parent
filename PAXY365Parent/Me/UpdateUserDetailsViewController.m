//
//  UpdateUserDetailsViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "UpdateUserDetailsViewController.h"

#import "SelectCityViewController.h"
#import "AreaListViewController.h"
#import "SchoolListViewController.h"
#import "ClassListViewController.h"
#import "UploadImageViewController.h"

#import "Config.h"
#import "Common.h"
#import "DataSource.h"
#import "AHReach.h"
#import "InternationalControl.h"
#import "Tool.h"

#import <ShareSDK/ShareSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UpdateUserDetailsViewController ()

@end

@implementation UpdateUserDetailsViewController
@synthesize scrollView;
@synthesize txtNickName;
@synthesize txtMasterName;
@synthesize txtStudentNo;
@synthesize btnPost;
@synthesize btnGenderMan;
@synthesize btnGenderWoman;
@synthesize btnSelectCity;
@synthesize btnSelectClass;
@synthesize btnSelectDistrict;
@synthesize btnSelectProvince;
@synthesize btnSelectSchool;
@synthesize txtGradeID;
@synthesize userImage;
@synthesize activityIndicator;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,1000);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,1000 + 100);
    }
    
    NSString *getTempSelectProvinceName = nil;
    NSString *getTempSelectCityName = nil;
    NSString *getTempSelectDistrictName = nil;
    NSString *getTempSelectSchoolName = nil;
    NSString *getTempSelectClassName = nil;
    NSString *getTempEditStudentNO = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getTempSelectProvinceName = [defaults objectForKey:@"cloudin_365paxy_selected_provincename"];
        getTempSelectCityName = [defaults objectForKey:@"cloudin_365paxy_selected_cityname"];
        getTempSelectDistrictName = [defaults objectForKey:@"cloudin_365paxy_selected_districtname"];
        getTempSelectSchoolName = [defaults objectForKey:@"cloudin_365paxy_selected_schoolname"];
        getTempSelectClassName = [defaults objectForKey:@"cloudin_365paxy_selected_classname"];
        getTempEditStudentNO = [defaults objectForKey:@"cloudin_365paxy_edit_studentno"];
        
        if (getTempSelectProvinceName.length!=0) {
            [btnSelectProvince setTitle:getTempSelectProvinceName forState:UIControlStateNormal];
        }
        
        if (getTempSelectCityName.length!=0) {
            [btnSelectCity setTitle:getTempSelectCityName forState:UIControlStateNormal];
        }
        
        if (getTempSelectDistrictName.length!=0) {
            [btnSelectDistrict setTitle:getTempSelectDistrictName forState:UIControlStateNormal];
        }
        
        if (getTempSelectSchoolName.length!=0) {
            [btnSelectSchool setTitle:getTempSelectSchoolName forState:UIControlStateNormal];
        }
        
        if (getTempSelectClassName.length!=0) {
            [btnSelectClass setTitle:getTempSelectClassName forState:UIControlStateNormal];
        }
        
        if ([getTempEditStudentNO isEqualToString:@"2"]) {
            txtStudentNo.enabled = FALSE;
            txtStudentNo.textColor = TxtGray;
        }
        else{
            txtStudentNo.enabled = TRUE;
        }
    }
    
    
    //加载图片cloudin_eatla_upload_img_8
    [self performSelectorOnMainThread:@selector(loadNewImg) withObject:nil waitUntilDone:NO];//主线程
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadNewImg
{
    NSString *getImg1URL = nil;
    NSString *getUploadImg1 = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        
        getImg1URL = [defaults objectForKey:@"cloudin_365paxy_upload_img_1"];
        getUploadImg1 = [defaults objectForKey:@"cloudin_365paxy_message_upload1"];
        //当NSString值为Int时，必须强制转换为NSString，否则在引用时会引起"[__NSCFNumber length]: unrecognized selector sent to instance"
        getUploadImg1 = [NSString stringWithFormat:@"%@",getUploadImg1];

        //接收用户操作返回结果消息
        if ([getUploadImg1 isEqualToString:@"1"]) {
            
            [self showMessage:@"上传成功"];
        }
        
        //显示图片
        if (getImg1URL != nil) {

            NSString *getHeadImageURL = [NSString stringWithFormat:@"http://img.365paxy.org.cn%@",getImg1URL];
            if ([getHeadImageURL rangeOfString:@".png"].location !=NSNotFound) {
                getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
            }
            else if ([getHeadImageURL rangeOfString:@".jpg"].location !=NSNotFound) {
                getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
            }
            
            [self.userImage setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                               placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                                       progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                           //加载图片及指示器效果
                                           if (!activityIndicator) {
                                               [userImage addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                               activityIndicator.center = userImage.center;
                                               [activityIndicator startAnimating];
                                           }
                                       } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                           //清除指示器效果
                                           [activityIndicator removeFromSuperview];
                                           activityIndicator = nil;
                                       }];
            userImage.layer.masksToBounds = YES;
            userImage.layer.cornerRadius = 15.0;
        }
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
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_upload1"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = SubBgColor;

    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"个人资料";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //关闭
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    //一定要记得声明代理协议，否则不起作用
    scrollView.delegate = self;
    
    [self performSelectorOnMainThread:@selector(loadUserInfo) withObject:nil waitUntilDone:NO];

}


- (void)loadUserInfo
{
    //当用使用2G网络或网络缓慢时，显示加载
    loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
    [loadingView starRun];
    [self.view addSubview:loadingView];
    
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&uid=%@",GetUserDetailsUrl,getUserID];
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSLog(@"URL=%@",urlString);
        NSDictionary *dict = [[DataSource fetchJSON:urlString] retain];
        NSArray *array = [dict objectForKey:@"Results"];
        NSLog(@"Count=%lu",(unsigned long)[array count]);
        for (int i = 0; i < [array count]; i ++) {
            
            NSDictionary *statusDict = [array objectAtIndex:i];
            //txtNickName.text = [statusDict objectForKey:@"NickName"];
            txtStudentNo.text = [statusDict objectForKey:@"StudentNo"];
            txtMasterName.text = [statusDict objectForKey:@"MasterName"];
            
            NSString *getSchoolID = [statusDict objectForKey:@"SchoolID"];
            NSString *getSchoolName = [statusDict objectForKey:@"SchoolName"];
            [btnSelectSchool setTitle:getSchoolName forState:UIControlStateNormal];
            
            NSString *getClassID = [statusDict objectForKey:@"ClassID"];
            NSString *getClassName = [statusDict objectForKey:@"ClassName"];
            [btnSelectClass setTitle:getClassName forState:UIControlStateNormal];
            
            //txtNickName.text = [statusDict objectForKey:@"ClassID"];
            txtNickName.text = [statusDict objectForKey:@"ParentName"];
            NSString *getGradeID = [statusDict objectForKey:@"GradeID"];
            txtGradeID.text = getGradeID;
            
            //txtNickName.text = [statusDict objectForKey:@"TeacherType"];
            NSString *getProvinceID = [statusDict objectForKey:@"ProvinceID"];
            NSString *getProvinceName = [statusDict objectForKey:@"ProvinceName"];
            [btnSelectProvince setTitle:getProvinceName forState:UIControlStateNormal];
            
            NSString *getCityID = [statusDict objectForKey:@"CityID"];
            NSString *getCityName = [statusDict objectForKey:@"CityName"];
            [btnSelectCity setTitle:getCityName forState:UIControlStateNormal];
            
            NSString *getDistrictID = [statusDict objectForKey:@"DistrictID"];
            NSString *getDistrictName = [statusDict objectForKey:@"DistrictName"];
            [btnSelectDistrict setTitle:getDistrictName forState:UIControlStateNormal];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:getSchoolID forKey:@"cloudin_365paxy_selected_schoolid"];
            [defaults setObject:getSchoolName forKey:@"cloudin_365paxy_selected_schoolname"];
            [defaults setObject:getClassID forKey:@"cloudin_365paxy_selected_classid"];
            [defaults setObject:getClassName forKey:@"cloudin_365paxy_selected_classname"];
            [defaults setObject:getGradeID forKey:@"cloudin_365paxy_selected_gradeid"];
            [defaults setObject:getProvinceID forKey:@"cloudin_365paxy_selected_provinceid"];
            [defaults setObject:getProvinceName forKey:@"cloudin_365paxy_selected_provincename"];
            [defaults setObject:getCityID forKey:@"cloudin_365paxy_selected_cityid"];
            [defaults setObject:getCityName forKey:@"cloudin_365paxy_selected_cityname"];
            [defaults setObject:getDistrictID forKey:@"cloudin_365paxy_selected_districtid"];
            [defaults setObject:getDistrictName forKey:@"cloudin_365paxy_selected_districtname"];
            
   
            NSString *getGender = [statusDict objectForKey:@"UserGender"];
            if ([getGender isEqualToString:@"男"]) {
                [btnGenderMan setBackgroundImage:[UIImage imageNamed:@"icon_checked.png"] forState:UIControlStateNormal];
                getUserGender = @"男";
            }
            
            if ([getGender isEqualToString:@"女"]) {
                [btnGenderWoman setBackgroundImage:[UIImage imageNamed:@"icon_checked.png"] forState:UIControlStateNormal];
                getUserGender = @"女";
            }
            
            //头像
            NSString *getHeadImageURL =[statusDict objectForKey:@"UserImage"];
            [defaults setObject:getHeadImageURL forKey:@"cloudin_365paxy_upload_img_old"];
            
            if ([getHeadImageURL rangeOfString:@".png"].location !=NSNotFound) {
                getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
            }
            else if ([getHeadImageURL rangeOfString:@".jpg"].location !=NSNotFound) {
                getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
            }
            
            [self.userImage setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                           placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                       //加载图片及指示器效果
                                       if (!activityIndicator) {
                                           [userImage addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                           activityIndicator.center = userImage.center;
                                           [activityIndicator startAnimating];
                                       }
                                   } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                       //清除指示器效果
                                       [activityIndicator removeFromSuperview];
                                       activityIndicator = nil;
                                   }];
            userImage.layer.masksToBounds = YES;
            userImage.layer.cornerRadius = 15.0;
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
    btnPost.enabled = TRUE;
    [loadingView stopRun];
    
}


//按完Done键以后关闭键盘
- (IBAction) txtNickNameEditing:(id)sender
{
    [txtStudentNo becomeFirstResponder];
}

- (IBAction) txtStudentNoEditing:(id)sender
{
    [txtMasterName becomeFirstResponder];
}

- (IBAction) txtMasterNameEditing:(id)sender
{
    [txtMasterName resignFirstResponder];
}

- (IBAction) txtGradeIDEditing:(id)sender
{
    [txtGradeID resignFirstResponder];
}

/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [txtShopDesc resignFirstResponder];
        return NO;
    }
    return YES;
}*/

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtGradeID resignFirstResponder];
    [txtNickName resignFirstResponder];
    [txtStudentNo resignFirstResponder];
    [txtMasterName resignFirstResponder];
}

//上传头像
- (IBAction) btnUpdateHeadImagePressed: (id) sender
{
    UploadImageViewController *nextController = [[UploadImageViewController alloc] init];
    nextController.setFlag = @"1";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
    [self presentViewController:navigationController animated:YES completion:^{
        //
    }];
    [nextController release];
    [navigationController release];

}

//选择省份
- (IBAction) btnSelectProvincePressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_area_flag"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_area"];
    
    AreaListViewController *nextController = [AreaListViewController alloc];
    nextController.setFlag = @"1";
    nextController.setParentID = @"-1";
    nextController.setKeywords = @"-1";
    nextController.setTitle = @"选择省份";
    nextController.setKeywordsHint = @"搜索省份";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//选择城市
- (IBAction) btnSelectCityPressed: (id) sender
{
    NSString *getSelectArea = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getSelectArea = [defaults objectForKey:@"cloudin_365paxy_selected_provinceid"];
    }
    
    if (getSelectArea.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"请选择省份"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        NSLog(@"provinceid:%@",getSelectArea);
        [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_area"];
        [defaults setObject:@"2" forKey:@"cloudin_365paxy_area_flag"];
        
        NSLog(@"cityid:%@",getSelectArea);
        
        AreaListViewController *nextController = [AreaListViewController alloc];
        nextController.setFlag = @"2";
        nextController.setParentID = getSelectArea;
        nextController.setKeywords = @"-1";
        nextController.setTitle = @"选择城市";
        nextController.setKeywordsHint = @"搜索城市";
        [nextController sendGetDatas];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
    }
}

//选择地区
- (IBAction) btnSelectDistrictPressed: (id) sender
{
    NSString *getSelectArea = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getSelectArea = [defaults objectForKey:@"cloudin_365paxy_selected_cityid"];
    }
    
    if (getSelectArea.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"请选择城市"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_area"];
        [defaults setObject:@"3" forKey:@"cloudin_365paxy_area_flag"];
        
        NSLog(@"districtid:%@",getSelectArea);
        
        AreaListViewController *nextController = [AreaListViewController alloc];
        nextController.setFlag = @"3";
        nextController.setParentID = getSelectArea;
        nextController.setKeywords = @"-1";
        nextController.setTitle = @"选择地区";
        nextController.setKeywordsHint = @"搜索地区";
        [nextController sendGetDatas];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
    }
}

//选择学校
- (IBAction) btnSelectSchoolPressed: (id) sender
{
    NSString *getSelectArea = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getSelectArea = [defaults objectForKey:@"cloudin_365paxy_selected_districtid"];
    }
    
    if (getSelectArea.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"请选择地区"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_school"];
        
        SchoolListViewController *nextController = [SchoolListViewController alloc];
        nextController.setFlag = @"-1";
        nextController.setKeywords = @"-1";
        nextController.setTitle = @"选择学校";
        [nextController sendGetDatas];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
    }
}

//选择学段
- (IBAction) btnSelectClassPressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_class"];
    
    ClassListViewController *nextController = [ClassListViewController alloc];
    nextController.setFlag = @"-1";
    nextController.setKeywords = @"-1";
    nextController.setTitle = @"选择学段";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

- (IBAction) btnSelectManPressed: (id) sender
{
    getUserGender = @"男";
    
    [btnGenderMan setBackgroundImage:[UIImage imageNamed:@"icon_checked.png"] forState:UIControlStateNormal];
    [btnGenderWoman setBackgroundImage:[UIImage imageNamed:@"icon_unchecked.png"] forState:UIControlStateNormal];
}

- (IBAction) btnSelectWomanPressed: (id) sender
{
    getUserGender = @"女";
    
    [btnGenderWoman setBackgroundImage:[UIImage imageNamed:@"icon_checked.png"] forState:UIControlStateNormal];
    [btnGenderMan setBackgroundImage:[UIImage imageNamed:@"icon_unchecked.png"] forState:UIControlStateNormal];
}

- (IBAction) btnAddPressed: (id) sender
{
    NSString *getNum = txtGradeID.text;
    NSInteger gid= [getNum integerValue];

    if (gid>100) {
        gid = 100;
    }
    gid++;

    txtGradeID.text = [NSString stringWithFormat:@"%ld",(long)gid];
}

- (IBAction) btnMiusPressed: (id) sender
{
    NSString *getNum = txtGradeID.text;
    NSInteger gid= [getNum integerValue];
    gid--;
    if (gid<1) {
        gid = 1;
    }
    
    txtGradeID.text = [NSString stringWithFormat:@"%ld",(long)gid];
}



//提交
- (IBAction) btnUpdatePostPressed: (id) sender
{
    btnPost.enabled = FALSE;
    [self checkUpdateData];
}

//
-(void)checkUpdateData
{
    AHReach *reach = [AHReach reachForDefaultHost];
	if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        NSString *getNickName = txtNickName.text;
        NSString *getStudentNo = txtStudentNo.text;
        NSString *getMasterName = txtMasterName.text;
        //NSString *getGradeID = txtGradeID.text;
        
        if(getNickName.length==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入姓名"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            //[txtNickName becomeFirstResponder];
            btnPost.enabled = TRUE;
        }
        else if(getStudentNo.length==0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入学号"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;

        }
        else if(getMasterName.length==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入班主任姓名"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else{
            
            loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
            [loadingView starRun];
            [self.view addSubview:loadingView];

            //[self updateUsersDetails];
            [NSThread detachNewThreadSelector:@selector(updateUsersDetails) toTarget:self withObject:nil];
        }
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"网络连接失败"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        btnPost.enabled = TRUE;
    }
}



//更新用户信息
- (void)updateUsersDetails
{
    NSString *getNickName = txtNickName.text;
    NSString *getStudentNo = txtStudentNo.text;
    NSString *getMasterName = txtMasterName.text;
    NSString *getGradeID = txtGradeID.text;

    @try {
        
        NSString *getUserID = nil;
        NSString *getProvinceID = nil;
        NSString *getCityID = nil;
        NSString *getDistrictID = nil;
        NSString *getSchoolID = nil;
        NSString *getClassID = nil;
        NSString *getClassName = nil;
        NSString *getImage = nil;
        NSString *getOldImage = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
            getProvinceID = [defaults objectForKey:@"cloudin_365paxy_selected_provinceid"];
            getCityID = [defaults objectForKey:@"cloudin_365paxy_selected_cityid"];
            getDistrictID = [defaults objectForKey:@"cloudin_365paxy_selected_districtid"];
            getSchoolID = [defaults objectForKey:@"cloudin_365paxy_selected_schoolid"];
            getClassID = [defaults objectForKey:@"cloudin_365paxy_selected_classid"];
            getClassName = [defaults objectForKey:@"cloudin_365paxy_selected_classname"];
            getImage = [defaults objectForKey:@"cloudin_365paxy_upload_img_1"];
            getOldImage = [defaults objectForKey:@"cloudin_365paxy_upload_img_old"];
        }
        
        if (getImage == nil) {
            getImage = getOldImage;
            getImage = [getImage stringByReplacingOccurrencesOfString:@"http://img.365paxy.org.cn" withString:@""];
        }
    
        //强制设置
        getGradeID = @"1";
        getClassID = @"-1";

        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&uid=%@&name=%@&gender=%@&sid=%@&cid=%@&gid=%@&no=%@&image=%@&ttype=-1&mastername=%@&provinceid=%@&cityid=%@&districtid=%@",UpdateUserInfoUrl,getUserID,getNickName,getUserGender,getSchoolID,getClassID,getGradeID,getStudentNo,getImage,getMasterName,getProvinceID,getCityID,getDistrictID];
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
            
            NSLog(@"Status=%@",getStatus);
            if ([getStatus isEqualToString:@"1"]) {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"2" forKey:@"cloudin_365paxy_message_me"];
                [defaults setObject:getNickName forKey:@"cloudin_365paxy_nickname"];
                [defaults setObject:getMasterName forKey:@"cloudin_365paxy_mastername"];
                [defaults setObject:getStudentNo forKey:@"cloudin_365paxy_studentno"];
                [defaults setObject:getGradeID forKey:@"cloudin_365paxy_gradeid"];
                [defaults setObject:getUserGender forKey:@"cloudin_365paxy_gender"];
                [defaults setObject:getSchoolID forKey:@"cloudin_365paxy_schoolid"];
                [defaults setObject:getClassID forKey:@"cloudin_365paxy_classid"];
                [defaults setObject:getGradeID forKey:@"cloudin_365paxy_gradeid"];
                [defaults setObject:getClassID forKey:@"cloudin_365paxy_classid"];
                [defaults setObject:getClassName forKey:@"cloudin_365paxy_classname"];
                [defaults setObject:@"2" forKey:@"cloudin_365paxy_edit_studentno"];
                getImage = [NSString stringWithFormat:@"http://img.365paxy.org.cn%@",getImage];
                [defaults setObject:getImage forKey:@"cloudin_365paxy_head_image"];
                
                [self closeView];
                
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"更新失败"
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
 
    btnPost.enabled = TRUE;
    [loadingView stopRun];
}


//关闭或返回
- (void)closeView
{
    //self.navigationController.navigationBarHidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES]; //back
    
    //[self dismissViewControllerAnimated:YES completion:^{
    //TODO
    //}];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
