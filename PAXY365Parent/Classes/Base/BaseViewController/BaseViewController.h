//
//  BaseViewController.h
//  FinalFantasy
//
//  Created by space bj on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController
{
    NSString *titleText;
    
    MBProgressHUD *HUD;
    MBProgressHUD *infoHUD;
    
    BOOL isLoadingData;
    BOOL isEnterBackground;//是否是不在显示
    
    UIImageView *imageViewNoData;//无数据室时显示图片
}

@property BOOL isLoadingData;
@property BOOL isEnterBackground;

@property (nonatomic,retain) NSString *titleText;

@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,retain) MBProgressHUD *infoHUD;

@property (nonatomic,retain) UIImageView *imageViewNoData;


#pragma 前往个人主页
-(void) goToUserProfile:(UIButton *) sender;

-(void) addLoadingView:(UIView *) parentView;

-(void) removeLoadingView:(UIView *) parentView;

-(void) initLeftButtonItemWithTitle:(NSString *) title atTarget:(id) target andSelector:(SEL) selctor;
-(void) initRightButtonItemWithTitle:(NSString *) title atTarget:(id) target andSelector:(SEL) selctor;
-(void) initWithCustomView:(UIView *) customView type:(int) type;

-(void) leftButtonItemClick;
//返回按钮回调函数
-(void) leftButtonItemClickBackCall;

//设置导航栏标题
-(void) setTitleLabelText:(NSString *) text;

-(void) showLoadViewWithMsg:(NSString *) msg;
-(void) showInfoViewWithMsg:(NSString *) msg;
-(void) showInfoViewWithNoDataMsg:(NSString *) msg;
-(void) setTableViewBg;

//不在前端显示
-(void) enterBackgroundAction;
//在前端显示
-(void) enterForegroundAction;

@end
