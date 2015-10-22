//
//  LoadMoreCell.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "LoadMoreCell.h"

#import "Common.h"
#import "InternationalControl.h"

@implementation LoadMoreCell
@synthesize ac;
@synthesize button;
@synthesize pageBgImage;
@synthesize lblBGColor;

-(void) layoutSubviews
{
    //lblBGColor.backgroundColor = MainBgColor;
    [super layoutSubviews];
    
    //显示菜单文字
    NSString *langMoreTxt = @"显示下20条";
    [button setTitle:langMoreTxt forState:UIControlStateNormal];
    

}

-(void) dealloc
{
    self.ac = nil;
    self.button = nil;
    self.pageBgImage = nil;
    [super dealloc];
}

@end
