//
//  ContactsListViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "LoadMoreCell.h"

@interface ContactsListViewController : BaseTableViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    LoadMoreCell *loadMoreCell;
    
    NSString *setFlag;// flag=1家长，=2教师，3=所有
    NSString *setKeywords;
    NSString *setTitle;
    
}

@property (nonatomic,retain) LoadMoreCell *loadMoreCell;

@property (nonatomic,retain) NSString *setFlag;
@property (nonatomic,retain) NSString *setKeywords;
@property (nonatomic,retain) NSString *setTitle;

@end