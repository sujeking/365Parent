//
//  MailViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/17.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "MailViewController.h"

#import "VisitListViewController.h"
#import "HomeworkListViewController.h"
#import "BehaveListViewController.h"
#import "LeaveListViewController.h"
#import "NoticeListViewController.h"
#import "NotesViewController.h"
#import "NoticeClassListViewController.h"


#import "Common.h"
#import "Reachability.h"
#import "Config.h"
#import "DataSource.h"

@interface MailViewController ()

@end

@implementation MailViewController
@synthesize scrollView;
@synthesize btnMessageNum1;
@synthesize btnMessageNum2;
@synthesize btnMessageNum3;
@synthesize btnMessageNum4;
@synthesize btnMessageNum5;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,600);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,650);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置背景颜色
    self.view.backgroundColor = MainBgColor;
    
    NSString *getClassName = nil;
    NSString *getGradeID = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getClassName = [defaults objectForKey:@"cloudin_365paxy_to_classname"];
        getGradeID = [defaults objectForKey:@"cloudin_365paxy_gradeid"];
    }
    
    NSString *getTitle = [NSString stringWithFormat:@"%@(%@)班",getClassName,getGradeID];
    
    //头部标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = getTitle;
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
    
    self.view.backgroundColor = WhiteBgColor;
    
    btnMessageNum1.hidden = TRUE;
    btnMessageNum2.hidden = TRUE;
    btnMessageNum3.hidden = TRUE;
    btnMessageNum4.hidden = TRUE;
    btnMessageNum5.hidden = TRUE;

}

//返回页面
- (void)backView
{
    NSString *getGotoFlag = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getGotoFlag = [defaults objectForKey:@"cloudin_365paxy_goto_flag"];
    }

    if ([getGotoFlag isEqualToString:@"1"]) {
        //首页点击跳转过来的，不要隐藏头部
        self.navigationController.navigationBarHidden = NO;
    }
    else{
        self.navigationController.navigationBarHidden = YES;
    }
    
    
    [self.navigationController popViewControllerAnimated:YES]; //back
    
    //[self dismissViewControllerAnimated:YES completion:^{
    //TODO
    //}];
    
}

//家庭作业
- (IBAction) btnMenus1Pressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"100" forKey:@"cloudin_365paxy_nodata_flag"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_starttime"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_endtime"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_keywords_homework"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_comment_flag"];
    
    HomeworkListViewController *nextController = [HomeworkListViewController alloc];
    nextController.setTitle = @"家庭作业";
    nextController.setChannelID = @"1";
    nextController.setFlag= @"2";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//在校表现
- (IBAction) btnMenus2Pressed: (id) sender
{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"100" forKey:@"cloudin_365paxy_nodata_flag"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_starttime"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_endtime"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_keywords_behave"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_comment_flag"];

    
    BehaveListViewController *nextController = [BehaveListViewController alloc];
    nextController.setTitle = @"在校表现";
    nextController.setChannelID = @"3";
    nextController.setFlag= @"2";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//网上家访
- (IBAction) btnMenus3Pressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"2" forKey:@"cloudin_365paxy_question_flag"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_question_type"];
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"暂时没有数据" forKey:@"cloudin_365paxy_nodata_show_word"];
    
    VisitListViewController *nextController = [VisitListViewController alloc];
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
    
}

//请假条
- (IBAction) btnMenus4Pressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"100" forKey:@"cloudin_365paxy_nodata_flag"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_starttime"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_endtime"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_keywords_leave"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_comment_flag"];
    
    LeaveListViewController *nextController = [LeaveListViewController alloc];
    nextController.setTitle = @"请假条";
    nextController.setChannelID = @"5";
    nextController.setFlag= @"2";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//班级通知
- (IBAction) btnMenus5Pressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"100" forKey:@"cloudin_365paxy_nodata_flag"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_starttime"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_endtime"];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_keywords_notice"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_comment_flag"];
    
    
    NoticeClassListViewController *nextController = [NoticeClassListViewController alloc];
    nextController.setTitle = @"班级通知";
    nextController.setChannelID = @"6";
    nextController.setFlag= @"2";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//备忘录
- (IBAction) btnMenus6Pressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_selectedtemp_typename"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_homework"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_behave"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_keywords_leave"];
    
    // Create the next view controller.
    NotesViewController *nextController = [NotesViewController alloc];
    // Pass the selected object to the new view controller.
    // Push the view controller.
    nextController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextController animated:YES];

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