//
//  BindSelectViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/31.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "LoadMoreCell.h"
#import "BindEntity.h"

@interface BindSelectViewController : BaseTableViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    LoadMoreCell *loadMoreCell;
    BindEntity *bindEntity;
    int flag;
    
    NSString *setTitle;
}

@property (nonatomic,retain) LoadMoreCell *loadMoreCell;
@property (nonatomic,retain) BindEntity *bindEntity;

@property (nonatomic,retain) NSString *setTitle;

@end