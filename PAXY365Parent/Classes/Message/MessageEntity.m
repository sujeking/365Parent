//
//  MessageEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "MessageEntity.h"

@implementation MessageEntity
@synthesize MessageID;
@synthesize MessageContent;
@synthesize MessageType;
@synthesize MessageStatus;
@synthesize MessageFlag;
@synthesize SendUserID;
@synthesize AcceptUserID;
@synthesize SendUserName;
@synthesize AcceptUserName;
@synthesize SendUserImage;
@synthesize AcceptUserImage;
@synthesize CourseName;
@synthesize MessageImage;
@synthesize CommentsList;
@synthesize LeaveDays;
@synthesize ReviewDesc;
@synthesize AddDate;
@synthesize LeaveTime;
@synthesize LeaveType;
@synthesize ShowDate;
@synthesize MessageTitle;

-(void) dealloc
{
    self.MessageID = nil;
    self.MessageTitle = nil;
    self.MessageContent = nil;
    self.MessageType = nil;
    self.MessageStatus = nil;
    self.MessageFlag = nil;
    self.SendUserID = nil;
    self.AcceptUserID = nil;
    self.SendUserName = nil;
    self.AcceptUserName = nil;
    self.SendUserImage = nil;
    self.AcceptUserImage = nil;
    self.CourseName = nil;
    self.MessageImage = nil;
    self.CommentsList = nil;
    self.LeaveDays = nil;
    self.ReviewDesc = nil;
    self.AddDate = nil;
    self.LeaveTime = nil;
    self.LeaveType = nil;
    self.ShowDate = nil;
    
    [super dealloc];
}

@end
