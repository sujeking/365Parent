//
//  HXMainViewController.h
//  ChatDemo-UI2.0
//
//  Created by Knight Lee on 15/7/23.
//  Copyright (c) 2015年 Adin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXMainViewController : UITabBarController
{
    EMConnectionState _connectionState;
}

- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

@end
