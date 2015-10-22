//
//  AreaListViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "LoadMoreCell.h"

@interface AreaListViewController : BaseTableViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    LoadMoreCell *loadMoreCell;
    
    NSString *setParentID;
    NSString *setFlag;
    NSString *setKeywords;
    NSString *setTitle;
    NSString *setKeywordsHint;
    
}

@property (nonatomic,retain) LoadMoreCell *loadMoreCell;

@property (nonatomic,retain) NSString *setParentID;
@property (nonatomic,retain) NSString *setFlag;
@property (nonatomic,retain) NSString *setKeywords;
@property (nonatomic,retain) NSString *setTitle;
@property (nonatomic,retain) NSString *setKeywordsHint;

@end
