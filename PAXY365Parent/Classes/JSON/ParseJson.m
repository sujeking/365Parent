//
//  ParseJson.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ParseJson.h"


@implementation ParseJson



//获取问卷调查列表
+(NSMutableArray *) getQuestionList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        QuestionEntity *entity = [[QuestionEntity alloc] init];
        
        entity.QuestionID = [tempDic objectForKey:@"QuestionID"];
        entity.QuestionTitle = [tempDic objectForKey:@"QuestionTitle"];
        entity.QuestionContent = [tempDic objectForKey:@"QuestionContent"];
        entity.QuestionType = [tempDic objectForKey:@"QuestionType"];
        entity.QuestionStatus = [tempDic objectForKey:@"QuestionStatus"];
        entity.UserAmount = [tempDic objectForKey:@"UserAmount"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}


//获取新闻列表
+(NSMutableArray *) getNewsList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        NewsEntity *entity = [[NewsEntity alloc] init];
        
        entity.newsId = [tempDic objectForKey:@"NewsID"];
        entity.newsTitle = [tempDic objectForKey:@"NewsTitle"];
        entity.newsAuthor = [tempDic objectForKey:@"NewsAuthor"];
        entity.newsDesc = [tempDic objectForKey:@"NewsDesc"];
        entity.newsContent = [tempDic objectForKey:@"NewsContent"];
        entity.visitNum = [tempDic objectForKey:@"VisitNum"];
        entity.newsImage = [tempDic objectForKey:@"NewsImage"];
        entity.userId = [tempDic objectForKey:@"UserID"];
        entity.addDate = [tempDic objectForKey:@"AddDate"];
        entity.titleB = [tempDic objectForKey:@"TitleB"];
        entity.titleColor = [tempDic objectForKey:@"TitleColor"];
        entity.showImg = [tempDic objectForKey:@"ShowImg"];
        entity.showDate = [tempDic objectForKey:@"ShowDate"];
        entity.nickName = [tempDic objectForKey:@"NickName"];
        entity.userImage = [tempDic objectForKey:@"HeadImage"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取安全警示台列表
+(NSMutableArray *) getWarningList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        WarningEntity *entity = [[WarningEntity alloc] init];
   
        entity.SafeID = [tempDic objectForKey:@"SafeID"];
        entity.SafeTitle = [tempDic objectForKey:@"SafeTitle"];
        entity.SafeImage = [tempDic objectForKey:@"SafeImage"];
        entity.ImagesList = [tempDic objectForKey:@"ImagesList"];
        entity.UserName = [tempDic objectForKey:@"UserName"];
        entity.RealName = [tempDic objectForKey:@"RealName"];
        entity.SafeAddress = [tempDic objectForKey:@"SafeAddress"];
        entity.SchoolInfo = [tempDic objectForKey:@"SchoolInfo"];
        entity.SafeDesc = [tempDic objectForKey:@"SafeDesc"];
        entity.SafeLat = [tempDic objectForKey:@"SafeLat"];
        entity.SafeLng = [tempDic objectForKey:@"SafeLng"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.Distance = [tempDic objectForKey:@"Distance"];
        entity.Unit = [tempDic objectForKey:@"Unit"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        entity.SafeStatus = [tempDic objectForKey:@"SafeStauts"];
        entity.UserImage = [tempDic objectForKey:@"UserImage"];
        entity.ClickNum = [tempDic objectForKey:@"ClickNum"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}


+(NSMutableArray *) getMessageList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        MessageEntity *entity = [[MessageEntity alloc] init];
        
        entity.MessageID = [tempDic objectForKey:@"MessageID"];
        entity.MessageTitle = [tempDic objectForKey:@"MessageTitle"];
        entity.MessageContent = [tempDic objectForKey:@"MessageContent"];
        entity.MessageStatus = [tempDic objectForKey:@"MessageStatus"];
        entity.MessageType = [tempDic objectForKey:@"MessageType"];
        entity.MessageFlag = [tempDic objectForKey:@"MessageFlag"];
        entity.SendUserID = [tempDic objectForKey:@"SendUserID"];
        entity.SendUserName = [tempDic objectForKey:@"SendUserName"];
        entity.SendUserImage = [tempDic objectForKey:@"SendUserImage"];
        entity.AcceptUserID = [tempDic objectForKey:@"AcceptUserID"];
        entity.AcceptUserName = [tempDic objectForKey:@"AcceptUserName"];
        entity.AcceptUserImage = [tempDic objectForKey:@"AcceptUserImage"];
        entity.CourseName = [tempDic objectForKey:@"CourseName"];
        entity.MessageImage = [tempDic objectForKey:@"MessageImage"];
        entity.ReviewDesc = [tempDic objectForKey:@"ReviewDesc"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        entity.LeaveDays = [tempDic objectForKey:@"LeaveDays"];
        entity.LeaveTime =[NSString stringWithFormat:@"%@ - %@",[tempDic objectForKey:@"StartTime"],[tempDic objectForKey:@"EndTime"]];
        entity.LeaveType = [tempDic objectForKey:@"LeaveType"];
        entity.ShowDate = [tempDic objectForKey:@"ShowDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取区域列表
+(NSMutableArray *) getAreaList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        AreaEntity *entity = [[AreaEntity alloc] init];
        
        entity.AreaID = [tempDic objectForKey:@"AreaID"];
        entity.AreaName = [tempDic objectForKey:@"AreaName"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取城市列表
+(NSMutableArray *) getCityList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        CityEntity *entity = [[CityEntity alloc] init];
        
        entity.cityId = [tempDic objectForKey:@"CityID"];
        entity.cityName = [tempDic objectForKey:@"CityName"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取学校列表
+(NSMutableArray *) getSchoolList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        SchoolEntity *entity = [[SchoolEntity alloc] init];
        
        entity.SchoolID = [tempDic objectForKey:@"SchoolID"];
        entity.SchoolName = [tempDic objectForKey:@"SchoolName"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取班级列表
+(NSMutableArray *) getClassList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        ClasssEntity *entity = [[ClasssEntity alloc] init];
        
        entity.ClassID = [tempDic objectForKey:@"ClassID"];
        entity.ClassName = [tempDic objectForKey:@"ClassName"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取课程列表
+(NSMutableArray *) getCourseList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        CourseEntity *entity = [[CourseEntity alloc] init];
        
        entity.CourseID = [tempDic objectForKey:@"CourseID"];
        entity.CourseName = [tempDic objectForKey:@"CourseName"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取评论列表
+(NSMutableArray *) getCommentsList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        CommentEntity *entity = [[CommentEntity alloc] init];
        
        entity.CommentID = [tempDic objectForKey:@"CommentID"];
        entity.CommentContent = [tempDic objectForKey:@"CommentContent"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.UserName = [tempDic objectForKey:@"UserName"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取通讯录
+(NSMutableArray *) getContactsList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        ContactsEntity *entity = [[ContactsEntity alloc] init];
        
        
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.NickName = [tempDic objectForKey:@"NickName"];
        entity.UserImage = [tempDic objectForKey:@"UserImage"];
        entity.UserPhone = [tempDic objectForKey:@"UserPhone"];
        entity.UserGender = [tempDic objectForKey:@"UserGender"];
        entity.UserStatus = [tempDic objectForKey:@"UserStatus"];
        entity.UserType = [tempDic objectForKey:@"UserType"];
        entity.UserMoney = [tempDic objectForKey:@"UserMoney"];
        entity.StudentNo = [tempDic objectForKey:@"StudentNo"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取绑定关系
+(NSMutableArray *) getBindList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        BindEntity *entity = [[BindEntity alloc] init];
        
        entity.BindID = [tempDic objectForKey:@"BindID"];
        entity.ProvinceID = [tempDic objectForKey:@"ProvinceID"];
        entity.ProvinceName = [tempDic objectForKey:@"ProvinceName"];
        entity.CityID = [tempDic objectForKey:@"CityID"];
        entity.CityName = [tempDic objectForKey:@"CityName"];
        entity.DistrictID = [tempDic objectForKey:@"DistrictID"];
        entity.DistrictName = [tempDic objectForKey:@"DistrictName"];
        entity.SchoolID = [tempDic objectForKey:@"SchoolID"];
        entity.SchoolName = [tempDic objectForKey:@"SchoolName"];
        entity.ClassID = [tempDic objectForKey:@"ClassID"];
        entity.ClassName = [tempDic objectForKey:@"ClassName"];
        entity.GradeID = [tempDic objectForKey:@"GradeID"];
        entity.TeacherType = [tempDic objectForKey:@"TeacherType"];
        entity.CourseID = [tempDic objectForKey:@"CourseID"];
        entity.CourseName = [tempDic objectForKey:@"CourseName"];
        entity.ChildRelation = [tempDic objectForKey:@"ChildRelation"];
        entity.ChildName = [tempDic objectForKey:@"ChildName"];
        entity.BindType = [tempDic objectForKey:@"BindType"];
        entity.BindDefault = [tempDic objectForKey:@"BindDefault"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        [entity release];
    }
    return retArray;
}





/*
 old
 */


//获取商家列表
+(NSMutableArray *) getShopList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        ShopEntity *entity = [[ShopEntity alloc] init];
     
        entity.ShopID = [tempDic objectForKey:@"ShopID"];
        entity.ShopName = [tempDic objectForKey:@"ShopName"];
        entity.ShopImage1 = [tempDic objectForKey:@"ShopImage1"];
        entity.ShopImage2 = [tempDic objectForKey:@"ShopImage2"];
        entity.ShopImage3 = [tempDic objectForKey:@"ShopImage3"];
        entity.ShopLicence = [tempDic objectForKey:@"ShopLicence"];
        entity.ShopDesc = [tempDic objectForKey:@"ShopDesc"];
        entity.ShopPhone = [tempDic objectForKey:@"ShopPhone"];
        entity.ShopAddress = [tempDic objectForKey:@"ShopAddress"];
        entity.ShopLat = [tempDic objectForKey:@"ShopLat"];
        entity.ShopLng = [tempDic objectForKey:@"ShopLng"];
        entity.ShopStar = [tempDic objectForKey:@"ShopStar"];
        entity.CommentsNum = [tempDic objectForKey:@"CommentsNum"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        entity.Distance = [tempDic objectForKey:@"Distance"];
        entity.Unit = [tempDic objectForKey:@"Unit"];
        entity.SaleNum = [tempDic objectForKey:@"SaleNum"];
        entity.StartMoney = [tempDic objectForKey:@"StartMoney"];
        entity.DeliveryMoney = [tempDic objectForKey:@"DeliveryMoney"];
        entity.LunchboxMoney = [tempDic objectForKey:@"LunchboxMoney"];
        entity.MakeTime = [tempDic objectForKey:@"MakeTime"];
        entity.OpenTime = [tempDic objectForKey:@"OpenTime"];
        entity.EndTime = [tempDic objectForKey:@"EndTime"];
        entity.DeliveryTime = [tempDic objectForKey:@"DeliveryTime"];
        entity.BusinessStatus = [tempDic objectForKey:@"BusinessStatus"];
        entity.ShopStatus = [tempDic objectForKey:@"ShopStatus"];
        entity.IsOneself = [tempDic objectForKey:@"IsOneself"];
        entity.IsBooking = [tempDic objectForKey:@"IsBooking"];
        entity.IsTakeaway = [tempDic objectForKey:@"IsTakeaway"];
        entity.SaleNum = [tempDic objectForKey:@"SaleNum"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取菜品列表
+(NSMutableArray *) getMenusList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        MenusEntity *entity = [[MenusEntity alloc] init];
        
        entity.MenuID = [tempDic objectForKey:@"MenuID"];
        entity.MenuName = [tempDic objectForKey:@"MenuName"];
        entity.ShopID = [tempDic objectForKey:@"ShopID"];
        entity.CategoryID = [tempDic objectForKey:@"CategoryID"];
        entity.MenuPrice = [tempDic objectForKey:@"MenuPrice"];
        entity.TransferPrice = [tempDic objectForKey:@"TransferPrice"];
        entity.MenuImage = [tempDic objectForKey:@"MenuImage"];
        entity.MakeTime = [tempDic objectForKey:@"MakeTime"];
        entity.SaleNum = [tempDic objectForKey:@"SaleNum"];
        entity.MenuStatus = [tempDic objectForKey:@"MenuStatus"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        entity.ShowMonth = [tempDic objectForKey:@"ShowMonth"];
        entity.ShowWeek = [tempDic objectForKey:@"ShowWeek"];
        entity.ShowTime = [tempDic objectForKey:@"ShowTime"];
        entity.MenuType = [tempDic objectForKey:@"MenuType"];
        entity.MainDishTaste = [tempDic objectForKey:@"MainDishTaste"];
        entity.DishSub = [tempDic objectForKey:@"DishSub"];
        entity.DishFree = [tempDic objectForKey:@"DishFree"];
        entity.FollowDrink = [tempDic objectForKey:@"FollowDrink"];
        entity.TastePreference = [tempDic objectForKey:@"TastePreference"];
        entity.MainTransfer = [tempDic objectForKey:@"MainTransfer"];
        entity.SubTransfer = [tempDic objectForKey:@"SubTransfer"];
        entity.JoinNum = [tempDic objectForKey:@"JoinNum"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取地址列表
+(NSMutableArray *) getAddressList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        AddressEntity *entity = [[AddressEntity alloc] init];
        
        entity.AddressID = [tempDic objectForKey:@"AddressID"];
        entity.AddressName = [tempDic objectForKey:@"AddressName"];
        entity.AddressIntro = [tempDic objectForKey:@"AddressIntro"];
        entity.AddressPhone = [tempDic objectForKey:@"AddressPhone"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        entity.AreaID = [tempDic objectForKey:@"AreaID"];
        entity.AreaName = [tempDic objectForKey:@"AreaName"];
        entity.DistrictID = [tempDic objectForKey:@"DistrictID"];
        entity.DistrictName = [tempDic objectForKey:@"DistrictName"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取发票列表
+(NSMutableArray *) getInvoiceList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        InvoiceEntity *entity = [[InvoiceEntity alloc] init];
        
        entity.InvoiceID = [tempDic objectForKey:@"InvoiceID"];
        entity.InvoiceTitle = [tempDic objectForKey:@"InvoiceTitle"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取用户订单列表
+(NSMutableArray *) getOrdersList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        OrderEntity *entity = [[OrderEntity alloc] init];
        
        entity.OrderID = [tempDic objectForKey:@"OrderID"];
        entity.OrderMoney = [tempDic objectForKey:@"OrderMoney"];
        entity.MenusIDs = [tempDic objectForKey:@"MenusIDs"];
        entity.OrderStatus = [tempDic objectForKey:@"OrderStatus"];
        entity.StatusRemark = [tempDic objectForKey:@"StatusRemark"];
        entity.StatusID = [tempDic objectForKey:@"StatusID"];
        entity.OrderNum = [tempDic objectForKey:@"OrderNum"];
        entity.Remark = [tempDic objectForKey:@"Remark"];
        entity.PayStyle = [tempDic objectForKey:@"PayStyle"];
        entity.OrderType = [tempDic objectForKey:@"OrderType"];
        entity.OrderAmount = [tempDic objectForKey:@"OrderAmount"];
        entity.FoodMoney = [tempDic objectForKey:@"FoodMoney"];
        entity.DeliveryMoney = [tempDic objectForKey:@"DeliveryMoney"];
        entity.LunchboxMoney = [tempDic objectForKey:@"LunchboxMoney"];
        entity.Contacts = [tempDic objectForKey:@"Contacts"];
        entity.InvoiceTitle = [tempDic objectForKey:@"InvoiceTitle"];
        entity.DeliveryTime = [tempDic objectForKey:@"DeliveryTime"];
        entity.IsPay = [tempDic objectForKey:@"IsPay"];
        entity.ConfirmTime = [tempDic objectForKey:@"ConfirmTime"];
        entity.MakeTime = [tempDic objectForKey:@"MakeTime"];
        entity.FoodTime = [tempDic objectForKey:@"FoodTime"];
        entity.MakeActiveTime = [tempDic objectForKey:@"MakeActiveTime"];
        entity.GetTime = [tempDic objectForKey:@"GetTime"];
        entity.FinishTime = [tempDic objectForKey:@"FinishTime"];
        entity.ShopID = [tempDic objectForKey:@"ShopID"];
        entity.ShopName = [tempDic objectForKey:@"ShopName"];
        entity.ShopPhone = [tempDic objectForKey:@"ShopPhone"];
        entity.OfficialPhone = [tempDic objectForKey:@"OfficialPhone"];
        entity.ShopImage = [tempDic objectForKey:@"ShopImage"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}


//获取主菜口味列表
+(NSMutableArray *) getTasteList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        TasteEntity *entity = [[TasteEntity alloc] init];
        
        entity.TasteID = [tempDic objectForKey:@"TasteID"];
        entity.TasteName = [tempDic objectForKey:@"TasteName"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}




//old

//获取产品列表
+(NSMutableArray *) getProductsList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        ProductsEntity *entity = [[ProductsEntity alloc] init];
        
        entity.ProductID = [tempDic objectForKey:@"ProductID"];
        entity.ProductName = [tempDic objectForKey:@"ProductName"];
        entity.ProductImage1 = [tempDic objectForKey:@"ProductImage1"];
        entity.ProductImage2 = [tempDic objectForKey:@"ProductImage2"];
        entity.ProductImage3 = [tempDic objectForKey:@"ProductImage3"];
        entity.ProductType = [tempDic objectForKey:@"ProductType"];
        entity.ProductTypeID = [tempDic objectForKey:@"ProductTypeID"];
        entity.ProductDesc = [tempDic objectForKey:@"ProductDesc"];
        entity.ProductSubType = [tempDic objectForKey:@"ProductSubType"];
        entity.ProductStatus = [tempDic objectForKey:@"ProductStatus"];
        entity.ProductPrice = [tempDic objectForKey:@"ProductPrice"];
        entity.DiscountPrice = [tempDic objectForKey:@"DiscountPrice"];
        entity.ReviewContent = [tempDic objectForKey:@"ReviewContent"];
        entity.ShopID = [tempDic objectForKey:@"ShopID"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}



//获取用户发布需求列表
+(NSMutableArray *) getServiceList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        ServiceEntity *entity = [[ServiceEntity alloc] init];
        
        entity.ServiceID= [tempDic objectForKey:@"ServiceID"];
        entity.ServiceName = [tempDic objectForKey:@"ServiceName"];
        entity.ServiceImage1 = [tempDic objectForKey:@"ServiceImage1"];
        entity.ServiceImage2 = [tempDic objectForKey:@"ServiceImage2"];
        entity.ServiceImage3 = [tempDic objectForKey:@"ServiceImage3"];
        entity.ServiceDesc = [tempDic objectForKey:@"ServiceDesc"];
        entity.ServiceType = [tempDic objectForKey:@"ServiceType"];
        entity.ServiceAddress = [tempDic objectForKey:@"ServiceAddress"];
        entity.ServiceStatus = [tempDic objectForKey:@"ServiceStatus"];
        entity.PriceNum = [tempDic objectForKey:@"PriceNum"];
        entity.Lat = [tempDic objectForKey:@"Lat"];
        entity.Lng = [tempDic objectForKey:@"Lng"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.UserName = [tempDic objectForKey:@"UserName"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取产品类别列表
+(NSMutableArray *) getTypeList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        TypeEntity *entity = [[TypeEntity alloc] init];
        
        entity.TypeID= [tempDic objectForKey:@"TypeID"];
        entity.TypeName = [tempDic objectForKey:@"TypeName"];
        entity.ParentID = [tempDic objectForKey:@"ParentID"];
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}




//获取商户兑现列表
+(NSMutableArray *) getCashList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        CashEntity *entity = [[CashEntity alloc] init];
        
        entity.CashID = [tempDic objectForKey:@"CashID"];
        entity.CashNum = [tempDic objectForKey:@"CashNum"];
        entity.CashStatus = [tempDic objectForKey:@"CashStatus"];
        entity.ShopID = [tempDic objectForKey:@"ShopID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取用户充值记录列表
+(NSMutableArray *) getRechargeList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        RechargeEntity *entity = [[RechargeEntity alloc] init];
        
        entity.RechargeID = [tempDic objectForKey:@"RechargeID"];
        entity.RechargeNum = [tempDic objectForKey:@"RechargeNum"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}


//获取车型列表
+(NSMutableArray *) getMotoTypeList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        MotoTypeEntity *entity = [[MotoTypeEntity alloc] init];
        
        entity.MotoTypeId = [tempDic objectForKey:@"CID"];
        entity.MotoTypeName = [tempDic objectForKey:@"CName"];
        
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}


//获取红包列表
+(NSMutableArray *) getLuckyMoneyList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        LuckyMoneyEntity *entity = [[LuckyMoneyEntity alloc] init];
        
        entity.LuckyMoneyID= [tempDic objectForKey:@"LuckyMoneyID"];
        entity.LuckyMoneyNum = [tempDic objectForKey:@"LuckyMoneyNum"];
        entity.LuckyMoneyStatus = [tempDic objectForKey:@"LuckyMoneyStatus"];
        entity.LuckyMoneyTypeID = [tempDic objectForKey:@"LuckyMoneyTypeID"];
        entity.LuckyMoneyName= [tempDic objectForKey:@"LuckyMoneyName"];
        entity.ServiceTypeID = [tempDic objectForKey:@"ServiceTypeID"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

//获取自定义订单
+(NSMutableArray *) getCustomOrderList:(NSDictionary *) dic
{
    NSArray *array = (NSArray *)[dic objectForKey:@"List"];
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSDictionary *tempDic = (NSDictionary *)[array objectAtIndex:i];
        CustomOrderEntity *entity = [[CustomOrderEntity alloc] init];
        
        entity.CustomID= [tempDic objectForKey:@"CustomID"];
        entity.CustomName = [tempDic objectForKey:@"CustomName"];
        entity.CustomContent = [tempDic objectForKey:@"CustomContent"];
        entity.CustomPrice = [tempDic objectForKey:@"CustomPrice"];
        entity.CustomStatus= [tempDic objectForKey:@"CustomStatus"];
        entity.ShopID = [tempDic objectForKey:@"ShopID"];
        entity.UserID = [tempDic objectForKey:@"UserID"];
        entity.UserPhone = [tempDic objectForKey:@"UserPhone"];
        entity.AddDate = [tempDic objectForKey:@"AddDate"];
        [retArray addObject:entity];
        
        [entity release];
    }
    return retArray;
}

@end
