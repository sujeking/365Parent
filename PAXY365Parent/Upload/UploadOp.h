//
//  PicOperation.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-03-15
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadOp : NSOperation
{
    UIImage *imageToSend;
    NSString *notesToSend;
}

@property (retain) UIImage *imageToSend;
@property (copy) NSString *notesToSend;

- (NSString *)uploading;

@end
