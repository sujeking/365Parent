//
//  BindDetailsViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/30.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPRoundView.h"
#import "MBProgressHUD.h"
#import "BindEntity.h"

@interface BindDetailsViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>{
    
    UIScrollView *scrollView;
    BindEntity *bindEntity;
    MBProgressHUD *HUD;
    
    UITextField *txtGradeID;
    UITextField *txtChildName;
    
    UIButton *btnPost;
    UIButton *btnTeacherType;
    UIButton *btnCourse;
    
    UIButton *btnSelectProvince;
    UIButton *btnSelectCity;
    UIButton *btnSelectDistrict;
    UIButton *btnSelectSchool;
    UIButton *btnSelectClass;
    UIButton *btnSelectRelation;
    UISwitch *switchDefault;
    
    //加载进度条
    GPRoundView *loadingView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) BindEntity *bindEntity;

@property (nonatomic, retain) IBOutlet UITextField *txtGradeID;
@property (nonatomic, retain) IBOutlet UITextField *txtChildName;

@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UIButton *btnTeacherType;
@property (nonatomic, retain) IBOutlet UIButton *btnCourse;

@property (nonatomic, retain) IBOutlet UIButton *btnSelectProvince;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectCity;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectDistrict;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectSchool;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectClass;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectRelation;
@property (nonatomic, retain) IBOutlet UISwitch *switchDefault;

@end
