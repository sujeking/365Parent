//
//  SelectCityViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-02-10
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "LoadMoreCell.h"

@interface SelectCityViewController : BaseTableViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    LoadMoreCell *loadMoreCell;
    
    NSString *getKeywords;
    
    NSString *setFlag;
    NSString *setTitle;
    NSString *setParentID;
    NSString *setKeyword;
}

@property (nonatomic,retain) LoadMoreCell *loadMoreCell;

@property (nonatomic,retain) NSString *setFlag;
@property (nonatomic,retain) NSString *setTitle;
@property (nonatomic,retain) NSString *setParentID;
@property (nonatomic,retain) NSString *setKeyword;

@end
