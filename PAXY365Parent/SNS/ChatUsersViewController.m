//
//  ChatUsersViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/21.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ChatUsersViewController.h"

#import "UserPageViewController.h"

#import "ContactsCell.h"
#import "ContactsEntity.h"
#import "Common.h"
#import "Config.h"
#import "ParseJson.h"

@interface ChatUsersViewController ()

@end

@implementation ChatUsersViewController
@synthesize loadMoreCell;
@synthesize setFlag;
@synthesize setTitle;


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[ContactsEntity class]])
    {
        //ContactsEntity *data = (ContactsEntity *)object;

        UserPageViewController *nextController = [UserPageViewController alloc];
        nextController.contactsEntity = object;
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
        
     
    }
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[ContactsEntity class]])
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
    if ([object isKindOfClass:[ContactsEntity class]])
    {
        static NSString *identifier = @"CELL0";
        
        ContactsCell *cell  = (ContactsCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactsCell" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        ContactsEntity *news = (ContactsEntity *)object;
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
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:20];
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
    
    //自定义加载显示区域开始
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 50)];
    headerView.backgroundColor = WhiteBgColor;
    
    
    // add segment
    segmentMenus = [[UISegmentedControl alloc]
                    initWithFrame:CGRectMake(5, 10, 310, 29)];
    [segmentMenus insertSegmentWithTitle:@"家长" atIndex:0 animated:YES];
    [segmentMenus insertSegmentWithTitle:@"教师" atIndex:1 animated:YES];
    segmentMenus.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentMenus.tintColor = TxtLightGray;
    //[segmentLanguage sizeToFit];
    [segmentMenus addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    segmentMenus.selectedSegmentIndex = 0;
    
    [headerView addSubview:segmentMenus];
    self.tableView.tableHeaderView = headerView;

}

//关闭页面
- (void)closeView
{
    //self.navigationController.navigationBarHidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES]; //back
}


// selected menus
-(void)selected:(id)sender{
    
    switch (segmentMenus.selectedSegmentIndex) {
        case 0:
            
            [self.datas removeAllObjects];
            setFlag = @"1";
            [self sendGetDatas];
            [tableView reloadData];
            break;
        case 1:
            
            [self.datas removeAllObjects];
            setFlag = @"2";
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
    NSString *getSchoolID = nil;
    NSString *getClassID = nil;
    NSString *getGradeID = nil;
    NSString *getKeywords = @"-1";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        getSchoolID = [defaults objectForKey:@"cloudin_365paxy_schoolid"];
        getClassID = [defaults objectForKey:@"cloudin_365paxy_classid"];
        getGradeID = [defaults objectForKey:@"cloudin_365paxy_gradeid"];
    }

    
    //1=家庭作业，2=成绩分析，3=在校表现，4=网上家访，5=请假条
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"20",@"PageSize",@"1",@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    NSString *getCurrentUrl=[NSString stringWithFormat:@"%@?uid=%@&keywords=%@&sid=%@&cid=%@&gid=%@&flag=%@",ContactsListUrl,getUserID,getKeywords,getSchoolID,getClassID,getGradeID,setFlag];
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
    NSString *getKeywords = @"-1";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
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
    
    
    NSString *pageUrl = [NSString stringWithFormat:@"%@?PageSize=20&Page=%d&uid=%@&keywords=%@&sid=%@&cid=%@&gid=%@&flag=%@",ContactsListUrl,currentPage,getUserID,getKeywords,getSchoolID,getClassID,getGradeID,setFlag];
    pageUrl = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)pageUrl,
                                                                  NULL,
                                                                  NULL,
                                                                  kCFStringEncodingUTF8);
    [[NetManager sharedManager] requestWithURL:pageUrl delegate:self withUserInfo:userInfo];
}

#pragma -
#pragma NetManagerDelegate

-(void) netFinish:(NSDictionary *)jsonString withUserInfo:(NSDictionary *)userInfo
{
    NSMutableArray *temparray = nil;
    if (jsonString)
    {
        temparray = [ParseJson getContactsList:jsonString];
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
