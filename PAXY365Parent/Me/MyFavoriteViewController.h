//
//  MyFavoriteViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "LoadMoreCell.h"

@interface MyFavoriteViewController : BaseTableViewController <UITableViewDataSource,UITableViewDelegate>
{
    LoadMoreCell *loadMoreCell;
    NSString *setTitle;
    NSString *setFlag;
}

@property (nonatomic,retain) LoadMoreCell *loadMoreCell;
@property (nonatomic,retain) NSString *setTitle;
@property (nonatomic,retain) NSString *setFlag;

@end
