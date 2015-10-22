//
//  NotesViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/24.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "NotesViewController.h"

#import "SelectTypeViewController.h"
#import "HomeworkListViewController.h"
#import "BehaveListViewController.h"
#import "LeaveListViewController.h"

#import "AHReach.h"
#import "Common.h"
#import "Config.h"

@interface NotesViewController ()

@end

@implementation NotesViewController
@synthesize txtKeywords;
@synthesize btnPost;
@synthesize btnSelectEndTime;
@synthesize btnSelectStartTime;
@synthesize btnSelectType;
@synthesize scrollView;
@synthesize doneToolbar;
@synthesize startDatePicker;
@synthesize endDatePicker;
@synthesize activityIndicator;


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,700);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,600 + 700);
    }
    
    
    NSString *getTempSelectTypeName = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getTempSelectTypeName = [defaults objectForKey:@"cloudin_365paxy_selectedtemp_typename"];
        
        if (getTempSelectTypeName.length>0) {
            getType = getTempSelectTypeName;
            [btnSelectType setTitle:getTempSelectTypeName forState:UIControlStateNormal];
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置背景颜色
    self.view.backgroundColor = WhiteBgColor;
    
    //头部标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"信息查询";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //返回
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;

    
    scrollView.delegate = self;
    
    doneToolbar.hidden = TRUE;
    startDatePicker.hidden = TRUE;
    endDatePicker.hidden = TRUE;
    
    [startDatePicker addTarget:self action:@selector(startDateTimePickerSelected:) forControlEvents:UIControlEventValueChanged];
    [endDatePicker addTarget:self action:@selector(endDateTimePickerSelected:) forControlEvents:UIControlEventValueChanged];
}

//关闭页面
- (void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

//按完Done键以后关闭键盘
- (IBAction) txtKeywordsEditing:(id)sender
{
    [txtKeywords resignFirstResponder];
}

//选择请假类别
- (IBAction) btnSelectTypePressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_selected_typename"];
    
    // Create the next view controller.
    SelectTypeViewController *nextController = [SelectTypeViewController alloc];
    // Pass the selected object to the new view controller.
    // Push the view controller.
    nextController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextController animated:YES];

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
                                                        message:@"结束时间不能小于开始时间"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction) btnPostPressed: (id) sender
{
    AHReach *reach = [AHReach reachForDefaultHost];
    if([reach isReachableViaWWAN] || [reach isReachableViaWiFi] || [reach isReachable]){

        NSString *getKeywords = @"-1";//txtKeywords.text;
        
        if (getType == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"请选择类别！"
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
        else {
            
            //确定
            if ([getType isEqualToString:@"家庭作业"]) {
                //
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
                [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
                [defaults setObject:@"100" forKey:@"cloudin_365paxy_nodata_flag"];
                [defaults setObject:getStartTime forKey:@"cloudin_365paxy_starttime"];
                [defaults setObject:getEndTime forKey:@"cloudin_365paxy_endtime"];
                [defaults setObject:getKeywords forKey:@"cloudin_365paxy_keywords_homework"];
                
                HomeworkListViewController *nextController = [HomeworkListViewController alloc];
                nextController.setTitle = @"搜索结果";
                nextController.setChannelID = @"1";
                nextController.setFlag= @"2";
                [nextController sendGetDatas];
                nextController.hidesBottomBarWhenPushed = YES;
                self.navigationController.navigationBarHidden = FALSE;
                [self.navigationController pushViewController:nextController animated:YES];
                [nextController release];

            } else if ([getType isEqualToString:@"在校表现"]) {
                //
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
                [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
                [defaults setObject:@"100" forKey:@"cloudin_365paxy_nodata_flag"];
                [defaults setObject:getStartTime forKey:@"cloudin_365paxy_starttime"];
                [defaults setObject:getEndTime forKey:@"cloudin_365paxy_endtime"];
                [defaults setObject:getKeywords forKey:@"cloudin_365paxy_keywords_behave"];
                
                BehaveListViewController *nextController = [BehaveListViewController alloc];
                nextController.setTitle = @"搜索结果";
                nextController.setChannelID = @"3";
                nextController.setFlag= @"2";
                [nextController sendGetDatas];
                nextController.hidesBottomBarWhenPushed = YES;
                self.navigationController.navigationBarHidden = FALSE;
                [self.navigationController pushViewController:nextController animated:YES];
                [nextController release];

            }
            else if ([getType isEqualToString:@"请假条"]) {
                //
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
                [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
                [defaults setObject:@"100" forKey:@"cloudin_365paxy_nodata_flag"];
                [defaults setObject:getStartTime forKey:@"cloudin_365paxy_starttime"];
                [defaults setObject:getEndTime forKey:@"cloudin_365paxy_endtime"];
                [defaults setObject:getKeywords forKey:@"cloudin_365paxy_keywords_leave"];
                
                LeaveListViewController *nextController = [LeaveListViewController alloc];
                nextController.setTitle = @"搜索结果";
                nextController.setChannelID = @"5";
                nextController.setFlag= @"2";
                [nextController sendGetDatas];
                nextController.hidesBottomBarWhenPushed = YES;
                self.navigationController.navigationBarHidden = FALSE;
                [self.navigationController pushViewController:nextController animated:YES];
                [nextController release];

            }
            else if ([getType isEqualToString:@"班级通知"]) {
                //
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
                [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
                [defaults setObject:@"100" forKey:@"cloudin_365paxy_nodata_flag"];
                [defaults setObject:getStartTime forKey:@"cloudin_365paxy_starttime"];
                [defaults setObject:getEndTime forKey:@"cloudin_365paxy_endtime"];
                [defaults setObject:getKeywords forKey:@"cloudin_365paxy_keywords_notice"];
                
                LeaveListViewController *nextController = [LeaveListViewController alloc];
                nextController.setTitle = @"搜索结果";
                nextController.setChannelID = @"6";
                nextController.setFlag= @"1";
                [nextController sendGetDatas];
                nextController.hidesBottomBarWhenPushed = YES;
                self.navigationController.navigationBarHidden = FALSE;
                [self.navigationController pushViewController:nextController animated:YES];
                [nextController release];
                
            }
            else{
                
            }
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
