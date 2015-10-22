//
//  TZoneView.h
//  TMarket
//
//  Created by ZhangAo on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TZoneViewDelegate <NSObject>
-(NSInteger)zoneViewNumberOfTexts;
-(NSString *)zoneViewTextForIndex:(int)index;
-(void)zoneViewSelectedFor:(int)index;
@end

////////////////////////////////////////////////////////////

@interface TZoneView : UIView
{
    id<TZoneViewDelegate>   delegate;
    int scrollYConstraint;
    int scrollLastUsed;
    
    int count;
    
    NSMutableArray *tagsArray;
    NSArray *colorList;
}
@property (nonatomic, assign) id<TZoneViewDelegate>   delegate;

-(void) reloadZoneView;

@end
