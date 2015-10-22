//
//  VisitListViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/17.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "VisitListViewController.h"

#import "WebViewController.h"
#import "UpdateUserDetailsViewController.h"

#import "QuestionCell.h"
#import "QuestionEntity.h"
#import "Config.h"
#import "Common.h"
#import "DataSource.h"
#import "ParseJson.h"
#import "GRAlertView.h"
#import "AppDelegate.h"

/* web start */
#import "TOWebViewController.h"

#ifndef NSFoundationVersionNumber_iOS_6_1
#define NSFoundationVersionNumber_iOS_6_1  993.00
#endif

/* Detect if we're running iOS 7.0 or higher */
#define MINIMAL_UI (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
/* web end */


@interface VisitListViewController ()

@end

@implementation VisitListViewController
@synthesize loadMoreCell;
@synthesize setTitle;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *getClassName = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getClassName = [defaults objectForKey:@"cloudin_365paxy_classname"];
        if (getClassName.length==0) {
            
            [self showDialogMessage:@"你还没有设置学校/年级/班级信息，请先到个人中心设置"];
        }
        
    }
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[QuestionEntity class]])
    {
        QuestionEntity *data = (QuestionEntity *)object;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        NSString *getURL = [NSString stringWithFormat:@"%@?qid=%@&uid=%@&flag=1",ViewQuestionUrl,data.QuestionID,getUserID];
        
        //YES=隐藏，NO=显示
        [defaults setObject:@"NO" forKey:@"cloudin_365paxy_return_showback"];
        
        //NSURL *url = [NSURL URLWithString:getURL];
        //TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
        //[self.navigationController pushViewController:webViewController animated:YES];
        
        getURL = [NSString stringWithFormat:@"%@",getURL];
        WebViewController *vc = [WebViewController alloc];
        vc.setTitle = @"详情";
        vc.setURL = getURL;
        vc.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[QuestionEntity class]])
    {
        return 80;
    }
    else
    {
        return 50;
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count=0;
    
    NSString *flagRequestData = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        flagRequestData = [defaults objectForKey:@"cloudin_365paxy_request_data"];
        if ([flagRequestData isEqualToString:@"0"]) {
            count = 0;
        }
        else{
            count = (int)self.datas.count;
        }
    }
    
    NSLog(@"flagRequestData=%@,count=%d",flagRequestData,count);
    return count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    
    NSLog(@"data count=%lu",(unsigned long)self.datas.count);
    
    if ([object isKindOfClass:[QuestionEntity class]])
    {
        static NSString *identifier = @"CELL0";
        
        QuestionCell *cell  = (QuestionCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"QuestionCell" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        QuestionEntity *news = (QuestionEntity *)object;
        cell.object = news;
        //[cell reloadImageWithImageUrl:news.headImage withDelegate:cell];
        
        
        return cell;
    }
    else
    {
        if (loadMoreCell == nil)
        {
            self.loadMoreCell = [[[NSBundle mainBundle] loadNibNamed:@"LoadMore" owner:self options:nil] objectAtIndex:0];
            self.loadMoreCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (self.loadingmore)
        {
            if (self.datas.count<=20) {
                self.loadMoreCell.button.hidden = YES;
            }
            else{
                self.loadMoreCell.button.hidden = NO;
            }
            
            self.loadMoreCell.ac.hidden = NO;
            [self.loadMoreCell.ac startAnimating];
        }
        else
        {
            if (self.datas.count<=20) {
                self.loadMoreCell.button.hidden = YES;
            }
            else{
                self.loadMoreCell.button.hidden = NO;
            }
            
            [self.loadMoreCell.button addTarget:self action:@selector(loadmore:) forControlEvents:UIControlEventTouchUpInside];
            self.loadMoreCell.ac.hidden = YES;
            [self.loadMoreCell.ac stopAnimating];
        }
        
        return self.loadMoreCell;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"网上家访";
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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = TitleColor;
    self.isShowLoading = YES;
    [self initHeaderView:self];
    if (self.datas == nil)
    {
        self.datas = [NSMutableArray array];
    }
    
    self.view.backgroundColor = WhiteBgColor;
    
    
    //自定义加载显示区域开始
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 50)];
    headerView.backgroundColor = WhiteBgColor;
    
    
    // add segment
    segmentMenus = [[UISegmentedControl alloc]
                    initWithFrame:CGRectMake(5, 10, 310, 29)];
    [segmentMenus insertSegmentWithTitle:@"最新" atIndex:0 animated:YES];
    [segmentMenus insertSegmentWithTitle:@"历史" atIndex:1 animated:YES];
    segmentMenus.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentMenus.tintColor = TxtLightGray;
    //[segmentLanguage sizeToFit];
    [segmentMenus addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    segmentMenus.selectedSegmentIndex = 0;
    
    [headerView addSubview:segmentMenus];
    self.tableView.tableHeaderView = headerView;
    
    
}

//返回页面
- (void)backView
{
    //self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}


// selected menus
-(void)selected:(id)sender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (segmentMenus.selectedSegmentIndex) {
        case 0:
            
            [self.datas removeAllObjects];
            [defaults setObject:@"2" forKey:@"cloudin_365paxy_question_flag"];
            [defaults setObject:@"1" forKey:@"cloudin_365paxy_question_type"];
            [self sendGetDatas];
            [tableView reloadData];
            break;
        case 1:
            
            [self.datas removeAllObjects];
            [defaults setObject:@"2" forKey:@"cloudin_365paxy_question_flag"];
            [defaults setObject:@"-1" forKey:@"cloudin_365paxy_question_type"];
            [self sendGetDatas];
            [tableView reloadData];
            break;
            
        default:
            break;
    }
}


-(void) sendGetDatas
{
    [super sendGetDatas];
    
    
    NSString *getUserID = nil;
    NSString *getFlag = nil;
    NSString *getType = nil;
    NSString *getSchoolID = nil;
    NSString *getClassID = nil;
    NSString *getGradeID = nil;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        getFlag = [defaults objectForKey:@"cloudin_365paxy_question_flag"];
        getType = [defaults objectForKey:@"cloudin_365paxy_question_type"];
        getSchoolID = [defaults objectForKey:@"cloudin_365paxy_schoolid"];
        getClassID = [defaults objectForKey:@"cloudin_365paxy_classid"];
        getGradeID = [defaults objectForKey:@"cloudin_365paxy_gradeid"];
    }
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"20",@"PageSize",@"1",@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    NSString *getCurrentUrl=[NSString stringWithFormat:@"%@?uid=%@&flag=%@&type=%@&sid=%@&cid=%@&gid=%@",QuestionListUrl,getUserID,getFlag,getType,getSchoolID,getClassID,getGradeID];
    getCurrentUrl = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)getCurrentUrl,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
    NSLog(@"URL=%@",getCurrentUrl);
    [[NetManager sharedManager] requestWithURL:getCurrentUrl delegate:self withUserInfo:userInfo];
    
}

