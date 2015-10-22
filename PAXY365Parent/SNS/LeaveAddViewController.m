//
//  LeaveAddViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "LeaveAddViewController.h"

#import "UploadImageViewController.h"
#import "ContactsListViewController.h"
#import "UpdateUserDetailsViewController.h"
#import "LeaveTypeListViewController.h"

#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "AHReach.h"
#import "GRAlertView.h"

#import <ShareSDK/ShareSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>



@interface LeaveAddViewController ()

@end

@implementation LeaveAddViewController
@synthesize txtContent;
@synthesize btnSelectContacts;
@synthesize imageView9;
@synthesize scrollView;
@synthesize activityIndicator;
@synthesize btnPost;
@synthesize btnClose;
@synthesize lblPlaceholder;
@synthesize txtDays;
@synthesize btnSelectEndTime;
@synthesize btnSelectLeaveType;
@synthesize btnSelectStartTime;
@synthesize startDatePicker;
@synthesize endDatePicker;
@synthesize doneToolbar;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,700);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,600 + 700);
    }

    
    NSString *getTempSelectCourseName = nil;
    NSString *getTempSelectLeaveTypeName = nil;
    NSString *getClassName = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getTempSelectCourseName = [defaults objectForKey:@"cloudin_365paxy_selectedtemp_contactsname"];
        getTempSelectLeaveTypeName = [defaults objectForKey:@"cloudin_365paxy_selectedtemp_leavetype_name"];

        if (getTempSelectCourseName.length>0) {
            getContacts = getTempSelectCourseName;
            [btnSelectContacts setTitle:getTempSelectCourseName forState:UIControlStateNormal];
        }
        if (getTempSelectLeaveTypeName.length>0) {
            getLeaveType = getTempSelectLeaveTypeName;
            [btnSelectLeaveType setTitle:getTempSelectLeaveTypeName forState:UIControlStateNormal];
        }

        
        getClassName = [defaults objectForKey:@"cloudin_365paxy_classname"];
        if (getClassName.length==0) {

            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"2" forKey:@"cloudin_365paxy_leave_flag_cancel"];
            
            [self showDialogMessage:@"你还没有设置学校/年级/班级信息，请先到个人中心设置"];
        }

    }
    
    
    //加载图片cloudin_eatla_upload_img_8
    [self performSelectorOnMainThread:@selector(loadNewImg) withObject:nil waitUntilDone:NO];//主线程
}

