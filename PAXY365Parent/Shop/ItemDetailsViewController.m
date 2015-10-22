//
//  ItemDetailsViewController.m
//  FoodWalker
//
//  Created by Adin Lee on 15/3/9.
//  Copyright (c) 2015年 Shanghai Cloudin Network Technology Co.,Ltd. All rights reserved.
//

#import "ItemDetailsViewController.h"

#import "ItemDrinkListViewController.h"
#import "ItemCustomListViewController.h"

#import "Config.h"
#import "Common.h"
#import "DataSource.h"
#import "AHReach.h"
#import "EGOImageView.h"
#import "InternationalControl.h"

@interface ItemDetailsViewController ()

@end

@implementation ItemDetailsViewController
@synthesize btnMinus;
@synthesize btnPlus;
@synthesize btnPost;
@synthesize btnSelectCustom;
@synthesize btnSelectDrink;
@synthesize txtAmount;
@synthesize langLblCustom;
@synthesize langLblDrink;
@synthesize lblMoney;
@synthesize setItemID;
@synthesize setItemName;
@synthesize setItemPrice;
@synthesize setShopID;
@synthesize setMakeTime;
@synthesize setItemImage;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [InternationalControl initUserLanguage];
    NSBundle *bundle = [InternationalControl bundle];
    //显示菜单文字
    langLblDrink.text = [bundle localizedStringForKey:@"SHOP_ORDER_DRINK" value:nil table:@"InfoPlist"];
    langLblCustom.text = [bundle localizedStringForKey:@"SHOP_ORDER_CUSTOM" value:nil table:@"InfoPlist"];
    
    NSString *langTxtOK = [bundle localizedStringForKey:@"SHOP_ORDER_OK" value:nil table:@"InfoPlist"];
    [btnPost setTitle:langTxtOK forState:UIControlStateNormal];

    langTxtAlertWarning = [bundle localizedStringForKey:@"ALERT_WARNING" value:nil table:@"InfoPlist"];
    langTxtAlertOK = [bundle localizedStringForKey:@"ALERT_OK" value:nil table:@"InfoPlist"];
    langTxtAlertFail = [bundle localizedStringForKey:@"ALERT_FAIL" value:nil table:@"InfoPlist"];
    langTxtNetwork = [bundle localizedStringForKey:@"NETWORK_FAIL" value:nil table:@"InfoPlist"];
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = setItemName;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
    NSString *getSelectDrink = nil;
    NSString *getDrinkPrice = nil;
    NSString *getSelectCustom = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getSelectDrink = [defaults objectForKey:@"cloudin_foodwalker_select_drink"];
        getDrinkPrice = [defaults objectForKey:@"cloudin_foodwalker_select_drink_price"];
        getSelectCustom = [defaults objectForKey:@"cloudin_foodwalker_select_custom"];
    }
    
    [btnSelectDrink setTitle:[NSString stringWithFormat:@"%@%@",getSelectDrink,getDrinkPrice] forState:UIControlStateNormal];
    [btnSelectCustom setTitle:getSelectCustom forState:UIControlStateNormal];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = MainBgColor;
    
    num = 1;
    price = 0;
    
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
    
    
    lblMoney.text = [NSString stringWithFormat:@"$%@",setItemPrice];
    btnMinus.hidden = TRUE;
    
    
    //初始化本地数据库
    dbManager = [[SQLiteManager alloc] initWithDatabaseNamed:@"cloudin_foodwalker_shopcart.db"];
    //NSString *dump = [dbManager getDatabaseDump];
    //NSLog(@"读取SQLite数据库:%@",dump);
    //如果没有创建表，则先创建
    NSError *error = [dbManager doQuery:@"CREATE TABLE IF NOT EXISTS shopcarts (id integer primary key autoincrement, cart_id text, cart_name text, cart_image text, cart_quantity integer, cart_price text,  shop_id text, add_date text, make_time text);"];
    if (error != nil) {
        NSLog(@"Error1: %@",[error localizedDescription]);
    }
    
}

//返回页面
- (void)backView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"2" forKey:@"cloudin_foodwalker_isshow_check_items"];
    
    //self.navigationController.navigationBarHidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES]; //back
    
    //[self dismissViewControllerAnimated:YES completion:^{
    //TODO
    //}];
}

//选择
- (IBAction) btnSelectDrinkPressed: (id) sender
{
    ItemDrinkListViewController *nextController = [ItemDrinkListViewController alloc];
    nextController.setShopID = setShopID;
    nextController.setMainID = @"0";
    nextController.setTitle = langLblDrink.text;
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//选择
- (IBAction) btnSelectCustomPressed: (id) sender
{
    ItemCustomListViewController *nextController = [ItemCustomListViewController alloc];
    nextController.setShopID = setShopID;
    nextController.setMainID = @"0";
    nextController.setTitle = langLblCustom.text;
    [nextController sendGetDatas];
    nextController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:nextController animated:YES];
    [nextController release];
}