-(void) loadmore:(UIButton *) sender
{
    self.loadMoreCell.ac.hidden = NO;
    [self.loadMoreCell.ac startAnimating];
    
    self.loadMoreCell.button.hidden = YES;
    self.loadingmore = YES;
    
    currentPage = currentPage + 1;
    
    NSString *getUserID = nil;
    NSString *getFlag = nil;
    NSString *getType = nil;
    NSString *getSchoolID = nil;
    NSString *getClassID = nil;
    NSString *getGradeID = nil;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        getFlag = [defaults objectForKey:@"cloudin_365paxy_question_flag"];
        getType = [defaults objectForKey:@"cloudin_365paxy_question_type"];
        getSchoolID = [defaults objectForKey:@"cloudin_365paxy_schoolid"];
        getClassID = [defaults objectForKey:@"cloudin_365paxy_classid"];
        getGradeID = [defaults objectForKey:@"cloudin_365paxy_gradeid"];
    }
    

    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *getWords = DefaultNoData;
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];//点击更多时弹出文字对话框提醒，不是图片
    [defaults setObject:getWords forKey:@"cloudin_365paxy_nodata_show_word"];
    
    NSString *pageString = [NSString stringWithFormat:@"%d",currentPage];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:pageString,@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    
    NSString *pageUrl = [NSString stringWithFormat:@"%@?PageSize=20&Page=%d&uid=%@&flag=%@&type=%@&sid=%@&cid=%@&gid=%@",QuestionListUrl,currentPage,getUserID,getFlag,getType,getSchoolID,getClassID,getGradeID];
    pageUrl = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)pageUrl,
                                                                  NULL,
                                                                  NULL,
                                                                  kCFStringEncodingUTF8);
    NSLog(@"URL=%@",pageUrl);
    [[NetManager sharedManager] requestWithURL:pageUrl delegate:self withUserInfo:userInfo];
}

