//
//  BindAddViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/30.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BindAddViewController.h"

#import "CourseListViewController.h"
#import "SelectCityViewController.h"
#import "AreaListViewController.h"
#import "SchoolListViewController.h"
#import "ClassListViewController.h"
#import "ChildRelationController.h"

#import "Config.h"
#import "Common.h"
#import "DataSource.h"
#import "AHReach.h"

#import <ShareSDK/ShareSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface BindAddViewController ()

@end

@implementation BindAddViewController
@synthesize scrollView;
@synthesize btnPost;
@synthesize btnTeacherType;
@synthesize btnCourse;
@synthesize btnSelectCity;
@synthesize btnSelectClass;
@synthesize btnSelectDistrict;
@synthesize btnSelectProvince;
@synthesize btnSelectSchool;
@synthesize txtGradeID;
@synthesize switchDefault;
@synthesize txtChildName;
@synthesize btnSelectRelation;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,1000);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,1000 + 100);
    }
    
    NSString *getSelectTeacherType = nil;
    NSString *getTeacherCourse = nil;
    NSString *getTempTeacherCourse = nil;
    NSString *getTempSelectProvinceName = nil;
    NSString *getTempSelectCityName = nil;
    NSString *getTempSelectDistrictName = nil;
    NSString *getTempSelectSchoolName = nil;
    NSString *getTempSelectClassName = nil;
    NSString *getTempSelectTeacherType = nil;
    NSString *getTempSelectRelation = nil;
    NSString *getChildRelation = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getSelectTeacherType = [defaults objectForKey:@"cloudin_365paxy_teacher_type"];
        getTeacherCourse = [defaults objectForKey:@"cloudin_365paxy_selected_coursename"];
        getTempTeacherCourse = [defaults objectForKey:@"cloudin_365paxy_selectedtemp_coursename"];
        getTempSelectTeacherType = [defaults objectForKey:@"cloudin_365paxy_temp_teachertype"];
        getTempSelectRelation = [defaults objectForKey:@"cloudin_365paxy_temp_childrelation"];
        getChildRelation = [defaults objectForKey:@"cloudin_365paxy_childrelation"];

        if (getTempSelectRelation.length!=0) {
            [btnSelectRelation setTitle:getTempSelectRelation forState:UIControlStateNormal];
        }
        else{
            [btnSelectRelation setTitle:@"请选择" forState:UIControlStateNormal];
        }
        
        if (getTempSelectTeacherType.length==0) {
            [btnTeacherType setTitle:@"请选择" forState:UIControlStateNormal];
        }
        else{
            [btnTeacherType setTitle:getTempSelectTeacherType forState:UIControlStateNormal];
        }
        
        getTempSelectProvinceName = [defaults objectForKey:@"cloudin_365paxy_selected_provincename"];
        getTempSelectCityName = [defaults objectForKey:@"cloudin_365paxy_selected_cityname"];
        getTempSelectDistrictName = [defaults objectForKey:@"cloudin_365paxy_selected_districtname"];
        getTempSelectSchoolName = [defaults objectForKey:@"cloudin_365paxy_selected_schoolname"];
        getTempSelectClassName = [defaults objectForKey:@"cloudin_365paxy_selected_classname"];
        
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

    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    titleLabel.text = @"绑定孩子所在班级";
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
    
    txtGradeID.text = @"1";
    
    [switchDefault addTarget:self action:@selector(doLocalNotifitionDefault) forControlEvents:UIControlEventValueChanged];
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

- (void)doLocalNotifitionDefault
{
    if (switchDefault.isOn==YES) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"1" forKey:@"cloudin_365paxy_set_bindrelation_default"];
        
    }else if(switchDefault.isOn==NO){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"0" forKey:@"cloudin_365paxy_set_bindrelation_default"];
        
    }
}

//按完Done键以后关闭键盘
- (IBAction) txtGradeNextEditing:(id)sender
{
    [txtGradeID resignFirstResponder];
}

- (IBAction) txtChildNameNextEditing:(id)sender
{
    [txtChildName resignFirstResponder];
}

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtGradeID resignFirstResponder];
    [txtChildName resignFirstResponder];
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