//按完Done键以后关闭键盘
- (IBAction) txtAmountNextEditing:(id)sender
{
    //获得焦点
    [txtAmount resignFirstResponder];
}


- (IBAction) btnPlusPressed: (id) sender
{
    btnMinus.hidden = FALSE;
    num = [txtAmount.text integerValue];
    num++;
    
    price = [setItemPrice integerValue];
    price = price*num;

    lblMoney.text = [NSString stringWithFormat:@"$%d",price];
    txtAmount.text = [NSString stringWithFormat:@"%d",num];
}

- (IBAction) btnMinusPressed: (id) sender
{
    num = [txtAmount.text integerValue];
    num--;
    if (num<=1) {
        btnMinus.hidden = TRUE;
        num = 1;
    }
    
    price = [setItemPrice integerValue];
    price = price*num;
    
    lblMoney.text = [NSString stringWithFormat:@"$%d",price];
    txtAmount.text = [NSString stringWithFormat:@"%d",num];
}

//添加到数据库
- (IBAction) btnConfirmPressed: (id) sender
{
    NSString *getProductID = [NSString stringWithFormat:@"%@",setItemID];
    NSString *getSaveProductID = nil;
    NSString *getMakeTime = nil;
    NSString *getDrinkPrice = nil;
    NSString *getDrinkID = nil;
    NSString *getDrinkName = nil;
    NSString *getCustomPrice = nil;
    NSString *getCustomID = nil;
    NSString *getCustomName = nil;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getSaveProductID = [defaults objectForKey:@"cloudin_foodwalker_selected_pids"];
        getMakeTime = [defaults objectForKey:@"cloudin_foodwalker_menus_maketime"];
        getDrinkPrice = [defaults objectForKey:@"cloudin_foodwalker_select_drink_price"];
        getDrinkID = [defaults objectForKey:@"cloudin_foodwalker_select_drinkid"];
        getDrinkName = [defaults objectForKey:@"cloudin_foodwalker_select_drink"];
        
        getCustomPrice = [defaults objectForKey:@"cloudin_foodwalker_select_custom_price"];
        getCustomID = [defaults objectForKey:@"cloudin_foodwalker_select_custom_priceid"];
        getCustomName = [defaults objectForKey:@"cloudin_foodwalker_select_custom"];
    }
    
    
    NSString *getPrice = lblMoney.text;
    getPrice = [getPrice stringByReplacingOccurrencesOfString:@"$" withString:@""];
    
    int order = [getPrice integerValue];
    int drink = [getDrinkPrice integerValue];
    int total = order + drink;
    
    NSString *getAmount = txtAmount.text;
    
    //存储
    getProductID = [NSString stringWithFormat:@"%@,%@",getSaveProductID,getProductID];
    getProductID = [getProductID stringByReplacingOccurrencesOfString:@",," withString:@","];
    [defaults setObject:getProductID forKey:@"cloudin_foodwalker_selected_pids"];
    [defaults setObject:[NSString stringWithFormat:@"%d",total] forKey:@"cloudin_foodwalker_total_price"];
    [defaults setObject:getAmount forKey:@"cloudin_foodwalker_total_amount"];
    

    //饮品也要加入数据库
    if (drink>0) {
        
        //添加到本地数据库
        BOOL boolValue = [self checkMenuIDIsExist:getDrinkID];
        //NSLog(@"bool=%d",boolValue);
        if (boolValue) {
            NSLog(@"update");
            //如果存在，更新
            NSString *sqlStr = [NSString stringWithFormat:@"update shopcarts set cart_quantity=cart_quantity+1 where cart_id='%@';",getDrinkID];
            //NSLog(@"%@",sqlStr);
            NSError *error = [dbManager doQuery:sqlStr];
            if (error != nil) {
                NSLog(@"Error3: %@",[error localizedDescription]);
            }
            //NSString *dump = [dbManager getDatabaseDump];
            //NSLog(@"%@",dump);
        }
        else{
            NSLog(@"add");
            //如果不存在，则添加
            NSString *getDate = [Utils getTodayString];
            NSString *sqlStr = [NSString stringWithFormat:@"insert into shopcarts (cart_id, cart_name, cart_image, cart_quantity, cart_price, shop_id, add_date, make_time) values ('%@','%@','%@',%@,'%@',%@,'%@','%@');",getDrinkID,getDrinkName, setItemImage, @"1", getDrinkPrice, setShopID, getDate,setMakeTime];
            NSError *error2 = [dbManager doQuery:sqlStr];
            if (error2 != nil) {
                NSLog(@"Error2: %@",[error2 localizedDescription]);
            }
            
        }
    }
    
    
    if (getCustomName.length>0) {
        
        //添加到本地数据库
        BOOL boolValue = [self checkMenuIDIsExist:getCustomID];
        //NSLog(@"bool=%d",boolValue);
        if (boolValue) {
            NSLog(@"update");
            //如果存在，更新
            NSString *sqlStr = [NSString stringWithFormat:@"update shopcarts set cart_quantity=cart_quantity+1 where cart_id='%@';",getCustomID];
            //NSLog(@"%@",sqlStr);
            NSError *error = [dbManager doQuery:sqlStr];
            if (error != nil) {
                NSLog(@"Error3: %@",[error localizedDescription]);
            }
            //NSString *dump = [dbManager getDatabaseDump];
            //NSLog(@"%@",dump);
        }
        else{
            NSLog(@"add");
            //如果不存在，则添加
            NSString *getDate = [Utils getTodayString];
            NSString *sqlStr = [NSString stringWithFormat:@"insert into shopcarts (cart_id, cart_name, cart_image, cart_quantity, cart_price, shop_id, add_date, make_time) values ('%@','%@','%@',%@,'%@',%@,'%@','%@');",getCustomID,getCustomName, setItemImage, @"1", getCustomPrice, setShopID, getDate,setMakeTime];
            NSError *error2 = [dbManager doQuery:sqlStr];
            if (error2 != nil) {
                NSLog(@"Error2: %@",[error2 localizedDescription]);
            }
            
        }

    }
    
    //添加到本地数据库
    BOOL boolValue = [self checkMenuIDIsExist:setItemID];
    //NSLog(@"bool=%d",boolValue);
    if (boolValue) {
        NSLog(@"update");
        //如果存在，更新
        NSString *sqlStr = [NSString stringWithFormat:@"update shopcarts set cart_quantity=cart_quantity+1 where cart_id='%@';",setItemID];
        //NSLog(@"%@",sqlStr);
        NSError *error = [dbManager doQuery:sqlStr];
        if (error != nil) {
            NSLog(@"Error3: %@",[error localizedDescription]);
        }
        //NSString *dump = [dbManager getDatabaseDump];
        //NSLog(@"%@",dump);
    }
    else{
        NSLog(@"add");
        //如果不存在，则添加
        NSString *getDate = [Utils getTodayString];
        NSString *sqlStr = [NSString stringWithFormat:@"insert into shopcarts (cart_id, cart_name, cart_image, cart_quantity, cart_price, shop_id, add_date, make_time) values ('%@','%@','%@',%@,'%@',%@,'%@','%@');",setItemID,setItemName, setItemImage, getAmount, setItemPrice, setShopID, getDate,setMakeTime];
        NSError *error2 = [dbManager doQuery:sqlStr];
        if (error2 != nil) {
            NSLog(@"Error2: %@",[error2 localizedDescription]);
        }
        //NSString *dump = [dbManager getDatabaseDump];
        //NSLog(@"%@",dump);
        
        //读取历史记录，对比，如果历史的比当前小，则存当前的进入
        int historyMinute = [getMakeTime integerValue];
        int curMinute = [setMakeTime integerValue];
        if (historyMinute< curMinute) {
            NSString *saveMinute = [NSString stringWithFormat:@"%d",curMinute];
            [defaults setObject:saveMinute forKey:@"cloudin_foodwalker_menus_maketime"];
        }

    }
    

    [self backView];
}

