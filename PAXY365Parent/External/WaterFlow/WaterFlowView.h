//
//  WaterFlowView.h
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

#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"

#define LOADINGVIEW_HEIGHT 44
#define REFRESHINGVIEW_HEIGHT 88
#define NUMBER_OF_REUSECELL 20 //重用Cell数

@protocol WaterFlowViewDelegate;

@class WaterFlowCell;

@interface WaterFlowView : UIScrollView <UIScrollViewDelegate,
                                        EGORefreshTableHeaderDelegate>
{

}

@property (nonatomic, assign) id <WaterFlowViewDelegate> flowdelegate;

- (void)reloadData;
- (WaterFlowCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier; //获取重用的cell
- (void)addCellToReuseQueue:(WaterFlowCell *)cell; //将要移除屏幕的cell添加到可重用列表中

@end

//---------------------------------------------------------------------------------------------------------------------
//
//
//WaterFlowViewDelegate
//
//---------------------------------------------------------------------------------------------------------------------

@protocol WaterFlowViewDelegate <NSObject>

@required
- (NSUInteger)numberOfColumnsInFlowView:(WaterFlowView *)flowView;

- (NSInteger)flowView:(WaterFlowView *)flowView 
 numberOfRowsInColumn:(NSInteger)column;

- (WaterFlowCell *)flowView:(WaterFlowView *)flowView 
        cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)flowView:(WaterFlowView *)flowView 
  heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)refreshHeaderViewData;
- (void)loadFooterViewData;

@optional
- (void)flowView:(WaterFlowView *)flowView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

//-------------------------------------------------------------------------------------------------------------------------------
//
//
//WaterFlowCell
//
//-------------------------------------------------------------------------------------------------------------------------------

@interface WaterFlowCell: UIView
{
    
}

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) NSString *strReuseIndentifier;

- (id)initWithIdentifier:(NSString *)indentifier;

@end
