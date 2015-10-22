//
//  MessageCommentCell.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCell.h"

@interface MessageCommentCell : BaseCustomCell
{
    UILabel *lblContent;
    UILabel *lblAuthor;
    UILabel *lblDate;
}

@property (nonatomic,retain) IBOutlet UILabel *lblContent;
@property (nonatomic,retain) IBOutlet UILabel *lblAuthor;
@property (nonatomic,retain) IBOutlet UILabel *lblDate;

@end