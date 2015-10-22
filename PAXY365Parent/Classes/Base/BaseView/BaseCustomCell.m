//
//  BaseCustomCell.m
//  FinalFantasy
//
//  Created by space bj on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseCustomCell.h"
#import "Utils.h"
#import "UIViewExtention.h"

@implementation BaseCustomCell

@synthesize headURLString;
@synthesize headButton;
@synthesize userLabel;
@synthesize dateLabel;
@synthesize headImageView;

@synthesize object;


-(void) layoutSubviews
{
    [super layoutSubviews];
    [self.headButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) reloadImageWithImageUrl:(NSString *) imageURLString withDelegate:(id<SDWebImageManagerDelegate>) delegate
{
    if (imageURLString == nil) 
    {
        return;
    }   
    //self.headURLString = imageURLString;
    //获取图片
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    if (imageURLString != nil && ![@"" isEqualToString:imageURLString] && ![imageURLString isEqual:[NSNull null]]) 
    {
        UIImage *cachedImage = [manager imageWithURL:[NSURL URLWithString:imageURLString]];
        if (cachedImage) 
        {
            [self imageLoadedFromLocal:cachedImage imageURLString:imageURLString];
        }
        else
        {
            [manager downloadWithURL:[NSURL URLWithString:imageURLString] delegate:delegate];
        }
    }
}

-(void) prepareForReuse
{
    self.headImageView.image = nil;
}

#pragma -
#pragma SDWebImageManager

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image forURL:(NSURL *)url
{
    [self imageLoadedFromRemote:image imageURLString:url.absoluteString];
}


-(void) imageLoadedFromLocal:(UIImage *) image imageURLString:(NSString *) imageURLString
{    
    if ([self respondsToSelector:@selector(imageGetted:imageURLString:)]) 
    {
        [self imageGetted:image imageURLString:imageURLString];
    }
}

-(void) imageLoadedFromRemote:(UIImage *) image imageURLString:(NSString *) imageURLString
{
    if ([self respondsToSelector:@selector(imageGetted:imageURLString:)]) 
    {
        [self imageGetted:image imageURLString:imageURLString];
    }
}

-(void) imageGetted:(UIImage *) img imageURLString:(NSString *) imageURLString
{
    CLog(@"重写改方法");
}

-(UIView *) getBackGroundView:(CGFloat) height backgroundColor:(UIColor *) color
{    
    UIView *backgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height)] autorelease];
    
    if (color == nil) 
    {
        backgroundView.backgroundColor = [UIColor redColor];
    }
    else
    {
        backgroundView.backgroundColor = color;
    }
    
    UIView *tempLineView = [[UIView alloc] initWithFrame:CGRectMake(76, 0, 6, height)];
    [backgroundView addSubview:tempLineView];
    
    tempLineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.10f];
    [tempLineView release]; 
    
    return backgroundView;
}

-(UIView *) getBackGroundView:(CGFloat) height
{
    return [self getBackGroundView:height backgroundColor:nil];
}

+ (CGFloat)heightWithObject:(id) object
{
    return 0.0;
}

-(void) dealloc
{
    //CLog(@"内存释放 Class = %@",[[self class] description]);
    [headURLString release];
    [headButton release];
    [userLabel release];
    [dateLabel release];
    [headImageView release];
    [object release];
    
    [super dealloc];
}

@end
