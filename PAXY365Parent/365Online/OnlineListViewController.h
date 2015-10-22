//
//  OnlineListViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"
#import "BaseTableViewController.h"
#import "LoadMoreCell.h"

@interface OnlineListViewController : BaseTableViewController <UITableViewDataSource,UITableViewDelegate,ImagePlayerViewDelegate>
{
    LoadMoreCell *loadMoreCell;
    NSString *setTitle;
    
    UISegmentedControl *segmentMenus;
    
    ImagePlayerView *imagePlayerView;
    NSMutableArray *imageURLs;
    NSMutableArray *openURLs;
}

@property (nonatomic,retain) LoadMoreCell *loadMoreCell;
@property (nonatomic,retain) NSString *setTitle;

@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;
@property (nonatomic, strong) NSMutableArray *imageURLs;
@property (nonatomic, strong) NSMutableArray *openURLs;

@end
