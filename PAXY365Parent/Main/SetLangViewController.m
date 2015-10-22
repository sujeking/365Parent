//
//  SetLangViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "SetLangViewController.h"

#import "Common.h"
#import "InternationalControl.h"

@interface SetLangViewController ()

@end

@implementation SetLangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [InternationalControl initUserLanguage];
    NSBundle *bundle = [InternationalControl bundle];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [bundle localizedStringForKey:@"LANGUAGE_TITLE" value:nil table:@"InfoPlist"];
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
    
    
    //注册通知，用于接收改变语言的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
    self.view.backgroundColor = MainBgColor;
}

//返回页面
- (void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

//切换至繁体
- (IBAction) btnTraditionalPressed: (id) sender
{
    [InternationalControl setUserlanguage:@"zh-Hant"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage" object:nil];
    [self backView];
}

//切换至简体
- (IBAction) btnSimplifiedPressed: (id) sender
{
    [InternationalControl setUserlanguage:@"zh-Hans"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage" object:nil];
    [self backView];
}

//切换至英文
- (IBAction) btnEnglishPressed: (id) sender
{
    [InternationalControl setUserlanguage:@"en"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage" object:nil];
    [self backView];
}

- (IBAction)changeLanguage:(id)sender {
    
    NSString *lan = [InternationalControl userLanguage];
    
    if([lan isEqualToString:@"en"]){//判断当前的语言，进行改变
        
        [InternationalControl setUserlanguage:@"zh-Hans"];
        
    }else{
        
        [InternationalControl setUserlanguage:@"en"];
    }
    
    //改变完成之后发送通知，告诉其他页面修改完成，提示刷新界面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage" object:nil];
}

-(void)changeLanguage{
    
    
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
