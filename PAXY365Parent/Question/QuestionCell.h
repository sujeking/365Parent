//
//  QuestionCell.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCell.h"

@interface QuestionCell : BaseCustomCell
{
    UILabel *lblTitle;
    UIButton *btnStatus;
    UILabel *lblAddDate;
}

@property (nonatomic,retain) IBOutlet UILabel *lblTitle;
@property (nonatomic,retain) IBOutlet UIButton *btnStatus;
@property (nonatomic,retain) IBOutlet UILabel *lblAddDate;


@end