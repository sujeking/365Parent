//
//  MyFavoriteViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "MyFavoriteViewController.h"

#import "WebViewController.h"

#import "InfoShareCell.h"
#import "NewsEntity.h"
#import "Config.h"
#import "Common.h"
#import "DataSource.h"
#import "ParseJson.h"
#import "InternationalControl.h"
#import "GRAlertView.h"
#import "AppDelegate.h"
#import "Animations.h"

/* web start */
#import "TOWebViewController.h"

#ifndef NSFoundationVersionNumber_iOS_6_1
#define NSFoundationVersionNumber_iOS_6_1  993.00
#endif

/* Detect if we're running iOS 7.0 or higher */
#define MINIMAL_UI (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
/* web end */

@interface MyFavoriteViewController ()

@end

@implementation MyFavoriteViewController
@synthesize loadMoreCell;
@synthesize setTitle;
@synthesize setFlag;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[NewsEntity class]])
    {
        NewsEntity *data = (NewsEntity *)object;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //YES=隐藏，NO=显示
        [defaults setObject:@"NO" forKey:@"cloudin_365paxy_return_showback"];
        
        NSString *getURL = [NSString stringWithFormat:@"%@?id=%@",ViewNewsUrl,data.newsId];
        //NSURL *url = [NSURL URLWithString:getURL];
        //TOWebViewController *vc = [[TOWebViewController alloc] initWithURL:url];
        //[self.navigationController pushViewController:vc animated:YES];
        
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
    
    if ([object isKindOfClass:[NewsEntity class]])
    {
        NewsEntity *data = (NewsEntity *) object;
        NSString *getDate = data.addDate;
        if ([getDate isEqualToString:@"1"]) {  //隐藏日期
            return 70;
        }
        else{    // 显示日期
            return 100;
        }
    }
    else   // 加载按钮所在cell
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
    
    if ([object isKindOfClass:[NewsEntity class]])
    {
        static NSString *identifier0 = @"CELL0";
        static NSString *identifier1 = @"InfoShareCell2";
        
        InfoShareCell *cell  = nil;
        NewsEntity *data = (NewsEntity *) object;
        NSString *getDate = data.addDate;
        if ([getDate isEqualToString:@"1"]) {   //取出隐藏日期的cell
            cell  = (InfoShareCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier0];
        }
        else{    //取出显示日期的cell
            cell  = (InfoShareCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier1];
        }
        
        
        if (cell == nil)
        {
            NSString *getDate = data.addDate;
            if ([getDate isEqualToString:@"1"]) {   //加载隐藏日期的cell
                cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoShareCell" owner:self options:nil] objectAtIndex:0];
            }
            else{     //加载显示日期的cell
                cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoShareCellTwo" owner:self options:nil] objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        NewsEntity *news = (NewsEntity *)object;
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
    titleLabel.text = setTitle;
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
 
    //接收车型消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delData:) name:@"cloudin_365paxy_selected_newsid" object:nil];

}

- (void) delData:(NSNotification*) notification
{
    id obj = [notification object];//通过这个获取到传递的对象
    NSString *getObj = [NSString stringWithFormat:@"%@",obj];
    if ([getObj isEqualToString:@"1"]) {
        
        NSString *getNewsID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults)
        {
            getNewsID = [standardUserDefaults objectForKey:@"cloudin_365paxy_get_newsid"];
        }
        
        //删除服务端数据
        @try {
            
            NSString *getUserID = nil;
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            if (standardUserDefaults){
                
                getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
            }
            
            NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&flag=%@&newsid=%@&uid=%@",CancelFavoriteUrl,setFlag,getNewsID,getUserID];
            
            urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                            (CFStringRef)urlString,
                                                                            NULL,
                                                                            NULL,
                                                                            kCFStringEncodingUTF8);
            NSLog(@"URL=%@",urlString);
            NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
            NSArray *loginStatus = [loginDict objectForKey:@"Results"];
            NSLog(@"Count=%lu",(unsigned long)[loginStatus count]);
            for (int i = 0; i < [loginStatus count]; i ++) {
                
                NSDictionary *statusDict = [loginStatus objectAtIndex:i];
                NSString *getStatus = [statusDict objectForKey:@"Status"];
                NSLog(@"Status=%@",getStatus);
                
                if ([getStatus isEqualToString:@"1"]) {

                    //刷新
                    [self sendGetDatas];
                    
                }
                else {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                    message:@"删除失败"
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                
                
            }
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }

        
       
        
    }
    else{
        //取消
    }
}

//返回页面
- (void)backView
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}


-(void) sendGetDatas
{
    [super sendGetDatas];
    
    NSString *getUserID = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"20",@"PageSize",@"1",@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    NSString *getCurrentUrl=[NSString stringWithFormat:@"%@?uid=%@&flag=%@",FavoriteNewsListUrl,getUserID,setFlag];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *getWords = DefaultNoData;
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];//点击更多时弹出文字对话框提醒，不是图片
    [defaults setObject:getWords forKey:@"cloudin_365paxy_nodata_show_word"];

    
    NSString *pageString = [NSString stringWithFormat:@"%d",currentPage];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:pageString,@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    
    NSString *pageUrl = [NSString stringWithFormat:@"%@?PageSize=20&Page=%d&uid=%@&flag=%@",FavoriteNewsListUrl,currentPage,getUserID,setFlag];
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
        temparray = [ParseJson getNewsList:jsonString];//此处每次都需要更改
        
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

@end
