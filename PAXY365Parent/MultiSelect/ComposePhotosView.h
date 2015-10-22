//
//  ComposePhotosView.h
//
//  Created by lan on 15/9/4.
//  Copyright (c) 2015年 lanyutao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposePhotosView : UIView
- (void)addPhoto:(UIImage *)photo;
- (void)removeAllPhoto;

@property (nonatomic, strong) NSMutableArray *photos;

@end
