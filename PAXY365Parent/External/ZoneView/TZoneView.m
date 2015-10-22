//
//  TZoneView.m
//  TMarket
//
//  Created by ZhangAo on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TZoneView.h"
#import "Utils.h"

@interface TZoneView ()
-(void)showTags;
-(BOOL)rectIntersects:(CGRect)theRect;
-(void)tagPressed:(id)sender;
-(UIButton *)addTagWithTitle:(NSString *)title andFontSize:(float)fontSize WithX:(float)x AndY:(float)y AndTag:(NSInteger)tag;
@end

@implementation TZoneView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        tagsArray = [[NSMutableArray alloc] init];
        colorList = [[NSArray alloc]initWithObjects:
                              [Utils colorWithHexString:@"#9b734a"], 
                              [Utils colorWithHexString:@"#f64833"],
                              [Utils colorWithHexString:@"#33af47"],
                              [Utils colorWithHexString:@"#9fd753"],
                              [Utils colorWithHexString:@"#f56958"],
                              [Utils colorWithHexString:@"#4cc5f3"],
                              [Utils colorWithHexString:@"#d1616c"],
                              [Utils colorWithHexString:@"#e3a21a"],
                              [Utils colorWithHexString:@"#f45aa6"],
                              [Utils colorWithHexString:@"#985ec5"],
                              [Utils colorWithHexString:@"#c78ff1"],
                              [Utils colorWithHexString:@"#4a8aff"],
                              [Utils colorWithHexString:@"#74b37e"],
                     nil];
    }
    return self;
}

-(void) reloadZoneView
{
    for (UIView *tempView in self.subviews)
    {
        [tempView removeFromSuperview];
    }
    [NSThread detachNewThreadSelector:@selector(showTags)
                             toTarget:self
                           withObject:nil];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [NSThread detachNewThreadSelector:@selector(showTags)
                             toTarget:self
                           withObject:nil];
}

-(void)showTags
{
    @autoreleasepool 
    {
        scrollYConstraint = CGRectGetHeight(self.bounds);
        scrollLastUsed = 0;
        
        int tag = 1;
        //max width to go down with the button (portrait iphone screen)
        int xConstraint = CGRectGetWidth(self.bounds) - 20;
        int yConstraint = 0;
        
        count = [delegate zoneViewNumberOfTexts];
        
        NSMutableArray *centerArray = [[NSMutableArray alloc] initWithCapacity:count];
        NSString *theTitle = nil;
        
        for(int i = 0; i < count; i++) 
        {
            theTitle = [delegate zoneViewTextForIndex:i];
            if (tag > scrollLastUsed) 
            {
                float x = arc4random() % 250, y = arc4random() % ((int)self.frame.size.height - 100);
                
                //between xx and xx
                float fontSize = (arc4random() % 10) + 14;
                
                CGSize theSize = [theTitle sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:CGSizeMake(9999.0f, 9999.0f) lineBreakMode:UILineBreakModeWordWrap];
                
                while (theSize.width > xConstraint) 
                {
                    fontSize -= 1;
                    theSize = [theTitle sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:CGSizeMake(9999.0f, 9999.0f) lineBreakMode:UILineBreakModeWordWrap];
                }
                
                CGRect compareRect = CGRectMake(x, y, theSize.width + 10, theSize.height);
                while ([self rectIntersects:compareRect]) 
                {
                    if((theSize.width + x +5) < xConstraint) x += 15;
                    else 
                    {
                        x = 10;
                        y += 12;
                    }
                    compareRect = CGRectMake(x, y, theSize.width, theSize.height);
                }
                
                UIButton *button = [self addTagWithTitle:theTitle andFontSize:fontSize WithX:x AndY:y AndTag:tag];
                [self addSubview:button];
                
                //get the button height and add it to the constraint
                int btnHeight = (int)[self viewWithTag:tag].frame.size.height;
                if ((y + btnHeight) > yConstraint)
                {
                    yConstraint = (y + btnHeight);		
                }
            }		
            tag++;		
        }
        
        //remember the last used tag
        scrollLastUsed = tag;
    }
}

- (void)dealloc {
    [tagsArray release];
    [colorList release];
    
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////

-(UIButton *)addTagWithTitle:(NSString *)title andFontSize:(float)fontSize WithX:(float)x AndY:(float)y AndTag:(NSInteger)tag {
	
	UIButton *theBtn = [UIButton buttonWithType:UIButtonTypeCustom];

	CGSize titleSize = [title sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] 
                       constrainedToSize:CGSizeMake(9999.0f, 9999.0f) 
                           lineBreakMode:UILineBreakModeWordWrap];
    
	theBtn.frame = CGRectMake(x, y, titleSize.width, titleSize.height);

	[tagsArray addObject:theBtn];
	
	[theBtn setTitle:title forState:UIControlStateNormal];
	
    int colorIndex = (arc4random() % colorList.count);
    //SEL colorSelector = NSSelectorFromString([colorList objectAtIndex:colorIndex]);
	UIColor *titleColor = [colorList objectAtIndex:colorIndex];
	
	[theBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [theBtn setBackgroundColor:[UIColor clearColor]];
	theBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
	theBtn.tag = tag;
    
	
	[theBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
	CGRect frame = theBtn.frame;
	frame.size.width += 10; //l + r padding 
	theBtn.frame = frame;
	
	// add action
	[theBtn addTarget:self action:@selector(tagPressed:) forControlEvents:UIControlEventTouchUpInside];
	
	return theBtn;
}

-(BOOL)rectIntersects:(CGRect)theRect {
	int t = 0;
	for (UIButton *btn in tagsArray) {					
		t++;
		if (t >= (scrollLastUsed - 10)) {
			CGRect testRect = CGRectIntersection(btn.frame, theRect);
			if (!CGRectIsNull(testRect)) return TRUE;
		}
	}
	return FALSE;
}

-(void)tagPressed:(id)sender{
    [delegate zoneViewSelectedFor:((UIView *)sender).tag - 1];
}

@end
