//
//  LoadMoreCell.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseCustomCell.h"

@interface LoadMoreCell : BaseCustomCell
{
    UILabel *lblBGColor;
    UIActivityIndicatorView *ac;
    UIButton *button;
    UIImageView *pageBgImage;
}

@property (nonatomic,retain) IBOutlet UILabel *lblBGColor;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *ac;
@property (nonatomic,retain) IBOutlet UIButton *button;
@property (nonatomic,retain) IBOutlet UIImageView *pageBgImage;

@end
