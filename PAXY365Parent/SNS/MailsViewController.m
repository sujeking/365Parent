//
//  MailsViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/21.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "MailsViewController.h"

#import "MailsSearchViewController.h"

#import "Common.h"
#import "Config.h"
#import "DataSource.h"
#import "AHReach.h"

@interface MailsViewController ()

@end

@implementation MailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"超级信箱";
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
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,40)];
    searchBar.placeholder = @"输入关键词";
    //[searchBar sizeToFit];
    searchBar.backgroundImage = [UIImage imageNamed:@"search_bg.png"];
    searchBar.delegate = self;
    [searchBar becomeFirstResponder];
    [self.view addSubview:searchBar];
    [searchBar release];
    
    self.view.backgroundColor = WhiteBgColor;

}

//关闭页面
- (void)closeView
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

#pragma mark - Searching

- (void)updateSearchString:(NSString*)searchString
{
    //[searchString release];
    searchString = [[NSString alloc]initWithString:searchString];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:searchString forKey:@"cloudin_365paxy_keywords_mail"];
    
    
    MailsSearchViewController *nextController = [MailsSearchViewController alloc];
    nextController.setTitle = @"搜索超级信箱";
    nextController.setChannelID = @"1";
    nextController.setFlag= @"2";
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self closeView];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self updateSearchString:searchBar.text];
    [searchBar resignFirstResponder];   //隐藏输入键盘
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
