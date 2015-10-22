//
//  MessageEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface MessageEntity : BaseEntity
{
    NSString *MessageID;
    NSString *MessageTitle;
    NSString *MessageContent;
    NSString *MessageType;
    NSString *MessageStatus;
    NSString *MessageFlag;
    NSString *SendUserID;
    NSString *AcceptUserID;
    NSString *SendUserName;
    NSString *AcceptUserName;
    NSString *SendUserImage;
    NSString *AcceptUserImage;
    NSString *CourseName;
    NSString *MessageImage;
    NSString *CommentsList;
    NSString *LeaveDays;
    NSString *ReviewDesc;
    NSString *AddDate;
    NSString *LeaveTime;
    NSString *LeaveType;
    NSString *ShowDate;
}

@property (nonatomic,retain) NSString *MessageID;
@property (nonatomic,retain) NSString *MessageTitle;
@property (nonatomic,retain) NSString *MessageContent;
@property (nonatomic,retain) NSString *MessageType;
@property (nonatomic,retain) NSString *MessageStatus;
@property (nonatomic,retain) NSString *MessageFlag;
@property (nonatomic,retain) NSString *SendUserID;
@property (nonatomic,retain) NSString *AcceptUserID;
@property (nonatomic,retain) NSString *SendUserName;
@property (nonatomic,retain) NSString *AcceptUserName;
@property (nonatomic,retain) NSString *SendUserImage;
@property (nonatomic,retain) NSString *AcceptUserImage;
@property (nonatomic,retain) NSString *CourseName;
@property (nonatomic,retain) NSString *MessageImage;
@property (nonatomic,retain) NSString *CommentsList;
@property (nonatomic,retain) NSString *LeaveDays;
@property (nonatomic,retain) NSString *ReviewDesc;
@property (nonatomic,retain) NSString *AddDate;
@property (nonatomic,retain) NSString *LeaveTime;
@property (nonatomic,retain) NSString *LeaveType;
@property (nonatomic,retain) NSString *ShowDate;

@end