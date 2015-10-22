//
//  NoticeClassDetailsViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/25.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "LoadMoreCell.h"
#import "GPRoundView.h"

@interface NoticeClassDetailsViewController : BaseTableViewController <UITableViewDataSource,UITableViewDelegate>
{
    LoadMoreCell *loadMoreCell;
    
    NSString *setCommentID;
    NSString *setFlag;//=0根据商家显示评论，=1根据用户显示评论
    NSString *setTitle;
    NSString *setDate;
    NSString *setName;
    NSString *setDesc;
    NSString *setImage;
    
    UIActivityIndicatorView *activityIndicator;
    
    int flag;
    //加载进度条
    GPRoundView *loadingView;
}

@property (nonatomic,retain) LoadMoreCell *loadMoreCell;

@property (nonatomic,retain) NSString *setCommentID;
@property (nonatomic,retain) NSString *setFlag;
@property (nonatomic,retain) NSString *setTitle;
@property (nonatomic,retain) NSString *setDate;
@property (nonatomic,retain) NSString *setName;
@property (nonatomic,retain) NSString *setDesc;
@property (nonatomic,retain) NSString *setImage;

@end
