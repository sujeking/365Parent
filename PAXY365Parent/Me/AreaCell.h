//
//  AreaCell.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCell.h"

@interface AreaCell : BaseCustomCell
{
    UILabel *lblName;
    
}

@property (nonatomic,retain) IBOutlet UILabel *lblName;

@end