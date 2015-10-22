//
//  BindCell.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/30.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCell.h"

@interface BindCell : BaseCustomCell
{
    UILabel *lblTeacherType;
    UILabel *lblCourseName;
    UILabel *lblIsDefault;
}

@property (nonatomic,retain) IBOutlet UILabel *lblTeacherType;
@property (nonatomic,retain) IBOutlet UILabel *lblCourseName;
@property (nonatomic,retain) IBOutlet UILabel *lblIsDefault;

@end