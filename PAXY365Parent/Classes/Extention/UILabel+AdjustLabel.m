//
//  UILabel+AdjustLabel.m
//  豆米街
//
//  Created by space bj on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UILabel+AdjustLabel.h"

@implementation UILabel (Adjust)

-(void) adjustToWidth
{
    self.numberOfLines = NSIntegerMax;
    self.lineBreakMode = UILineBreakModeWordWrap;
    
    CGRect frame = self.frame;
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(NSIntegerMax, frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
    frame.size.width = size.width;
    self.frame = frame;
}

-(void) adjustToHeight
{
    self.numberOfLines = NSIntegerMax;
    self.lineBreakMode = UILineBreakModeWordWrap;
    
    CGRect frame = self.frame;
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(frame.size.width, NSIntegerMax) lineBreakMode:UILineBreakModeWordWrap];
    frame.size.height = size.height;
    self.frame = frame;
}

@end
