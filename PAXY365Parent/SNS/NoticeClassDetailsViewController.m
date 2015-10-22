//
//  NoticeClassDetailsViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/25.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "NoticeClassDetailsViewController.h"

#import "MessageCommentAddViewController.h"

#import "MessageCommentCell.h"
#import "CommentEntity.h"
#import "Common.h"
#import "Config.h"
#import "ParseJson.h"
#import "DataSource.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface NoticeClassDetailsViewController ()

@end

@implementation NoticeClassDetailsViewController
@synthesize loadMoreCell;
@synthesize setCommentID;
@synthesize setTitle;
@synthesize setFlag;
@synthesize setDate;
@synthesize setImage;
@synthesize setDesc;
@synthesize setName;


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //接收用户操作返回结果消息
    NSString *flagShowMessage = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        flagShowMessage = [standardUserDefaults objectForKey:@"cloudin_365paxy_message_comments"];
    }
    if ([flagShowMessage isEqualToString:@"1"]) {
        
        [self showPopMessage:@"评论成功"];
        [self sendGetDatas];
    }
    if ([flagShowMessage isEqualToString:@"2"]) {
        
        [self showPopMessage:@"删除成功"];
    }
}

//显示弹出消息
-(void)showPopMessage:(NSString *)message
{
    //如果放在有TableView的页面，MBProgressHUD必须自定义变量，不能采用HUD全局变量，会冲突
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_comments"];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[CommentEntity class]])
    {
        CommentEntity *data = (CommentEntity *)object;
        NSString *getUserID = data.UserID;
        NSString *getNickName = [NSString stringWithFormat:@"回复【%@】",data.UserName];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:getUserID forKey:@"cloudin_365paxy_commentsadd_userid"];
        [defaults setObject:@"2" forKey:@"cloudin_365paxy_commentsadd_flag"];//1=新增，=2回复
        [defaults setObject:getNickName forKey:@"cloudin_365paxy_commentsadd_title"];
        
        MessageCommentAddViewController *nextController = [[MessageCommentAddViewController alloc] init];
        nextController.setMessageID = setCommentID;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[CommentEntity class]])
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
    return self.datas.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[CommentEntity class]])
    {
        static NSString *identifier = @"CELL0";
        
        MessageCommentCell *cell  = (MessageCommentCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageCommentCell" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        CommentEntity *news = (CommentEntity *)object;
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
    
    //Close
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    
    //新增
    UIImage *saveImage = [UIImage imageNamed: @"icon_write.png"];
    UIView *containingSaveView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, saveImage.size.width, saveImage.size.height)] autorelease];
    UIButton *saveUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveUIButton setBackgroundImage:saveImage forState:UIControlStateNormal];
    //[saveUIButton setTitle:langTxtRefresh forState:UIControlStateNormal];
    [saveUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveUIButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    saveUIButton.frame = CGRectMake(0, 0, saveImage.size.width, saveImage.size.height);
    [saveUIButton addTarget:self action:@selector(gotoAdd) forControlEvents:UIControlEventTouchUpInside];
    [containingSaveView addSubview:saveUIButton];
    UIBarButtonItem *containingSaveButton = [[[UIBarButtonItem alloc] initWithCustomView:containingSaveView] autorelease];
    self.navigationItem.rightBarButtonItem = containingSaveButton;
    
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = setTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
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
    
    [self iniView:@"icon_sns_love_off"];
    
    //检测收藏状态
    //[self checkFavorite];
    //[NSThread detachNewThreadSelector:@selector(checkFavorite) toTarget:self withObject:nil];
    
}

//关闭页面
- (void)closeView
{
    //self.navigationController.navigationBarHidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES]; //back
}

- (void)gotoAdd
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"-1" forKey:@"cloudin_365paxy_commentsadd_userid"];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_commentsadd_flag"];//1=新增，=2回复
    [defaults setObject:@"发布评论" forKey:@"cloudin_365paxy_commentsadd_title"];
    
    MessageCommentAddViewController *nextController = [[MessageCommentAddViewController alloc] init];
    nextController.setMessageID = setCommentID;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
    [self presentViewController:navigationController animated:YES completion:^{
        //
    }];
    [nextController release];
    [navigationController release];
}


