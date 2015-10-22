//
//  FriendsReviewViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/23.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsEntity.h"

@interface FriendsReviewViewController : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    ContactsEntity *contactsEntity;
    
    UIImageView *headImage;
    UILabel *lblName;
    UILabel *lblDate;
    
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) ContactsEntity *contactsEntity;

@property (nonatomic, retain) IBOutlet UIImageView *headImage;
@property (nonatomic, retain) IBOutlet UILabel *lblName;
@property (nonatomic, retain) IBOutlet UILabel *lblDate;


@end
