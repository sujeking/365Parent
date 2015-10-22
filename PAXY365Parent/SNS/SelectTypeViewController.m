//
//  SelectTypeViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/24.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "SelectTypeViewController.h"

#import "Common.h"

@interface SelectTypeViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray1;

@end

@implementation SelectTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = TxtTitle;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"选择类别";
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
    
    // 初始化菜单名称
    self.dataArray1 = [NSMutableArray new];
    [self.dataArray1 addObject:@"家庭作业"];
    [self.dataArray1 addObject:@"在校表现"];
    [self.dataArray1 addObject:@"请假条"];
    [self.dataArray1 addObject:@"班级通知"];

    
    //隐藏多余的分割线
    [self setExtraCellLineHidden:self.tableView];
}

//关闭页面
- (void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

//跳转到设置界面
- (void)gotoSetting
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}

#pragma mark -
#pragma mark UITableViewDataSource

//| ----------------------------------------------------------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//| ----------------------------------------------------------------------------
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

//| ----------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //隐藏多余的分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    return (NSInteger)[self.dataArray1 count];
}


//| ----------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kStandardCellID = @"StandardCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStandardCellID];
    
    if (cell.accessoryView == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: kStandardCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    
    //cell.imageView.image = [UIImage imageNamed:[self.imagesArray1 objectAtIndex:indexPath.row]];
    cell.textLabel.text = [self.dataArray1 objectAtIndex:indexPath.row];
    cell.textLabel.textColor = TxtGray;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate

//| ----------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *getValue = [self.dataArray1 objectAtIndex:indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:getValue forKey:@"cloudin_365paxy_selectedtemp_typename"];

    [self backView];
    
    // Create the next view controller.
    // ColleagueViewController *nextController = [ColleagueViewController alloc];
    // Pass the selected object to the new view controller.
    // Push the view controller.
    // nextController.hidesBottomBarWhenPushed = YES;
    // [self.navigationController pushViewController:nextController animated:YES];
}

//| ----------------------------------------------------------------------------
//隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
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
