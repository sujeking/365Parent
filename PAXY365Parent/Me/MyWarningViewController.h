//
//  MyWarningViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "LoadMoreCell.h"

@interface MyWarningViewController : BaseTableViewController <UITableViewDataSource,UITableViewDelegate>
{
    LoadMoreCell *loadMoreCell;
    NSString *setTitle;
    
    UISegmentedControl *segmentMenus;
    
}

@property (nonatomic,retain) LoadMoreCell *loadMoreCell;
@property (nonatomic,retain) NSString *setTitle;

@end
