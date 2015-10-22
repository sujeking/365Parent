//
//  LocalAlbumCell.h
//  AlbumTest
//
//  Created by ejiang on 14-7-28.
//  Copyright (c) 2014年 daijier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalAlbumCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imgCover;
@property (retain, nonatomic) IBOutlet UILabel *lbName;
@property (retain, nonatomic) IBOutlet UILabel *lbCount;

@end
