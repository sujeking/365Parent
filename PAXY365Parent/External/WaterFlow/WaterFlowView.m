//
//  WaterFlowView.m
//  Tristen 陈涛
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


#import "WaterFlowView.h"

@interface WaterFlowView ()

- (void)initialize;
- (void)refreshView;
- (void)cellSelected:(NSNotification*)notification;

@property (nonatomic, retain) NSMutableArray *arrCellHeight; //cell 高度
@property (nonatomic, retain) NSMutableArray *arrVisibleCells; // 当前可见的cell
@property (nonatomic, retain) NSMutableDictionary *dicReuseCells; //重用的cell
@property (nonatomic, retain) LoadMoreTableFooterView *loadFooterView;
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, assign) BOOL isLoadingmore;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) NSInteger columnNumber;

@end

@implementation WaterFlowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
		self.delegate = self;
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.loadFooterView = [[[LoadMoreTableFooterView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, LOADINGVIEW_HEIGHT)] autorelease];
        self.isLoadingmore = NO;
        [self addSubview:self.loadFooterView];
        
        self.refreshHeaderView = [[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,  -REFRESHINGVIEW_HEIGHT, self.frame.size.width, REFRESHINGVIEW_HEIGHT)] autorelease];
        self.refreshHeaderView.delegate = self;
        self.isRefreshing = NO;
        [self addSubview:self.refreshHeaderView];
        
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height + LOADINGVIEW_HEIGHT);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cellSelected:)
                                                     name:@"CellSelected"
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"CellSelected"
                                                  object:nil];
    
    self.flowdelegate = nil;
    self.delegate = nil;
    
    self.arrCellHeight = nil;
    self.arrVisibleCells = nil;
    self.dicReuseCells = nil;
    self.loadFooterView = nil;
    self.refreshHeaderView = nil;
    self.isLoadingmore = NO;;
    self.isRefreshing = NO;
    self.columnNumber = 0;
    [super dealloc];
}

//可重用列表中获取Cell
- (WaterFlowCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
	if (identifier == nil || identifier.length == 0)
    {
		return nil;
	}
	
	NSMutableArray *arrIndentifier = [self.dicReuseCells objectForKey:identifier];
	if (arrIndentifier && [arrIndentifier isKindOfClass:[NSArray class]] && arrIndentifier.count > 0)
    {
		WaterFlowCell *cell = [arrIndentifier lastObject];
		[cell retain];
		[arrIndentifier removeLastObject];
		return [cell autorelease];
	}
    
	return nil;
}

//将要移除屏幕的cell添加到可重用列表中
- (void)addCellToReuseQueue:(WaterFlowCell *)cell
{
	if (cell.strReuseIndentifier.length == 0)
    {
        return;
    }
	
	if (self.dicReuseCells == nil)
    {
		self.dicReuseCells = [NSMutableDictionary dictionaryWithCapacity:NUMBER_OF_REUSECELL];
		
		NSMutableArray *array= [NSMutableArray arrayWithObject:cell];
		[self.dicReuseCells setObject:array forKey:cell.strReuseIndentifier];
	}
    else
    {
        NSMutableArray *array = [self.dicReuseCells objectForKey:cell.strReuseIndentifier];
		if (array == nil)
        {
			array = [NSMutableArray arrayWithObject:cell];
			[self.dicReuseCells setObject:array forKey:cell.strReuseIndentifier];
		}
        else
        {
			[array addObject:cell];
		}
	}
}