//检测菜品是否存在
-(BOOL)checkMenuIDIsExist:(NSString *)menuId
{
    BOOL bValue = FALSE;
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from shopcarts where cart_id='%@'",menuId];
    //NSLog(@"sql=%@",sqlStr);
    NSArray *array = [dbManager getRowsForQuery:sqlStr];
    //NSError *error = [dbManager doQuery:sqlStr];
    //if (error != nil) {
    //NSLog(@"Error: %@",[error localizedDescription]);
    //}
    int arrayNum = array.count;
    NSLog(@"count1=%d",arrayNum);
    if (arrayNum > 0) {
        bValue = TRUE;
    }
    
    return  bValue;
}

//统计菜品数量
-(int)countMenuID:(NSString *)menuId
{
    int num=0;
    
    NSString *sqlStr = [NSString stringWithFormat:@"select cart_quantity from shopcarts where cart_id=%@",menuId];
    //NSLog(@"sql=%@",sqlStr);
    NSArray *array = [dbManager getRowsForQuery:sqlStr];
    if (array.count>0) {
        NSString *getCartQuantity = [[array objectAtIndex:0] objectForKey:@"cart_quantity"];
        num = [getCartQuantity integerValue];
        NSLog(@"count num=%d",num);
        if (num==1) {
            [self deleteMenuId:menuId];
        }
    }
    
    return num;
}

-(void)deleteMenuId:(NSString *)menuId
{
    //从数据库中每次减去1
    NSString *sqlStr = [NSString stringWithFormat:@"delete from shopcarts where cart_id='%@';",menuId];
    NSLog(@"%@",sqlStr);
    NSError *error = [dbManager doQuery:sqlStr];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
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