//选择与孩子关系
- (IBAction) btnSelectChildRelationPressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_temp_childrelation"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_childrelation"];
    
    ChildRelationController *nextController = [ChildRelationController alloc];
    nextController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextController animated:YES];
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
        
        NSString *getProvinceID = nil;
        NSString *getCityID = nil;
        NSString *getDistrictID = nil;
        NSString *getSchoolID = nil;
        NSString *getClassID = nil;
        NSString *getChildRelation = nil;
        NSString *getCourseID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            getProvinceID = [defaults objectForKey:@"cloudin_365paxy_selected_provinceid"];
            getCityID = [defaults objectForKey:@"cloudin_365paxy_selected_cityid"];
            getDistrictID = [defaults objectForKey:@"cloudin_365paxy_selected_districtid"];
            getSchoolID = [defaults objectForKey:@"cloudin_365paxy_selected_schoolid"];
            getClassID = [defaults objectForKey:@"cloudin_365paxy_selected_classid"];
            getCourseID = [defaults objectForKey:@"cloudin_365paxy_selected_courseid"];
            getChildRelation = [defaults objectForKey:@"cloudin_365paxy_childrelation"];
        }
        
        NSString *getGradeID = txtGradeID.text;
        NSString *getChildName = txtChildName.text;
        
        if (getProvinceID==nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择省份"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if (getCityID==nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择城市"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if (getDistrictID==nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择地区"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if (getSchoolID==nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择学校"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if (getClassID==nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择学段"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if(getGradeID.length==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入班级"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            btnPost.enabled = TRUE;
        }
        else if(getChildRelation==nil){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择与孩子关系"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //获得焦点
            //[txtNickName becomeFirstResponder];
            btnPost.enabled = TRUE;
        }
        else if(getChildName.length==0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请输入孩子名字"
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
    
    @try {
        
        NSString *getUserID = nil;
        NSString *getCourseID = nil;
        NSString *getProvinceID = nil;
        NSString *getCityID = nil;
        NSString *getDistrictID = nil;
        NSString *getSchoolID = nil;
        NSString *getClassID = nil;
        NSString *getTeacherType = nil;
        NSString *getBindRelation = nil;
        NSString *getClassName = nil;
        NSString *getToClassName = nil;
        NSString *getChildRelation = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
            getCourseID = [defaults objectForKey:@"cloudin_365paxy_selected_courseid"];
            getProvinceID = [defaults objectForKey:@"cloudin_365paxy_selected_provinceid"];
            getCityID = [defaults objectForKey:@"cloudin_365paxy_selected_cityid"];
            getDistrictID = [defaults objectForKey:@"cloudin_365paxy_selected_districtid"];
            getSchoolID = [defaults objectForKey:@"cloudin_365paxy_selected_schoolid"];
            getClassID = [defaults objectForKey:@"cloudin_365paxy_selected_classid"];
            getTeacherType = [defaults objectForKey:@"cloudin_365paxy_teachertype"];
            getBindRelation = [defaults objectForKey:@"cloudin_365paxy_set_bindrelation_default"];
            getClassName = [defaults objectForKey:@"cloudin_365paxy_selected_classname"];
            getToClassName = [defaults objectForKey:@"cloudin_365paxy_to_classname"];
            getChildRelation = [defaults objectForKey:@"cloudin_365paxy_childrelation"];
        }

        NSString *getGradeID = txtGradeID.text;
        NSString *getChildName = txtChildName.text;

        
        if (switchDefault.isOn==YES) {
            getBindRelation = @"1";
        }
        else{
            getBindRelation = @"0";
        }

        //type=1家长,=2教师
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&provinceid=%@&cityid=%@&districtid=%@&schoolid=%@&classid=%@&gradeid=%@&ttype=-1&courseid=-1&relation=%@&name=%@&uid=%@&type=1&default=%@",AddBindUrl,getProvinceID,getCityID,getDistrictID,getSchoolID,getClassID,getGradeID,getChildRelation,getChildName,getUserID,getBindRelation];
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
                [defaults setObject:@"1" forKey:@"cloudin_365paxy_message_bind"];
                
                if ([getBindRelation isEqualToString:@"1"]) {
                    
                    [defaults setObject:getClassName forKey:@"cloudin_365paxy_default_classname"];
                    [defaults setObject:getGradeID forKey:@"cloudin_365paxy_default_gradeid"];
                    [defaults setObject:getClassName forKey:@"cloudin_365paxy_to_classname"];
                    [defaults setObject:getGradeID forKey:@"cloudin_365paxy_gradeid"];
                    [defaults setObject:getClassID forKey:@"cloudin_365paxy_classid"];
                }

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