- (void)reloadData
{
	//重新加载时，将当前所有的cell移除， 拿来重用
	for (int i = 0; i < self.columnNumber; i++)
    {
		NSMutableArray *arrayEachCell = [self.arrVisibleCells objectAtIndex:i];
		for (int j = 0; j < [arrayEachCell count]; j++)
        {
			WaterFlowCell *cell = [arrayEachCell objectAtIndex:j];
			[self addCellToReuseQueue:cell];
			[cell removeFromSuperview];
		}
	}
    
    if (self.isRefreshing)
    {
        self.isRefreshing = NO;
        [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        
    }
    
    if (self.isLoadingmore)
    {
        self.isLoadingmore = NO;
        //self.loadFooterView.showActivityIndicator = NO;
    }
    
	[self initialize];
}

- (void)initialize
{
	//获取列数
	self.columnNumber = [self.flowdelegate numberOfColumnsInFlowView:self];
	self.dicReuseCells = [NSMutableDictionary dictionaryWithCapacity:NUMBER_OF_REUSECELL];
	
	//每个成员保存一列的所有子View的高
	self.arrCellHeight = [NSMutableArray arrayWithCapacity:self.columnNumber];
    self.arrVisibleCells = [NSMutableArray arrayWithCapacity:self.columnNumber];
    
    //整个scrollview的高度
	float maxHeight = 0;
	
	//保存所有cell下子View的高度
	for (int i = 0; i < self.columnNumber; i++)
    {
	    NSMutableArray *arrEachcell = [NSMutableArray arrayWithCapacity:0];
		[self.arrVisibleCells addObject:arrEachcell];
		
		int numberOfRowsInColumn = [self.flowdelegate flowView:self numberOfRowsInColumn:i];
        
        if (numberOfRowsInColumn == 0) {
            continue;
        }
		
		NSMutableArray *arrEachColumns = [NSMutableArray arrayWithCapacity:numberOfRowsInColumn];
		[self.arrCellHeight addObject:arrEachColumns];
		
		float totalHeight = 0;
		for (int j = 0; j < numberOfRowsInColumn; j++)
        {
            
            NSIndexPath *index = [[NSIndexPath indexPathForRow:j inSection:i] retain];
			float height = [self.flowdelegate flowView:self heightForRowAtIndexPath:index];
            [index release];
            
			totalHeight += height;
            //通过累加的方式保存此列每一行子View的Y坐标
			[arrEachColumns addObject:[NSNumber numberWithFloat:totalHeight]];
		}
        maxHeight = MAX(maxHeight, totalHeight);
	}

    
    if (maxHeight > self.frame.size.height)
    {
        self.loadFooterView.frame = CGRectMake(0, maxHeight, self.frame.size.width, LOADINGVIEW_HEIGHT);
        //取最大的高度作为scrollview的contensize的height；
        self.contentSize = CGSizeMake(self.frame.size.width, maxHeight + LOADINGVIEW_HEIGHT);
    }

	[self refreshView];
}

- (void)refreshView
{
	CGPoint offset = self.contentOffset;
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
	
	//判断每一列的 需要添加和移除的cell
	for (int i = 0; i < self.columnNumber; i++)
    {
		float origionX = i * (screenWidth / self.columnNumber);
		float eachWidth = screenWidth / self.columnNumber;
        
        if ([self.arrCellHeight count] <= i) {
            continue;
        }
		
		NSArray *arrEachHeight = [self.arrCellHeight objectAtIndex:i];
        
		NSMutableArray *arrEachCell = [self.arrVisibleCells objectAtIndex:i];
		
		//当前列的当前显示在页面上的第一个cell
		WaterFlowCell *cell = nil;
		if (arrEachCell == nil || [arrEachCell count] == 0)
        {
			int row = 0;
			//确定当前需要加载的第一行 是哪一行
			for (int j = 0; j < [arrEachHeight count] - 1; j++)
            {
				float eachHeight = [[arrEachHeight objectAtIndex:j] floatValue];
				if (eachHeight < offset.y) {
					row++;
				}
			}
        
			float origionY = 0;
			float height = 0;
			if (row == 0)
            {
				origionY = 0;
				height = [[arrEachHeight objectAtIndex:row] floatValue];
                
			}else if (row < [arrEachHeight count])
            {
				origionY = [[arrEachHeight objectAtIndex:row - 1] floatValue];
				height = [[arrEachHeight objectAtIndex:row ] floatValue] - origionY;
			}
			
			cell = [self.flowdelegate flowView:self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:i]];
			cell.indexPath = [NSIndexPath indexPathForRow:row inSection:i];
			cell.frame = CGRectMake(origionX, origionY, eachWidth, height);
			[self addSubview:cell];
			[arrEachCell insertObject:cell atIndex:0];
		}
        else
        {
			cell = [arrEachCell objectAtIndex:0];
		}

		//加载上面的 
		while (cell && ((cell.frame.origin.y - offset.y) > 0.0001))
        {
			int row = cell.indexPath.row;
			float origionY = 0;
			float height = 0;
			
			if (row == 0)
            {
				cell = nil;
				continue;
			}
			
			//当前是第一行， 需要加载第0行
			else if (row == 1)
            {
				origionY = 0;
				height = [[arrEachHeight objectAtIndex:row - 1] floatValue];
			}else if (row < [arrEachHeight count]) {
				origionY = [[arrEachHeight objectAtIndex:row - 2] floatValue];
				height = [[arrEachHeight objectAtIndex:row - 1] floatValue] - origionY;
			}
            
			cell = [self.flowdelegate flowView:self cellForRowAtIndexPath:[NSIndexPath indexPathForRow: row> 0 ? (row - 1) : 0 inSection:i]];
			cell.indexPath = [NSIndexPath indexPathForRow:row > 0 ? (row - 1) : 0 inSection:i];
			cell.frame = CGRectMake(origionX, origionY, eachWidth, height);
			
			[arrEachCell insertObject:cell atIndex:0];
			[self addSubview:cell];
			
			if (row == 0)
            {
                break;
            }
		}
		
		//去掉上面的
		while (cell && ((cell.frame.origin.y + cell.frame.size.height - offset.y) < 0.0001))
        {
			[cell removeFromSuperview];
			[self addCellToReuseQueue:cell];
			[arrEachCell removeObject:cell];
			
			if (arrEachCell.count > 0)
            {
				cell = [arrEachCell objectAtIndex:0];
			}
			else
            {
				cell = nil;
			}
		}
        
		//==================================================================================
		//加载下面的
		cell = [arrEachCell lastObject];
		while (cell && ((cell.frame.origin.y + cell.frame.size.height - self.frame.size.height - offset.y) < 0.0001))
        {
			int row = cell.indexPath.row;
            
			float origionY = 0;
			float height = 0;
			
			if (row == [arrEachHeight count] - 1)
            {
				cell = nil;
				break;;
			}
            else
            {
				origionY = [[arrEachHeight objectAtIndex:row ] floatValue];
				height = [[arrEachHeight objectAtIndex:row + 1] floatValue] - origionY;
			}
			
			cell = [self.flowdelegate flowView:self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row + 1 inSection:i]];
			cell.indexPath = [NSIndexPath indexPathForRow:row + 1 inSection:i];
			cell.frame = CGRectMake(origionX, origionY, eachWidth, height);
			[arrEachCell addObject:cell];
			
			[self addSubview:cell];
		}
		
		//去掉下面的
		while (cell && ((cell.frame.origin.y - self.frame.size.height - offset.y) > 0.0001))
        {
			[cell removeFromSuperview];
			[self addCellToReuseQueue:cell];
			[arrEachCell removeObject:cell];
			
			if (arrEachCell.count > 0)
            {
				cell = [arrEachCell lastObject];
			}
			else
            {
				cell = nil;
			}
		}
	}
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
	[self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self refreshView];
	
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >=  floor(scrollView.contentSize.height))
    {
        if (self.isLoadingmore)
        {
            return;
        } 
        self.isLoadingmore = YES;
        //self.loadFooterView.showActivityIndicator = YES;
    
        [self.flowdelegate loadFooterViewData];
    }
    
    [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    self.isRefreshing = YES;
    [self.flowdelegate refreshHeaderViewData];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return self.isRefreshing; 
}

#pragma mark- process notification

- (void)cellSelected:(NSNotification *)notification
{
  if ([self.flowdelegate respondsToSelector:@selector(flowView:didSelectRowAtIndexPath:)])
  {
      [self.flowdelegate flowView:self didSelectRowAtIndexPath:((WaterFlowCell*)notification.object).indexPath];
  }

}

@end

//-------------------------------------------------------------------------------------------------------------------------------
//
//
//WaterFlowCell
//
//-------------------------------------------------------------------------------------------------------------------------------

@implementation WaterFlowCell

@synthesize indexPath;
@synthesize strReuseIndentifier;

- (id)initWithIdentifier:(NSString *)indentifier
{
	if (self = [super init])
    {
		self.strReuseIndentifier = indentifier;
	}
    
	return self;
}

- (void)dealloc
{
    self.indexPath = nil;
    self.strReuseIndentifier = nil;
	[super dealloc];
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CellSelected"
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self,@"cell",self.indexPath,@"indexPath",nil]];
    
}

@end
