//
//  ItemDetailsViewController.h
//  FoodWalker
//
//  Created by Adin Lee on 15/3/9.
//  Copyright (c) 2015年 Shanghai Cloudin Network Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"

@interface ItemDetailsViewController : UIViewController{
    
    SQLiteManager *dbManager;
    
    UIButton *btnPost;
    UIButton *btnPlus;
    UIButton *btnMinus;
    UIButton *btnSelectDrink;
    UIButton *btnSelectCustom;
    UITextField *txtAmount;
    UILabel *lblMoney;
    
    NSString *setItemName;
    NSString *setItemPrice;
    NSString *setItemID;
    NSString *setShopID;
    NSString *setItemImage;
    NSString *setMakeTime;
    
    int num;
    int price;
    
    //多语言定义显示
    UILabel *langLblDrink;
    UILabel *langLblCustom;

    NSString *langTxtAlertWarning;
    NSString *langTxtAlertOK;
    NSString *langTxtAlertFail;
    NSString *langTxtNetwork;
}

@property (nonatomic, retain) NSString *setItemName;
@property (nonatomic, retain) NSString *setItemPrice;
@property (nonatomic, retain) NSString *setItemID;
@property (nonatomic, retain) NSString *setShopID;
@property (nonatomic, retain) NSString *setItemImage;
@property (nonatomic, retain) NSString *setMakeTime;

@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UIButton *btnPlus;
@property (nonatomic, retain) IBOutlet UIButton *btnMinus;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectDrink;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectCustom;
@property (nonatomic, retain) IBOutlet UITextField *txtAmount;
@property (nonatomic, retain) IBOutlet UILabel *lblMoney;

@property (nonatomic, retain) IBOutlet UILabel *langLblDrink;
@property (nonatomic, retain) IBOutlet UILabel *langLblCustom;

@end

