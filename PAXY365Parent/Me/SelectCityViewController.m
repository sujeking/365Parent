//
//  SelectCityViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-02-10
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "SelectCityViewController.h"

#import "CityCell.h"
#import "CityEntity.h"
#import "Common.h"
#import "Config.h"
#import "ParseJson.h"
#import "InternationalControl.h"

@interface SelectCityViewController ()

@end

@implementation SelectCityViewController
@synthesize loadMoreCell;
@synthesize setFlag;
@synthesize setTitle;
@synthesize setKeyword;
@synthesize setParentID;


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[CityEntity class]])
    {
        CityEntity *data = (CityEntity *)object;
        NSString *getAreaName = data.cityName;
        NSString *getAreaID = data.cityId;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ([setFlag isEqualToString:@"0"]) {
            [defaults setObject:getAreaName forKey:@"cloudin_365paxy_select_area"];
            [defaults setObject:getAreaID forKey:@"cloudin_365paxy_select_areaid"];
            [defaults setObject:@"全部" forKey:@"cloudin_365paxy_select_district"];
            [defaults setObject:@"-1" forKey:@"cloudin_365paxy_select_districtid"];
        }
        else{
            [defaults setObject:getAreaName forKey:@"cloudin_365paxy_select_district"];
            [defaults setObject:getAreaID forKey:@"cloudin_365paxy_select_districtid"];
        }
        
        [self closeView];
        
    }
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.datas objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[CityEntity class]])
    {
        return 50;
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
    if ([object isKindOfClass:[CityEntity class]])
    {
        static NSString *identifier = @"CELL0";
        
        CityCell *cell  = (CityCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CityCell" owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        
        CityEntity *news = (CityEntity *)object;
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
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = setTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.placeholder = @"搜索城市";
    [searchBar sizeToFit];
    searchBar.backgroundImage = [UIImage imageNamed:@"search_bg.png"];
    searchBar.delegate = self;
    //self.tableView.tableHeaderView = searchBar;

    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    getKeywords = @"0";
}

//关闭页面
- (void)closeView
{
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController popViewControllerAnimated:YES]; //back
}


-(void) sendGetDatas
{
    [super sendGetDatas];


    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"20",@"PageSize",@"1",@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];
    NSString *getCurrentUrl=[NSString stringWithFormat:@"%@?flag=%@&pid=%@&keywords=%@",AreaListUrl,setFlag,setParentID,setKeyword];
    getCurrentUrl = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)getCurrentUrl,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
    NSLog(@"%@",getCurrentUrl);
    [[NetManager sharedManager] requestWithURL:getCurrentUrl delegate:self withUserInfo:userInfo];
}

-(void) loadmore:(UIButton *) sender
{
    self.loadMoreCell.ac.hidden = NO;
    [self.loadMoreCell.ac startAnimating];
    
    self.loadMoreCell.button.hidden = YES;
    self.loadingmore = YES;
    
    currentPage = currentPage + 1;
    
    NSString *pageString = [NSString stringWithFormat:@"%d",currentPage];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:pageString,@"Page", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:dic,REQUET_PARAMS, nil];

    NSString *getSelectAreaID = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getSelectAreaID = [defaults objectForKey:@"cloudin_365paxy_select_areaid"];
    }
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *getWords = DefaultNoData;
    [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];//点击更多时弹出文字对话框提醒，不是图片
    [defaults setObject:getWords forKey:@"cloudin_365paxy_nodata_show_word"];
    
    NSString *pageUrl = [NSString stringWithFormat:@"%@?PageSize=20&Page=%d&flag=%@&pid=%@&keywords=%@",AreaListUrl,currentPage,setFlag,setParentID,setKeyword];
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
        temparray = [ParseJson getCityList:jsonString];
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

#pragma mark - Searching

- (void)updateSearchString:(NSString*)searchString
{
    //[searchString release];
    searchString = [[NSString alloc]initWithString:searchString];
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject:searchString forKey:@"cloudin_365paxy_keywords"];
    getKeywords = searchString;
    [self sendGetDatas];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    searchBar.text= @"";
    [self updateSearchString:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    [self updateSearchString:searchBar.text];
    [searchBar resignFirstResponder];   //隐藏输入键盘
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
