//
//  InvoiceEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "InvoiceEntity.h"

@implementation InvoiceEntity
@synthesize InvoiceID;
@synthesize InvoiceTitle;
@synthesize UserID;
@synthesize AddDate;

-(void) dealloc
{
    self.InvoiceID = nil;
    self.InvoiceTitle = nil;
    self.UserID = nil;
    self.AddDate = nil;
    
    [super dealloc];
}

@end