- (void)iniView:(NSString *)image
{
    int h = -100;
    //加载点赞用户列表
    /*
    NSString *getUsersList = nil;
    @try {
        
        NSString *urlString = [NSString stringWithFormat:@"%@?cid=%@",CommentLoveUrl,setCommentID];
        NSLog(@"URL=%@",urlString);
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"Results"];
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            getUsersList = [statusDict objectForKey:@"UsersList"];
            
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
    NSLog(@"UsersList:%@",getUsersList);
    if (getUsersList.length<=0) {
        h = -100;
    }*/
    
    //自定义加载显示区域开始
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 20, 320, 480 + h )];
    headerView.backgroundColor = WhiteBgColor;
    
    //背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 320, 200)];
    [headerView addSubview:imageView];
    
    if ([setImage rangeOfString:@".png"].location !=NSNotFound) {
        setImage = [setImage stringByReplacingOccurrencesOfString:@".png" withString:@"_m.jpg"];
    }
    else if ([setImage rangeOfString:@".jpg"].location !=NSNotFound && [setImage rangeOfString:@"_m.jpg"].location ==NSNotFound) {
        setImage = [setImage stringByReplacingOccurrencesOfString:@".jpg" withString:@"_m.jpg"];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:setImage forKey:@"cloudin_365paxy_show_image_notice"];
    
    [imageView setImageWithURL:[NSURL URLWithString:setImage]
              placeholderImage:[UIImage imageNamed:@"default_image_320_200.png"] options:SDWebImageProgressiveDownload
                      progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                          //加载图片及指示器效果
                          if (!activityIndicator) {
                              [imageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                              activityIndicator.center = imageView.center;
                              //[activityIndicator startAnimating];//有BUG，不会出现在正中间，而且偶尔转的不会停止
                          }
                      } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                          //清除指示器效果
                          [activityIndicator removeFromSuperview];
                          activityIndicator = nil;
                      }];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:gesture];
    
    
    //介绍
    UITextView *lblDesc = [[UITextView alloc] initWithFrame: CGRectMake(10,250,300,100)];
    lblDesc.text = setDesc;
    lblDesc.textAlignment = NSTextAlignmentLeft;
    lblDesc.textColor = TxtGray;
    lblDesc.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.5];
    lblDesc.font = [UIFont systemFontOfSize:15];
    lblDesc.editable = FALSE;
    [headerView addSubview:lblDesc];
    
    //教师姓名
    UILabel *lblTitle = [[UILabel alloc] initWithFrame: CGRectMake(10,205,250,21)];
    lblTitle.text = [NSString stringWithFormat:@"来自：%@",setName];
    lblTitle.textAlignment = NSTextAlignmentLeft;
    lblTitle.textColor = TxtGray;
    lblTitle.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:lblTitle];
    
    //日期
    UILabel *lblDate = [[UILabel alloc] initWithFrame: CGRectMake(10,230,250,21)];
    lblDate.text = [NSString stringWithFormat:@"日期：%@",setDate];
    lblDate.textAlignment = NSTextAlignmentLeft;
    lblDate.textColor = TxtGray;
    lblDate.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:lblDate];
    
    //点赞按钮
    UIButton *btnLove = [[UIButton alloc] initWithFrame: CGRectMake(280,205,30,30)];
    [btnLove setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btnLove addTarget:self action:@selector(gotoFavorite) forControlEvents:UIControlEventTouchUpInside];
    //[headerView addSubview:btnLove];
    
    /*
    if (getUsersList.length>0) {
        
        //显示点赞用户
        UILabel *lblShow = [[UILabel alloc] initWithFrame: CGRectMake(0,360,320,25)];
        //lblShow.text = @"  大家点评";
        lblShow.textAlignment = NSTextAlignmentLeft;
        lblShow.textColor = TxtGray;
        lblShow.backgroundColor = TxtLightGray2;
        lblShow.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:lblShow];
        //评论图标
        UIImageView *imageLove = [[UIImageView alloc] initWithFrame: CGRectMake(0, 358, 30, 30)];
        imageLove.image = [UIImage imageNamed:@"icon_sns_love"];
        [headerView addSubview:imageLove];
        //点赞用户
        UILabel *lblShowUsers = [[UILabel alloc] initWithFrame: CGRectMake(10,390,300,65)];
        lblShowUsers.text = getUsersList;
        //赵霁 孙利 王紫紫 李斯 朱原元 张倩倩 赵霁 孙利 王紫紫 李斯 朱原元 张倩倩 赵霁 孙利 王紫紫 李斯 朱原元 张倩倩 赵霁 孙利3
        lblShowUsers.textAlignment = NSTextAlignmentLeft;
        lblShowUsers.numberOfLines = 3;
        lblShowUsers.textColor = TxtBlue;
        lblShowUsers.backgroundColor = [UIColor clearColor];
        lblShowUsers.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:lblShowUsers];
    }*/
    
    
    //图标背景
    UILabel *lblCommentBg = [[UILabel alloc] initWithFrame: CGRectMake(0,450+h,320,25)];
    //lblShow.text = @"  大家点评";
    lblCommentBg.textAlignment = NSTextAlignmentLeft;
    lblCommentBg.textColor = TxtGray;
    lblCommentBg.backgroundColor = TxtLightGray2;
    lblCommentBg.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:lblCommentBg];
    //评论图标
    UIImageView *imageComment = [[UIImageView alloc] initWithFrame: CGRectMake(0, 448+h, 30, 30)];
    imageComment.image = [UIImage imageNamed:@"icon_sns_comment"];
    [headerView addSubview:imageComment];
    
    self.tableView.tableHeaderView = headerView;
    
    
}