#pragma -
#pragma NetManagerDelegate

-(void) netFinish:(NSDictionary *)jsonString withUserInfo:(NSDictionary *)userInfo
{
    NSMutableArray *temparray = nil;
    if (jsonString)
    {
        temparray = [ParseJson getQuestionList:jsonString];//此处每次都需要更改
        
        NSLog(@"array=%@",temparray);
        NSLog(@"array num=%lul",(unsigned long)temparray.count);
    }
    
    if (loadingmore)
    {
        if (temparray.count > 0)
        {
            [self.datas removeLastObject];
            [self.datas addObjectsFromArray:temparray];
            [self.datas addObject:@"More"];
        }
        else
        {
            currentPage = currentPage - 1;
        }
        
        self.loadMoreCell.ac.hidden = YES;
        [self.loadMoreCell.ac stopAnimating];
        
        if (self.datas.count<=20) {
            self.loadMoreCell.button.hidden = YES;
        }
        else{
            self.loadMoreCell.button.hidden = NO;
        }
        
        self.loadingmore = NO;
        [self.tableView reloadData];
    }
    else
    {
        [self.datas removeAllObjects];
        [self.datas addObjectsFromArray:temparray];
        [self.datas addObject:@"More"];
        
        [self.tableView reloadData];
        [self headerFinish];
    }
}

-(void) netError:(NSString *)errorMsg withUserInfo:(NSDictionary *)userInfo
{
    if (loadingmore)
    {
        self.loadMoreCell.ac.hidden = YES;
        [self.loadMoreCell.ac stopAnimating];
        
        self.loadMoreCell.button.hidden = NO;
        self.loadingmore = NO;
    }
    else
    {
        [self headerFinish];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void) dealloc
{
    
    self.loadMoreCell = nil;
    [super dealloc];
}

//弹出消息对话框
- (void)showDialogMessage:(NSString *)message
{
    GRAlertView *alert;
    alert = [[GRAlertView alloc] initWithTitle:@"提醒"
                                       message:message
                                      delegate:self
                             cancelButtonTitle:@"取消"
                             otherButtonTitles:@"确定", nil];
    
    [alert setTopColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           middleColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           bottomColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]             lineColor:[UIColor colorWithRed:153/255.0 green:206/255.0 blue:0/255.0 alpha:1.0]];
    
    
    [alert setFontName:@"Cochin-Bold"
             fontColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:226/255.0 alpha:1.0]
       fontShadowColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]];
    
    //[alert setImage:@"login_icon.png"];
    alert.animation = GRAlertAnimationNone;
    [alert show];
}

//处理弹出框动作
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"Button pushed: %@, index %i", alertView.title, buttonIndex);
    if (buttonIndex == 1) {
        //
        UpdateUserDetailsViewController *nextController = [UpdateUserDetailsViewController alloc];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
        
    }
    else{
        //取消
        [self backView];
    }
}


@end
