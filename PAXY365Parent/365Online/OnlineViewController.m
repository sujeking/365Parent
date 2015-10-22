//
//  OnlineViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee Lee on 15/6/1.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "OnlineViewController.h"

#import "OnlineListViewController.h"
#import "WarningListViewController.h"

#import "Common.h"
#import "Reachability.h"
#import "Config.h"
#import "DataSource.h"

@interface OnlineViewController ()

@end

@implementation OnlineViewController
@synthesize scrollView;
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //UITabBarItem *item = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:1];
        //self.tabBarItem = item;
        //self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",9];
    }
    return self;
}

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


}

//返回页面
- (IBAction) btnBackPressed: (id) sender
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES]; //back
    
    //[self dismissViewControllerAnimated:YES completion:^{
    //TODO
    //}];
    
}

//连连看
- (IBAction) btnMenus1Pressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"10" forKey:@"cloudin_365paxy_news_type"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_news_flag"];
    
    OnlineListViewController *nextController = [OnlineListViewController alloc];
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];

}

//安全警示台
- (IBAction) btnMenus2Pressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_warning_userid"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_warning_status"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_warning"];
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_flag"];
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];
    [defaults setObject:@"暂时没有数据" forKey:@"cloudin_365paxy_nodata_show_word"];
    
    WarningListViewController *nextController = [WarningListViewController alloc];
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
    
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
