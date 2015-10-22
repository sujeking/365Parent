//
//  BaseNetViewController.h
//  FinalFantasy
//
//  Created by space bj on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Services.h"
#import "BaseViewController.h"
#import "NetManager.h"


@interface BaseNetViewController : BaseViewController <NetManagerDelegate>
{ 
    
    int currentPage;
    int pageSize;
    int totalNumber;
    
    BOOL isShowLoading;
    BOOL isHaveData;//确认是否有数据
}

@property BOOL isShowLoading;

-(NSDictionary *) validationString:(id) data;


-(void) netFinish:(NSDictionary *) jsonString withUserInfo:(NSDictionary *) userInfo;
-(void) netFinish:(NSDictionary *) jsonString withUserInfo:(NSDictionary *) userInfo andURL:(NSString *) url;

-(void) netError:(NSString *) errorMsg withUserInfo:(NSDictionary *) userInfo;
-(void) netError:(NSString *) errorMsg withUserInfo:(NSDictionary *) userInfo andURL:(NSString *) url;

@end