- (void)loadNewImg
{
    NSString *getImg9URL = nil;
    NSString *getUploadImg9= nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        
        //image-9
        getImg9URL = [defaults objectForKey:@"cloudin_365paxy_upload_img_9"];
        getUploadImg9 = [defaults objectForKey:@"cloudin_365paxy_message_upload9"];
        //当NSString值为Int时，必须强制转换为NSString，否则在引用时会引起"[__NSCFNumber length]: unrecognized selector sent to instance"
        getUploadImg9 = [NSString stringWithFormat:@"%@",getUploadImg9];
        
        //接收用户操作返回结果消息
        if ([getUploadImg9 isEqualToString:@"1"]) {
            
            [self showMessage:@"上传成功"];
        }
        
        //显示图片
        if (getImg9URL != nil) {
            
            NSString *getHeadImageURL = [NSString stringWithFormat:@"http://img.365paxy.org.cn%@",getImg9URL];
            if ([getHeadImageURL rangeOfString:@".png"].location !=NSNotFound) {
                getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
            }
            else if ([getHeadImageURL rangeOfString:@".jpg"].location !=NSNotFound) {
                getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
            }
            [self.imageView9 setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                            placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                        //加载图片及指示器效果
                                        if (!activityIndicator) {
                                            [imageView9 addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                            activityIndicator.center = imageView9.center;
                                            [activityIndicator startAnimating];
                                        }
                                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                        //清除指示器效果
                                        [activityIndicator removeFromSuperview];
                                        activityIndicator = nil;
                                    }];
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
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_upload9"];
    
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
    titleLabel.text = @"新增请假条";
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
    
    imageView9.contentMode = UIViewContentModeScaleAspectFit;
    
    txtContent.layer.borderColor = [UIColor colorWithRed:206/255.0 green:205/255.0 blue:206/255.0 alpha:1.0].CGColor;
    txtContent.layer.borderWidth = 0.5;
    txtContent.layer.cornerRadius = 5.0;
    //[txtContent becomeFirstResponder];
    
    txtContent.delegate = self;
    txtContent.returnKeyType = UIReturnKeyDone;
    
    scrollView.delegate = self;
    
    
    doneToolbar.hidden = TRUE;
    startDatePicker.hidden = TRUE;
    endDatePicker.hidden = TRUE;
    
    [startDatePicker addTarget:self action:@selector(startDateTimePickerSelected:) forControlEvents:UIControlEventValueChanged];
    [endDatePicker addTarget:self action:@selector(endDateTimePickerSelected:) forControlEvents:UIControlEventValueChanged];

    
}


//关闭页面
- (void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

- (IBAction)selectedResult:(id)sender {
    
    doneToolbar.hidden = TRUE;
    startDatePicker.hidden = TRUE;
    endDatePicker.hidden = TRUE;
}

-(IBAction)showStartTime:(id)sender
{
    doneToolbar.hidden = FALSE;
    startDatePicker.hidden = FALSE;
    endDatePicker.hidden = TRUE;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *getTime = [formatter stringFromDate:date];
    [btnSelectStartTime setTitle:getTime forState:UIControlStateNormal];
    getStartTime = getTime;
}

//开始时间
-(void)startDateTimePickerSelected:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //df.dateStyle = NSDateFormatterMediumStyle;
    NSString *getTime = [NSString stringWithFormat:@"%@",[df stringFromDate:startDatePicker.date]];
    [btnSelectStartTime setTitle:getTime forState:UIControlStateNormal];
    getStartTime = getTime;
    NSLog(@"%@",getTime);
    
    //判断开始时间与当前时间关系，开始时间不能小于当前时间
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d1= [NSDate date];
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    NSDate *d2= [date dateFromString:getStartTime];
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    NSTimeInterval cha=late2-late1;
    int a=(int)cha/3600;
    int b=(int)cha/60%60;
    int c=(int)cha%60;
    
    if(a<0 || b<0 || c<0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"请假开始时间不能小于当前时间"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

-(IBAction)showEndTime:(id)sender
{
    doneToolbar.hidden = FALSE;
    startDatePicker.hidden = TRUE;
    endDatePicker.hidden = FALSE;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *getTime = [formatter stringFromDate:date];
    [btnSelectEndTime setTitle:getTime forState:UIControlStateNormal];
    getEndTime = getTime;
}


//结束时间
-(void)endDateTimePickerSelected:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //df.dateStyle = NSDateFormatterMediumStyle;
    NSString *getTime = [NSString stringWithFormat:@"%@",[df stringFromDate:endDatePicker.date]];
    [btnSelectEndTime setTitle:getTime forState:UIControlStateNormal];
    getEndTime = getTime;
    NSLog(@"%@",getTime);
    
    //判断开始时间与当前时间关系，开始时间不能小于当前时间
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
   [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d1= [date dateFromString:getStartTime];
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    NSDate *d2= [date dateFromString:getEndTime];
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    NSTimeInterval cha=late2-late1;
    int a=(int)cha/3600;
    int b=(int)cha/60%60;
    int c=(int)cha%60;
    
    if(a<0 || b<0 || c<0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                        message:@"请假结束时间不能小于开始时间"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

//选择通讯录
- (IBAction) btnSelectContactsPressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_contacts"];
    
    ContactsListViewController *nextController = [ContactsListViewController alloc];
    nextController.setFlag = @"2";
    nextController.setKeywords = @"-1";
    nextController.setTitle = @"选择通讯录";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//选择请假类别
- (IBAction) btnSelectLeaveTypePressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_selected_leavetype_name"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_selectedtemp_leavetype_name"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_selected_leavetypeid"];
    
    LeaveTypeListViewController *nextController = [LeaveTypeListViewController alloc];
    nextController.setFlag = @"-1";
    nextController.setKeywords = @"-1";
    nextController.setTitle = @"选择请假类型";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}


//按完Done键以后关闭键盘
- (IBAction) txtDaysEditing:(id)sender
{
    [txtDays resignFirstResponder];
}

//滑动界面时注销所有输入动作
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [txtContent resignFirstResponder];
}

- (IBAction) btnUpload9Pressed: (id) sender
{
    UploadImageViewController *nextController = [[UploadImageViewController alloc] init];
    nextController.setFlag = @"9";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
    [self presentViewController:navigationController animated:YES completion:^{
        //
    }];
    [nextController release];
    [navigationController release];
    
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
        //lblLimitWords.text = [NSString stringWithFormat:@"你还可以输入%ld字",(long)remainTextNum];
        
        return YES;
    }

    
    return YES;
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


- (IBAction) btnAddPressed: (id) sender
{
    NSString *getNum = txtDays.text;
    NSInteger gid= [getNum integerValue];
    
    if (gid>100) {
        gid = 100;
    }
    gid++;
    
    txtDays.text = [NSString stringWithFormat:@"%ld",(long)gid];
}

- (IBAction) btnMiusPressed: (id) sender
{
    NSString *getNum = txtDays.text;
    NSInteger gid= [getNum integerValue];
    gid--;
    if (gid<1) {
        gid = 1;
    }
    
    txtDays.text = [NSString stringWithFormat:@"%ld",(long)gid];
}

- (IBAction) btnPostPressed: (id) sender
{
    [self checkData];
}

//检测数据
- (void)checkData
{
    AHReach *reach = [AHReach reachForDefaultHost];
    if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){
        
        NSString *getTitle = txtContent.text;
        
        if (getContacts == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择通讯录！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else if (getLeaveType == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择请假类型！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else if (getStartTime == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择开始时间！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else if (getEndTime == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择结束时间！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else if(getTitle.length>100){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请假理由不能超过100个汉字！"
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
    NSString *getDesc = txtContent.text;
    
    @try {
        
        NSString *getUserID = nil;
        NSString *getContactsID = nil;
        NSString *getImage9 = nil;
        NSString *getLeaveTypeID = nil;
        NSString *getSchoolID = nil;
        NSString *getClassID = nil;
        NSString *getGradeID = nil;

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
            getContactsID = [defaults objectForKey:@"cloudin_365paxy_selected_contactsid"];
            getImage9 = [defaults objectForKey:@"cloudin_365paxy_upload_img_9"];
            getLeaveTypeID = [defaults objectForKey:@"cloudin_365paxy_selected_leavetypeid"];
            getSchoolID = [defaults objectForKey:@"cloudin_365paxy_schoolid"];
            getClassID = [defaults objectForKey:@"cloudin_365paxy_classid"];
            getGradeID = [defaults objectForKey:@"cloudin_365paxy_gradeid"];
        }
        
        if (getImage9==nil) {
            getImage9 = @"none";
        }
        
        //ChannelID:1=家庭作业，2=成绩分析，3=在校表现，4=网上家访，5=请假条
        NSString *getAcceptUserID = getContactsID;
        NSString *getDays = txtDays.text;
        
        
        //提交
        NSString *urlString = [NSString stringWithFormat:@"%@?day=%@&senduid=%@&acceptuid=%@&type=0&title=-1&content=%@&flag=1&courseid=-1&channelid=5&image=%@&stime=%@&etime=%@&ltype=%@&sid=%@&cid=%@&gid=%@",LeaveAddUrl,getDays,getUserID,getAcceptUserID,getDesc,getImage9,getStartTime,getEndTime,getLeaveTypeID,getSchoolID,getClassID,getGradeID];
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
                [defaults setObject:@"1" forKey:@"cloudin_365paxy_message_leave"];
                
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


//弹出消息对话框
- (void)showDialogMessage:(NSString *)message
{
    GRAlertView *alert;
    alert = [[GRAlertView alloc] initWithTitle:@"提醒"
                                       message:message
                                      delegate:self
                             cancelButtonTitle:@"取消"
                             otherButtonTitles:@"确定", nil];
    
    [alert setTopColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           middleColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           bottomColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]             lineColor:[UIColor colorWithRed:153/255.0 green:206/255.0 blue:0/255.0 alpha:1.0]];
    
    
    [alert setFontName:@"Cochin-Bold"
             fontColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:226/255.0 alpha:1.0]
       fontShadowColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]];
    
    //[alert setImage:@"login_icon.png"];
    alert.animation = GRAlertAnimationNone;
    [alert show];
}

//处理弹出框动作
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"Button pushed: %@, index %i", alertView.title, buttonIndex);
    if (buttonIndex == 1) {
        //
        UpdateUserDetailsViewController *nextController = [UpdateUserDetailsViewController alloc];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
        
    }
    else{
        //取消
        NSString *getFlag = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            getFlag = [defaults objectForKey:@"cloudin_365paxy_leave_flag_cancel"];
            if ([getFlag isEqualToString:@"2"]) {
                [self closeView];
            }
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
