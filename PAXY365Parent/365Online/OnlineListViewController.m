//
//  OnlineListViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "OnlineListViewController.h"

#import "InfoDetailViewController.h"
#import "WebViewController.h"

#import "InfoCell.h"
#import "NewsEntity.h"
#import "Config.h"
#import "Common.h"
#import "DataSource.h"
#import "ParseJson.h"
#import "InternationalControl.h"
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

@interface OnlineListViewController ()

@end

@implementation OnlineListViewController
@synthesize loadMoreCell;
@synthesize setTitle;
@synthesize imagePlayerView;
@synthesize imageURLs;
@synthesize openURLs;

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
        InfoDetailViewController *vc = [InfoDetailViewController alloc];
        vc.setTitle = @"详情";
        vc.setURL = getURL;
        vc.setNewsID = data.newsId;
        vc.setNewsTitle = data.newsTitle;
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
        if ([getDate isEqualToString:@"1"]) {   //隐藏日期
            return 70;
        }
        else{     //显示日期
            return 100;
        }
    }
    else    // 加载按钮
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
        static NSString *identifier1 = @"CELLTWO";
        
        InfoCell *cell  = nil;
        NewsEntity *data = (NewsEntity *) object;
        NSString *getDate = data.addDate;
        if ([getDate isEqualToString:@"1"]) {      //取出隐藏日期的cell
            cell  = (InfoCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier0];
        }
        else{     // 取出显示日期的cell
            cell  = (InfoCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier1];
        }
        
        if (cell == nil)
        {
            NSString *getDate = data.addDate;
            if ([getDate isEqualToString:@"1"]) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:self options:nil] objectAtIndex:0];
            }
            else{
                cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoCellTwo" owner:self options:nil] objectAtIndex:0];
                
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
    titleLabel.text = @"安全连连看";
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"10" forKey:@"cloudin_365paxy_news_type"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_news_flag"];
    
    [self iniView];
}

//返回页面
- (void)backView
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
}


- (void)iniView
{
    //自定义加载显示区域开始
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 150)];
    headerView.backgroundColor = WhiteBgColor;
    
    //初始化第一个
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"cloudin_365paxy_order_flag"];
    
    // add segment
    segmentMenus = [[UISegmentedControl alloc]
                    initWithFrame:CGRectMake(5, 10, 310, 29)];
    [segmentMenus insertSegmentWithTitle:@"教育新闻" atIndex:0 animated:YES];
    [segmentMenus insertSegmentWithTitle:@"通知公告" atIndex:1 animated:YES];
    [segmentMenus insertSegmentWithTitle:@"安全信息预警" atIndex:2 animated:YES];
    segmentMenus.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentMenus.tintColor = TxtLightGray;
    //[segmentLanguage sizeToFit];
    [segmentMenus addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    segmentMenus.selectedSegmentIndex = 0;
    
    //[headerView addSubview:segmentMenus];
    
    //加载广告
    imagePlayerView = [[ImagePlayerView alloc] init];
    imagePlayerView.frame = CGRectMake(0, 0, 320, 150);
    UIImage *backgroundImage = [[UIImage alloc] init];
    backgroundImage = [UIImage imageNamed:@"default_image_320_150.png"];
    imagePlayerView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    //[headerView addSubview:imagePlayerView];
    
    //[NSThread detachNewThreadSelector:@selector(loadAdsData) toTarget:self withObject:nil];
    
    //self.tableView.tableHeaderView = headerView;
}

// selected menus
-(void)selected:(id)sender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (segmentMenus.selectedSegmentIndex) {
        case 0:
            
            [self.datas removeAllObjects];
            [defaults setObject:@"2" forKey:@"cloudin_365paxy_news_type"];
            [defaults setObject:@"0" forKey:@"cloudin_365paxy_news_flag"];
            [self sendGetDatas];
            [tableView reloadData];
            break;
        case 1:
            
            [self.datas removeAllObjects];
            [defaults setObject:@"3" forKey:@"cloudin_365paxy_news_type"];
            [defaults setObject:@"0" forKey:@"cloudin_365paxy_news_flag"];
            
            [self sendGetDatas];
            [tableView reloadData];
            break;
        case 2:
            
            [self.datas removeAllObjects];
            [defaults setObject:@"4" forKey:@"cloudin_365paxy_news_type"];
            [defaults setObject:@"0" forKey:@"cloudin_365paxy_news_flag"];
            
            [self sendGetDatas];
            [tableView reloadData];
            break;
            
        default:
            break;
    }
}


//加载广告
- (void)loadAdsData
{
    @try {
        
        imageURLs = [[NSMutableArray alloc] init];
        openURLs = [[NSMutableArray alloc] init];
        
        //从服务端获取广告
        NSString *urlString = [NSString stringWithFormat:@"%@?flag=3",AdsListUrl];
        NSLog(@"URL=%@",urlString);
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"List"];
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getImage = [statusDict objectForKey:@"AdsImage"];
            NSString *getURL = [statusDict objectForKey:@"AdsURL"];
            //NSString *getAdsTitle = [statusDict objectForKey:@"AdsTitle"];
            //NSString *getAdsType = [statusDict objectForKey:@"AdsType"];
            //NSString *getNewsID = [statusDict objectForKey:@"NewsID"];
            
            [self.imageURLs addObject:[NSURL URLWithString:getImage]];
            [self.openURLs addObject:[NSURL URLWithString:getURL]];
        }
        
        //绑定广告
        [self.imagePlayerView initWithCount:self.imageURLs.count delegate:self];
        self.imagePlayerView.scrollInterval = 5.0f;
        self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomRight;
        self.imagePlayerView.hidePageControl = NO;
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
}


#pragma mark - ImagePlayerViewDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    [imageView setImageWithURL:[imageURLs objectAtIndex:index] placeholderImage:[UIImage imageNamed:@"default_image_320_150.png"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //YES=隐藏，NO=显示
    [defaults setObject:@"NO" forKey:@"cloudin_365paxy_return_showback"];
    
    NSString *getURL = [self.openURLs objectAtIndex:index];
    getURL = [NSString stringWithFormat:@"%@",getURL];
    WebViewController *vc = [WebViewController alloc];
    vc.setTitle = AppName;
    vc.setURL = getURL;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void) sendGetDatas
{
    [super sendGetDatas];
    
    NSString *getType = nil;
    NSString *getFlag = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getType = [defaults objectForKey:@"cloudin_365paxy_news_type"];
        getFlag = [defaults objectForKey:@"cloudin_365paxy_news_flag"];
    }
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"20",@"PageSize",@"1",@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    NSString *getCurrentUrl=[NSString stringWithFormat:@"%@?type=%@&flag=%@",NewsListUrl,getType,getFlag];
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
    
    NSString *getType = nil;
    NSString *getFlag = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getType = [defaults objectForKey:@"cloudin_365paxy_news_type"];
        getFlag = [defaults objectForKey:@"cloudin_365paxy_news_flag"];
    }
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *getWords = DefaultNoData;
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];//点击更多时弹出文字对话框提醒，不是图片
    [defaults setObject:getWords forKey:@"cloudin_365paxy_nodata_show_word"];
    
    NSString *pageString = [NSString stringWithFormat:@"%d",currentPage];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:pageString,@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    
    NSString *pageUrl = [NSString stringWithFormat:@"%@?PageSize=20&Page=%d&type=%@&flag=%@",NewsListUrl,currentPage,getType,getFlag];
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
