//
//  ComposePhotosView.m
//
//  Created by lan on 15/9/4.
//  Copyright (c) 2015年 lanyutao. All rights reserved.
//

#import "ComposePhotosView.h"

@implementation ComposePhotosView

- (void)addPhoto:(UIImage *)photo{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = photo;
    // 储存图片
  //  [self.photos addObject:photo];
    
    [self addSubview:imageView];
  
}

- (void)removeAllPhoto {
    for (int i=0; i < self.subviews.count; i++) {
        [self.subviews[i] removeFromSuperview];
    }
}

-  (NSMutableArray *)photos{
    if ( _photos == nil) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        _photos = [NSMutableArray array];
//    }
//    return self;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    if (count >= 5) {
        count = 5;
    }
    
    int maxCol = 4;
    CGFloat imageMargin = 10;
    CGFloat imageWH = (self.bounds.size.width - (maxCol - 1) * imageMargin) / maxCol;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < count; i ++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        x = col * (imageWH + imageMargin);
        int row = i / maxCol;
        y = row * (imageWH + imageMargin);
        
        photoView.frame = CGRectMake(x, y, imageWH, imageWH);
    }
}
@end
