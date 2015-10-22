//
//  NoticeClassListViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/25.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "NoticeClassListViewController.h"

#import "WebViewController.h"
#import "HomeworkDetailsViewController.h"
#import "UpdateUserDetailsViewController.h"


#import "NoticeCell.h"
#import "MessageEntity.h"
#import "Config.h"
#import "Common.h"
#import "DataSource.h"
#import "ParseJson.h"
#import "GRAlertView.h"
#import "AppDelegate.h"
#import "GRAlertView.h"

@interface NoticeClassListViewController ()

@end

@implementation NoticeClassListViewController
@synthesize loadMoreCell;
@synthesize setTitle;
@synthesize setFlag;
@synthesize setChannelID;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *getFlagMessage = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getFlagMessage = [defaults objectForKey:@"cloudin_365paxy_message_notice"];
        
        if ([getFlagMessage isEqualToString:@"1"]) {
            [self showMessage:@"恭喜你，班级通知发布成功！"];
            
            [self.datas removeAllObjects];
            [self sendGetDatas];
        }
        
    }
}

//显示弹出消息
-(void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_notice"];
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[MessageEntity class]])
    {
        MessageEntity *data = (MessageEntity *)object;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
        [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
        [defaults setObject:@"1000" forKey:@"cloudin_365paxy_nodata_flag"];
        
        NSString *getDate = data.AddDate;
        if ([getDate isEqualToString:@"1"]) {
            //隐藏日期
            getDate = data.ShowDate;
        }
        else{
            getDate = data.AddDate;
        }
        
        NSString *getImage = data.MessageImage;
        NSLog(@"Image:%@",getImage);
        
        HomeworkDetailsViewController *vc = [HomeworkDetailsViewController alloc];
        vc.setTitle = @"详情";
        vc.setFlag = @"-1";
        vc.setCommentID = data.MessageID;
        vc.setDate = getDate;
        vc.setName = data.SendUserName;
        vc.setDesc = data.MessageContent;
        vc.setImage = getImage;
        [vc sendGetDatas];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[MessageEntity class]])
    {
        /*
         NSInteger height = 180;
         MessageEntity *data = (MessageEntity *)object;
         NSInteger lenContent = data.MessageContent.length;
         if (lenContent<90) {
         height = 100;
         }
         else{
         height = 180;
         }*/
        //return 180;
        MessageEntity *data = (MessageEntity *) object;
        NSString *getDate = data.AddDate;
        if ([getDate isEqualToString:@"1"]) {
            //隐藏日期
            return 180;
        }
        else{
            return 210;
        }
        
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
    
    if ([object isKindOfClass:[MessageEntity class]])
    {
        static NSString *identifier0 = @"CELL0";
        static NSString *identifier1 = @"LeaveCell2";
        
        NoticeCell *cell  = nil;
        MessageEntity *data = (MessageEntity *) object;
        NSString *getDate = data.AddDate;
        if ([getDate isEqualToString:@"1"]) {
            //隐藏日期
            cell  = (NoticeCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier0];
        }
        else{
            cell  = (NoticeCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier1];
        }
        
        if (cell == nil)
        {
            
            NSString *getDate = data.AddDate;
            if ([getDate isEqualToString:@"1"]) {
                //隐藏日期
                cell = [[[NSBundle mainBundle] loadNibNamed:@"NoticeCell" owner:self options:nil] objectAtIndex:0];
            }
            else{
                cell = [[[NSBundle mainBundle] loadNibNamed:@"NoticeCellTwo" owner:self options:nil] objectAtIndex:0];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        MessageEntity *news = (MessageEntity *)object;
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


-(void) sendGetDatas
{
    [super sendGetDatas];
    
    NSString *getUserID = nil;
    NSString *getSchoolID = nil;
    NSString *getClassID = nil;
    NSString *getGradeID = nil;
    NSString *getSTime = nil;
    NSString *getETime = nil;
    NSString *getKeyword = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        getSchoolID = [defaults objectForKey:@"cloudin_365paxy_schoolid"];
        getClassID = [defaults objectForKey:@"cloudin_365paxy_classid"];
        getGradeID = [defaults objectForKey:@"cloudin_365paxy_gradeid"];
        getSTime = [defaults objectForKey:@"cloudin_365paxy_starttime"];
        getETime = [defaults objectForKey:@"cloudin_365paxy_endtime"];
        getKeyword = [defaults objectForKey:@"cloudin_365paxy_keywords_notice"];
    }
    
    //1=家庭作业，2=成绩分析，3=在校表现，4=网上家访，5=请假条
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"20",@"PageSize",@"1",@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    NSString *getCurrentUrl=[NSString stringWithFormat:@"%@?uid=%@&sid=%@&cid=%@&gid=%@&channelid=%@&flag=%@&stime=%@&etime=%@&keyword=%@",MessageListUrl,getUserID,getSchoolID,getClassID,getGradeID,setChannelID,setFlag,getSTime,getETime,getKeyword,getSTime,getETime,getKeyword];
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
    NSString *getSchoolID = nil;
    NSString *getClassID = nil;
    NSString *getGradeID = nil;
    NSString *getSTime = nil;
    NSString *getETime = nil;
    NSString *getKeyword = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        getSchoolID = [defaults objectForKey:@"cloudin_365paxy_schoolid"];
        getClassID = [defaults objectForKey:@"cloudin_365paxy_classid"];
        getGradeID = [defaults objectForKey:@"cloudin_365paxy_gradeid"];
        getSTime = [defaults objectForKey:@"cloudin_365paxy_starttime"];
        getETime = [defaults objectForKey:@"cloudin_365paxy_endtime"];
        getKeyword = [defaults objectForKey:@"cloudin_365paxy_keywords_notice"];
    }
    
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *getWords = DefaultNoData;
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];//点击更多时弹出文字对话框提醒，不是图片
    [defaults setObject:getWords forKey:@"cloudin_365paxy_nodata_show_word"];
    
    NSString *pageString = [NSString stringWithFormat:@"%d",currentPage];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:pageString,@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    
    NSString *pageUrl = [NSString stringWithFormat:@"%@?PageSize=20&Page=%d&uid=%@&sid=%@&cid=%@&gid=%@&channelid=%@&flag=%@&stime=%@&etime=%@&keyword=%@",MessageListUrl,currentPage,getUserID,getSchoolID,getClassID,getGradeID,setChannelID,setFlag,getSTime,getETime,getKeyword,getSTime,getETime,getKeyword];
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
        temparray = [ParseJson getMessageList:jsonString];//此处每次都需要更改
        
        //NSLog(@"array=%@",temparray);
        //NSLog(@"array num=%d",temparray.count);
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