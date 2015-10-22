//
//  CityListViewController.h
//  KaKa
//
//  Created by Cloudin's Adin on 14-2-23.
//  Copyright (c) 2014年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "LoadMoreCell.h"

@interface CityListViewController : BaseTableViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    LoadMoreCell *loadMoreCell;

    NSString *setCommentID;
    NSString *setUserName;
    NSString *setTitle;
}

@property (nonatomic,retain) LoadMoreCell *loadMoreCell;

@property (nonatomic,retain) NSString *setCommentID;
@property (nonatomic,retain) NSString *setUserName;
@property (nonatomic,retain) NSString *setTitle;

@end
