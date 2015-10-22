//
//  BaseCustomCell.h
//  FinalFantasy
//
//  Created by space bj on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImageManager.h>

@interface BaseCustomCell : UITableViewCell <SDWebImageManagerDelegate>
{
    NSString *headURLString;
    UIImageView *headImageView;
    UIButton *headButton;//头像
    UILabel *userLabel;//用户名称
    UILabel *dateLabel;//时间
    
    id object;
}

@property (nonatomic,retain) NSString *headURLString;
@property (nonatomic,retain) IBOutlet UIImageView *headImageView;
@property (nonatomic,retain) IBOutlet UIButton *headButton;
@property (nonatomic,retain) IBOutlet UILabel *userLabel;
@property (nonatomic,retain) IBOutlet UILabel *dateLabel;

@property (nonatomic, retain) id object;


-(void) reloadImageWithImageUrl:(NSString *) imageURLString withDelegate:(id<SDWebImageManagerDelegate>) delegate;
-(void) imageLoadedFromLocal:(UIImage *) image imageURLString:(NSString *) imageURLString;
-(void) imageLoadedFromRemote:(UIImage *) image imageURLString:(NSString *) imageURLString;

+ (CGFloat)heightWithObject:(id) object;

@end