-(void) sendGetDatas
{
    [super sendGetDatas];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"20",@"PageSize",@"1",@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    NSString *getCurrentUrl=[NSString stringWithFormat:@"%@?mid=%@&flag=%@",CommentListUrl,setCommentID,setFlag];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];//点击更多时弹出文字对话框提醒，不是图片
    
    self.loadMoreCell.ac.hidden = NO;
    [self.loadMoreCell.ac startAnimating];
    
    self.loadMoreCell.button.hidden = YES;
    self.loadingmore = YES;
    
    currentPage = currentPage + 1;
    
    NSString *pageString = [NSString stringWithFormat:@"%d",currentPage];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:pageString,@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    
    
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];//点击更多时弹出文字对话框提醒，不是图片
    [defaults setObject:@"没有更多数据" forKey:@"cloudin_365paxy_nodata_show_word"];
    //more data tip end
    
    NSString *pageUrl = [NSString stringWithFormat:@"%@?PageSize=20&Page=%d&mid=%@&flag=%@",CommentListUrl,currentPage,setCommentID,setFlag];
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
        temparray = [ParseJson getCommentsList:jsonString]; //此处每次都需要更改
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


//点击查看图片
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    //接收用户操作返回结果消息
    NSString *showImageURL = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        showImageURL = [defaults objectForKey:@"cloudin_365paxy_show_image_notice"];
    }
    
    NSInteger count = 1;
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    
    MJPhoto *photo = [[MJPhoto alloc] init];
    // 替换为中等尺寸图片
    if ([showImageURL rangeOfString:@".png"].location !=NSNotFound) {
        showImageURL = [showImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_b.jpg"];
    }
    else if ([showImageURL rangeOfString:@".jpg"].location !=NSNotFound && [showImageURL rangeOfString:@"_b.jpg"].location !=NSNotFound) {
        showImageURL = [showImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_b.jpg"];
    }
    photo.url = [NSURL URLWithString:showImageURL]; // 图片路径
    //photo.srcImageView = self.scrollView.subviews[i]; // 来源于哪个UIImageView
    [photos addObject:photo];
    
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

//检测是否已收藏
- (void)checkFavorite
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        if (getUserID==nil) {
            getUserID = @"0";
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&newsid=%@&uid=%@&flag=3",CheckFavoriteUrl,setCommentID,getUserID];
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
                
                flag = 1;
                //已收藏
                [self iniView:@"icon_sns_love_on"];
            }
            if ([getStatus isEqualToString:@"2"]) {
                
                flag = 0;
                //未收藏
                [self iniView:@"icon_sns_love_off"];
            }
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
}

//点赞
- (void)gotoFavorite
{
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    if (flag==1) {
        //已收藏
        loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
        [loadingView starRun];
        [self.view addSubview:loadingView];
        
        [self performSelectorOnMainThread:@selector(cancelFavorite) withObject:nil waitUntilDone:NO];//主线程
        //[NSThread detachNewThreadSelector:@selector(cancelFavorite) toTarget:self withObject:nil];//子线程会与MBProgress冲突
        //[self cancelFavorite];
    }
    if (flag==0) {
        //未收藏
        loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
        [loadingView starRun];
        [self.view addSubview:loadingView];
        
        [self performSelectorOnMainThread:@selector(addFavorite) withObject:nil waitUntilDone:NO];//主线程
        //[NSThread detachNewThreadSelector:@selector(addFavorite) toTarget:self withObject:nil];
        //[self addFavorite];
    }
}


//添加点赞
- (void)addFavorite
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            
            getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&flag=3&newsid=%@&uid=%@",AddFavoriteUrl,setCommentID,getUserID];
        
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
                
                flag = 1;
                [self iniView:@"icon_sns_love_on"];
                
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"点赞失败"
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
    
    [loadingView stopRun];
}

//取消点赞
- (void)cancelFavorite
{
    
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            
            getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&newsid=%@&uid=%@&flag=3",CancelFavoriteUrl,setCommentID,getUserID];
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
                
                flag=0;
                [self iniView:@"icon_sns_love_off"];
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:@"取消失败"
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
    
    [loadingView stopRun];
}

-(void) dealloc
{
    self.loadMoreCell = nil;
    [super dealloc];
}

@end
