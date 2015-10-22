//
//  WaterFlowViewDataSource.m
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

#import "WaterFlowViewDataSource.h"

@interface WaterFlowViewDataSource ()


@property (nonatomic, retain) NSMutableArray *imageHeights;
@property (nonatomic, retain) NSMutableArray *heightOfColumns;
@property (nonatomic, assign) NSInteger columnNumber;

@end

@implementation WaterFlowViewDataSource

- (id)initWithColumnNumber:(NSInteger)aColumnNumber
{
    self = [super init];
    if (self)
    {
        self.imagePaths = [NSMutableArray arrayWithCapacity:0];
        self.imageHeights = [NSMutableArray arrayWithCapacity:0];
        self.heightOfColumns = [NSMutableArray arrayWithCapacity:0];
        self.columnNumber = aColumnNumber;
        for (int i = 0; i < self.columnNumber; i++)
        {
            [self.imagePaths addObject:[NSMutableArray arrayWithCapacity:0]];
            [self.imageHeights addObject:[NSMutableArray arrayWithCapacity:0]];
            [self.heightOfColumns addObject:[NSNumber numberWithFloat:0.0f]];
        }
    }
    
    return self;
}

- (void)dealloc
{
    self.imagePaths = nil;
    self.imageHeights = nil;
    self.heightOfColumns = nil;
    self.columnNumber = 0;
    
    [super dealloc];
}

- (void)addThumbnailesFromImagePaths:(NSMutableArray *)newImagePaths
                    FromImageHeights:(NSMutableArray *)newImageHeights
                          fromHeader:(BOOL)fromHeader
{
    for (int i = 0; i < newImagePaths.count; i++)
    {
        int minHeight = MAXFLOAT;
        int minHeightColumnIndex = 0;
        //找出最短高度的列号以及其高度值
        for (int j = 0; j < self.columnNumber; j++)
        {
            NSNumber *columnHeight = (NSNumber *)[self.heightOfColumns objectAtIndex:j];
            if ([columnHeight floatValue] < minHeight)
            {
                minHeightColumnIndex = j;
                minHeight = [columnHeight floatValue];
            }
        }
        NSString *imagePath = [newImagePaths objectAtIndex:i];
        NSNumber *height = (NSNumber *)[newImageHeights objectAtIndex:i];
        if (fromHeader)
        {
            [[self.imagePaths objectAtIndex:minHeightColumnIndex] insertObject:imagePath atIndex:0];
            [[self.imageHeights objectAtIndex:minHeightColumnIndex] insertObject:height atIndex:0];
        }
        else
        {
            [[self.imagePaths objectAtIndex:minHeightColumnIndex] addObject:imagePath];
            [[self.imageHeights objectAtIndex:minHeightColumnIndex] addObject:height];
        }
        
        NSNumber *newHeight = [NSNumber numberWithFloat: minHeight + [height floatValue]];
        [self.heightOfColumns replaceObjectAtIndex:minHeightColumnIndex withObject:newHeight];
    }
}

- (NSString *)getImagePathAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imagePath = nil;
    if ([self.imagePaths count] > indexPath.section) {
        NSMutableArray *imagesInColumn = [self.imagePaths objectAtIndex:indexPath.section];
        if ([imagesInColumn count] > indexPath.row) {
            imagePath = [imagesInColumn objectAtIndex:indexPath.row];
        }
    }
    return imagePath;
}

- (float )getImageHeightAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0;
    if ([self.imageHeights count] > indexPath.section)
    {
        NSMutableArray *imageHeightsInColumn = [self.imageHeights objectAtIndex:indexPath.section];
        if ([imageHeightsInColumn count] > indexPath.row)
        {
            height  = [((NSNumber *)[imageHeightsInColumn objectAtIndex:indexPath.row]) floatValue];
        }
    }
    return height;
}

@end
