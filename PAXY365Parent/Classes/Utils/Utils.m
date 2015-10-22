//
//  Utils.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "Utils.h"
#import "Reachability.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils

+(UIImage*) rotateImage:(UIImage *)aImage
{
	CGImageRef imgRef = aImage.CGImage;
	
	CGFloat width = CGImageGetWidth(imgRef);
	
	CGFloat height = CGImageGetHeight(imgRef);
	
	
	CGAffineTransform transform = CGAffineTransformIdentity;
	
	CGRect bounds = CGRectMake(0, 0, width, height);
	
	
	CGFloat scaleRatio = 1;
	
	
	CGFloat boundHeight;
	
	UIImageOrientation orient = aImage.imageOrientation;
	
	switch(orient) 
	
	{
			
		case UIImageOrientationUp: //EXIF = 1
			
			transform = CGAffineTransformIdentity;
			
			break;
			
			
		case UIImageOrientationUpMirrored: //EXIF = 2
			
			transform = CGAffineTransformMakeTranslation(width, 0.0);
			
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			
			break;
			
			
		case UIImageOrientationDown: //EXIF = 3
			
			transform = CGAffineTransformMakeTranslation(width, height);
			
			transform = CGAffineTransformRotate(transform, M_PI);
			
			break;
			
			
		case UIImageOrientationDownMirrored: //EXIF = 4
			
			transform = CGAffineTransformMakeTranslation(0.0, height);
			
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			
			break;
			
			
		case UIImageOrientationLeftMirrored: //EXIF = 5
			
			boundHeight = bounds.size.height;
			
			bounds.size.height = bounds.size.width;
			
			bounds.size.width = boundHeight;
			
			transform = CGAffineTransformMakeTranslation(height, width);
			
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			
			break;
			
			
		case UIImageOrientationLeft: //EXIF = 6
			
			boundHeight = bounds.size.height;
			
			bounds.size.height = bounds.size.width;
			
			bounds.size.width = boundHeight;
			
			transform = CGAffineTransformMakeTranslation(0.0, width);
			
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			
			break;
			
			
		case UIImageOrientationRightMirrored: //EXIF = 7
			
			boundHeight = bounds.size.height;
			
			bounds.size.height = bounds.size.width;
			
			bounds.size.width = boundHeight;
			
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			
			break;
			
			
		case UIImageOrientationRight: //EXIF = 8
			
			boundHeight = bounds.size.height;
			
			bounds.size.height = bounds.size.width;
			
			bounds.size.width = boundHeight;
			
			transform = CGAffineTransformMakeTranslation(height, 0.0);
			
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			
			break;
			
			
		default:
			
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			
	}
	
	
	UIGraphicsBeginImageContext(bounds.size);
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		
		CGContextTranslateCTM(context, -height, 0);
		
	}
	
	else {
		
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		
		CGContextTranslateCTM(context, 0, -height);
		
	}
	
	
	CGContextConcatCTM(context, transform);
	
	
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	
	return imageCopy;
}

+(CATransition *) createAnimatioin:(NSString *) animationName duration:(float) time subtype:(NSString *) subtype
{
	CATransition *animation = [CATransition animation];
	
	animation.duration = time;
	animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.type = animationName;
	
	if (subtype) 
	{
		animation.subtype = subtype;
	}
	
	
	return animation;
}


+(void) alertWithMessage:(NSString*) message 
{
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	alert.tag = 10000;
	[alert show];
	[alert release];
}

+(void) alertWithMessage:(NSString*) message withDelegate:(id <UIAlertViewDelegate>) delegate
{
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	alert.tag = 10000;
	[alert show];
	[alert release];
}

//获得符合自定义规格的图片
+(UIImage *) getFixedImage:(UIImage *) image width:(int) w height:(int) h {
	
    if(!image)
    {
        return nil;
    }
	CGFloat scaleX=w / image.size.width;
	CGFloat scaleY=h / image.size.height;
	
	CGFloat scale=MAX(scaleX,scaleY);
	
	UIGraphicsBeginImageContext(CGSizeMake(w,h));
	
	CGFloat width=image.size.width * scale;
	CGFloat height=image.size.height * scale;
	
	float dwidth=(w-width)/2;
	float dheight=(h-height)/2;
	
	CGRect rect=CGRectMake(dwidth, dheight, image.size.width * scale, image.size.height * scale);
	[image drawInRect:rect];
	
	UIImage *cropedImg=UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return cropedImg;
}

//从文件中获取数据
+(id) getDataFromFile:(NSString *) fileName
{
    
    CLog(@"调用读文件的方法");
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	
	//NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent: fileName]];
//	if (data == nil)
//	{
//		return nil;
//	}
	
//	NSKeyedUnarchiver *unKeyArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//	
//	//NSMutableArray *mutableArray = [unKeyArchiver decodeObjectForKey:@"key"];
    
    
	return [NSData dataWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent: fileName]];
}

+(void) writeImageToFile:(NSString *) fileName data:(NSData *) data
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
	
    [data writeToFile:path atomically:YES];
}

+(NSString *) writeImageToDocument:(NSString *) docName fileName:(NSString *) fileName data:(NSData *) data
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSString *documentDirectoryName = [documentsDirectory stringByAppendingPathComponent:docName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentDirectoryName]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:documentDirectoryName withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
	NSString *path = [documentDirectoryName stringByAppendingPathComponent:fileName];
    CLog(@"保存文件路径:%@",path);
	
	BOOL b = [data writeToFile:path atomically:YES];
    if (b) 
    {
        return path;
    }
    else
    {
        return nil;
    }
}

+(NSString *) writeImageToDocument:(NSString *) docName fileName:(NSString *) fileName image:(UIImage *) img
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSString *documentDirectoryName = [documentsDirectory stringByAppendingPathComponent:docName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentDirectoryName]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:documentDirectoryName withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
	NSString *path = [documentDirectoryName stringByAppendingPathComponent:fileName];
    NSString *bigImagePath = [path stringByAppendingFormat:@"%@",@"_big"];
    NSString *mediaImagePath = [path stringByAppendingFormat:@"%@",@"_medium"];
    
    CLog(@"保存文件路径:%@",path);
	
    
    NSData *bigImageData = UIImageJPEGRepresentation(img, 0.5f);
    NSData *mediumImageData = UIImageJPEGRepresentation(img, 0.2f);
    
	BOOL b1 = [bigImageData writeToFile:bigImagePath atomically:YES];
    BOOL b2 = [mediumImageData writeToFile:mediaImagePath atomically:YES];
    if (b1 && b2) 
    {
        return path;
    }
    else
    {
        return nil;
    }    
}

+(BOOL) writeImageToDocument:(NSString *) absoultePath image:(UIImage *) img
{
    NSData *mediumImageData = UIImageJPEGRepresentation(img, 1.0f);
    return [mediumImageData writeToFile:absoultePath atomically:YES];
}

+(UIImage *) getImageFromDocument:(NSString *) docName fileName:(NSString *) fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSString *documentDirectoryName = [documentsDirectory stringByAppendingPathComponent:docName];
    
	NSString *imagePath = [documentDirectoryName stringByAppendingPathComponent:fileName];
    CLog(@"保存文件路径:%@",imagePath);
	
    UIImage *retImage = nil;
    return retImage;
}

+(BOOL) removeFileName:(NSString *) fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error = nil;
	
	if ([fileManager fileExistsAtPath:path]) 
	{
		BOOL blDele = [fileManager removeItemAtPath:path error:&error];
		if (!blDele) 
		{
			CLog(@"删除文件失败：%@",[error description]);	
		}
		
		return blDele;
	}
	
	return NO;
}

//向文档中写入数据
+ (void) writeToDocumentDomain:(NSString *) fileName withData:(id) datas
{
	if (datas == nil)
	{
        CLog(@"没有数据");
		return;
	}
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	
	
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *keyArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	

	[keyArchiver encodeObject:datas forKey:@"key"];
	[keyArchiver finishEncoding];
    [keyArchiver release];
    
    [data writeToFile:[documentsDirectory stringByAppendingPathComponent: fileName] atomically: YES];
    [data release];    
}

+(UIImage *) getImageFromFile:(NSString *) fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
	NSData *data = [[[NSData alloc] initWithContentsOfFile:path] autorelease];
	CLog(@"本地图片路径：%@",path);
	return  [UIImage imageWithData:data];
}

//获取时间的字符串
+(NSString *) getNowDateString
{
	NSDate *date =[NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents
	= [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit
							| NSMinuteCalendarUnit |NSSecondCalendarUnit) fromDate:date];
	int year = dayComponents.year;
	int month = dayComponents.month;
	int day = dayComponents.day;
	int hour = dayComponents.hour;
	int min = dayComponents.minute;
	int second = dayComponents.second;
	//当前月份
	NSString *nowDate = [NSString stringWithFormat:@"%d%d%d%02d%02d%02d",year,month,day,hour,min,second];
	
	return nowDate;
}

//获取当前的时间字符串
+(NSString *) getNowDate
{
	//   CLog(@"获取时间");
	NSDate *date =[NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents
	= [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit
							| NSMinuteCalendarUnit |NSSecondCalendarUnit) fromDate:date];
	int year = dayComponents.year;
	int month = dayComponents.month;
	int day = dayComponents.day;
	//	int hour = dayComponents.hour;
	//	int min = dayComponents.minute;
	//	int second = dayComponents.second;
	
	NSString *nowDate = [NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
	
	return nowDate;
}

+(NSString *) getTodayString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    return dateString;    
}

+(NSString *) getRandomUsersString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    return dateString;
}

+(NSDate *) getDateFromString:(NSString *) dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter release];
  
    return date;
}

+(NSData *) getDataFromURL:(NSString *) urlString
{
	NSURL *url=[[NSURL alloc]initWithString:urlString];
	
	NSMutableURLRequest *requestPOST = [[NSMutableURLRequest alloc] initWithURL:url];
	[url release];

	//[requestPOST setHTTPMethod:@"POST"];
	//[requestPOST setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
	
	NSError *error = nil;
	NSData *responseData =[NSURLConnection sendSynchronousRequest:requestPOST returningResponse:nil error:&error];
	[requestPOST release];
	CLog(@"error:%@",error);

	return responseData;
}

+(void) makePretyView:(UIView *) view
{
	[view.layer setBorderColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor];
	[view.layer setBorderWidth:1.0f];	
	[view.layer setCornerRadius:1.0f];
	[view.layer setShouldRasterize:YES];
	[view.layer setShadowOffset:CGSizeMake(1, 1)];
	[view.layer setShadowRadius:1];
	[view.layer setShadowOpacity:1];
    
    UIColor *shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.8f];
	[view.layer setShadowColor:shadowColor.CGColor];
}

+(UILabel *) createLabel
{
	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)] autorelease];
	
	label.center = CGPointMake(160, label.frame.size.height / 2);
	label.backgroundColor = [UIColor clearColor];
	label.tag = 400;
	[label setTextAlignment:UITextAlignmentCenter];
	//[label setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"textbg.png"]]];
	
	[label setTextColor:[Utils colorWithHexString:@"#626262"]];
	[label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22.0f]];
//	[[label layer] setShadowOffset:CGSizeMake(1, 1)];
//	[[label layer] setShadowRadius:1];
//	[[label layer] setShadowOpacity:1];
//	[[label layer] setShadowColor:[UIColor blackColor].CGColor];
//	[label.layer setShouldRasterize:YES];
	
	return label;
}

+(void) setLabelText:(NSString *) text parentView:(UIView *) view
{
	if (view == nil) 
	{
		CLog(@"设置导航字，父视图为空");
		return;
	}
	UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:22.0f];
	CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(320.0f, MAXFLOAT) lineBreakMode:UILineBreakModeCharacterWrap];
	CLog(@"文字长度 %f",size.width);
	
	UILabel *temp = (UILabel *)[view viewWithTag:400];
	if (temp == nil) 
	{
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 44)];
		
		label.center = CGPointMake(160, label.frame.size.height / 2);
		label.backgroundColor = [UIColor clearColor];
		label.tag = 400;
		[label setTextAlignment:UITextAlignmentCenter];
		//[label setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"textbg.png"]]];
		
		[label setTextColor:[Utils colorWithHexString:@"#1eafe6"]];
		[label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22.0f]];
		[[label layer] setShadowOffset:CGSizeMake(1, 1)];
		[[label layer] setShadowRadius:1];
		[[label layer] setShadowOpacity:1];
		[[label layer] setShadowColor:[UIColor blackColor].CGColor];
		[label.layer setShouldRasterize:YES];
		
		[view addSubview:label];
		[label release];
	}
	else
	{
		temp.frame = CGRectMake(temp.frame.origin.x, temp.frame.origin.y, size.width, temp.frame.size.height);
		temp.text = text;
		temp.center = CGPointMake(160, temp.frame.size.height / 2);
		[view bringSubviewToFront:temp];
	}
}

+(void) setULabelShade:(UILabel *) label withShadeColor:(UIColor *) color andFont:(UIFont *) font
{
	[label setTextColor:[UIColor lightGrayColor]];
	[label setFont:font];
//	[[label layer] setShadowOffset:CGSizeMake(1, 1)];
//	[[label layer] setShadowRadius:0.5];
//	[[label layer] setShadowOpacity:1];
//	[[label layer] setShadowColor:color.CGColor];
//	[label.layer setShouldRasterize:YES];
}

+(void) setULabelShade:(UILabel *) label
{
	//[label setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_org.png"]]];
	[label setTextColor:[Utils colorWithHexString:@"#309fcb"]];
	[label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0f]];
//	[[label layer] setShadowOffset:CGSizeMake(1, 1)];
//	[[label layer] setShadowRadius:1];
//	[[label layer] setShadowOpacity:1];
//	[[label layer] setShadowColor:[UIColor grayColor].CGColor];
//	[label.layer setShouldRasterize:YES];
}

+(void) setFemaleLabel:(UILabel *) label
{
	[label setTextColor:[Utils colorWithHexString:@"#ff6e9a"]];
	[label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0f]];
//	[[label layer] setShadowOffset:CGSizeMake(1, 1)];
//	[[label layer] setShadowRadius:1];
//	[[label layer] setShadowOpacity:1];
//	[[label layer] setShadowColor:[UIColor grayColor].CGColor];
//	[label.layer setShouldRasterize:YES];
}

+(UIColor *) colorWithHexString: (NSString *) string
{
	NSString *cString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return DEFAULT_VOID_COLOR;
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
	if ([cString length] != 6) return DEFAULT_VOID_COLOR;
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}

+(int) getWordsLength:(NSString *) word
{
	int i;
	int n = [word length];
	int count = 0;
	
    unichar c;
	
    for(i = 0;i < n; i++)
	{
        c = [word characterAtIndex:i];
		if (c > 19968 && c < (19968+20902)) 
		{
			count = count + 2;
		}
		else
		{
			count = count + 1;
		}
    }
	CLog(@"总字数： %d",count);
    return count;
}

+(NSArray *) getUEArray
{
	NSMutableArray *v = [NSMutableArray array];

	[v addObject:@"\ue415"];
	[v addObject:@"\ue056"];
	[v addObject:@"\ue057"];
	[v addObject:@"\ue414"];
	[v addObject:@"\ue405"];
	[v addObject:@"\ue106"];
	[v addObject:@"\ue418"];
	[v addObject:@"\ue417"];
	[v addObject:@"\ue40d"];
	[v addObject:@"\ue40a"];
	[v addObject:@"\ue404"];
	[v addObject:@"\ue105"];
	[v addObject:@"\ue409"];
	[v addObject:@"\ue40e"];
	[v addObject:@"\ue402"];
	[v addObject:@"\ue108"];
	[v addObject:@"\ue403"];
	[v addObject:@"\ue058"];
	[v addObject:@"\ue407"];
	[v addObject:@"\ue401"];
	[v addObject:@"\ue40f"];
	[v addObject:@"\ue40b"];
	[v addObject:@"\ue406"];
	[v addObject:@"\ue413"];
	[v addObject:@"\ue411"];
	[v addObject:@"\ue412"];
	[v addObject:@"\ue410"];
	[v addObject:@"\ue107"];
	[v addObject:@"\ue059"];
	[v addObject:@"\ue416"];
	[v addObject:@"\ue408"];
	[v addObject:@"\ue40c"];
	[v addObject:@"\ue11a"];
	[v addObject:@"\ue10c"];
	[v addObject:@"\ue32c"];
	[v addObject:@"\ue32a"];
	[v addObject:@"\ue32d"];
	[v addObject:@"\ue328"];
	[v addObject:@"\ue32b"];
	[v addObject:@"\ue022"];
	[v addObject:@"\ue023"];
	[v addObject:@"\ue327"];
	[v addObject:@"\ue329"];
	[v addObject:@"\ue32f"];
	[v addObject:@"\ue021"];
	[v addObject:@"\ue020"];
	[v addObject:@"\ue13c"];
	[v addObject:@"\ue326"];
	[v addObject:@"\ue11d"];
	[v addObject:@"\ue00e"];
	[v addObject:@"\ue421"];
	[v addObject:@"\ue420"];
	[v addObject:@"\ue00d"];
	[v addObject:@"\ue010"];
	[v addObject:@"\ue011"];
	[v addObject:@"\ue41e"];
	[v addObject:@"\ue012"];
	[v addObject:@"\ue422"];
	[v addObject:@"\ue231"];
	[v addObject:@"\ue230"];
	[v addObject:@"\ue00f"];
	[v addObject:@"\ue41f"];
	[v addObject:@"\ue41c"];
	[v addObject:@"\ue41b"];
	[v addObject:@"\ue419"];
	[v addObject:@"\ue04a"];
	[v addObject:@"\ue04b"];
	[v addObject:@"\ue04c"];
	[v addObject:@"\ue13d"];
	[v addObject:@"\ue306"];
	[v addObject:@"\ue030"];
	[v addObject:@"\ue110"];
	[v addObject:@"\ue032"];
	[v addObject:@"\ue303"];
	[v addObject:@"\ue437"];
	[v addObject:@"\ue445"];
	[v addObject:@"\ue033"];
	[v addObject:@"\ue112"];
	[v addObject:@"\ue00a"];
	[v addObject:@"\ue009"];
	[v addObject:@"\ue10f"];
	[v addObject:@"\ue114"];
	[v addObject:@"\ue103"];
	[v addObject:@"\ue12f"];
	[v addObject:@"\ue311"];
	[v addObject:@"\ue42b"];
	[v addObject:@"\ue42a"];
	[v addObject:@"\ue018"];
	[v addObject:@"\ue016"];
	[v addObject:@"\ue015"];
	[v addObject:@"\ue014"];
	[v addObject:@"\ue42c"];
	[v addObject:@"\ue013"];
	[v addObject:@"\ue20e"];
	[v addObject:@"\ue045"];
	[v addObject:@"\ue047"];
	[v addObject:@"\ue044"];
	[v addObject:@"\ue043"];
	[v addObject:@"\ue036"];
	[v addObject:@"\ue01d"];
	[v addObject:@"\ue01b"];
	[v addObject:@"\ue154"];
	[v addObject:@"\ue132"];
	[v addObject:@"\ue21c"];
	[v addObject:@"\ue21d"];
	[v addObject:@"\ue21e"];
	[v addObject:@"\ue21f"];
	[v addObject:@"\ue220"];
	[v addObject:@"\ue221"];
	[v addObject:@"\ue222"];
	[v addObject:@"\ue223"];
	[v addObject:@"\ue224"];
	[v addObject:@"\ue225"];
	[v addObject:@"\ue210"];
	[v addObject:@"\ue24d"];
	[v addObject:@"\ue214"];
	[v addObject:@"\ue507"];
	[v addObject:@"\ue203"];
	[v addObject:@"\ue20b"];
	[v addObject:@"\ue02f"];
	[v addObject:@"\ue024"];
	[v addObject:@"\ue025"];
	[v addObject:@"\ue026"];
	[v addObject:@"\ue027"];
	[v addObject:@"\ue028"];
	[v addObject:@"\ue029"];
	[v addObject:@"\ue02a"];
	[v addObject:@"\ue02b"];
	[v addObject:@"\ue02c"];
	[v addObject:@"\ue02d"];
	[v addObject:@"\ue02e"];
	
	return v;
}


// return a new autoreleased UUID string
+(NSString *) getUUIDString
{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString *uuidString = (NSString*)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    
    // transfer ownership of the string
    // to the autorelease pool
    [uuidString autorelease];
    
    // release the UUID
    CFRelease(uuid);
    
    return uuidString;
}

+(NSMutableDictionary *) getDictionaryFromObject:(id) object
{
	unsigned int columnCount;
	Ivar *vars = class_copyIvarList([object class], &columnCount);
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSString *stringType = [NSString stringWithFormat:@"%@%@NSString%@",@"@",@"\"",@"\""];
	//NSString *floatType = [NSString stringWithFormat:@"%@%CGFloat%@",@"@",@"\"",@"\""];
    
    for (int i = 0; i < columnCount; i++) 
    {
		Ivar var = vars[i];
        
		NSString *columnName = [NSString stringWithUTF8String: ivar_getName(var)];
        NSLog(@"columnName : %@",columnName);
        NSString *columnType = [NSString stringWithUTF8String: ivar_getTypeEncoding(var)];
        NSLog(@"columnType : %@",columnType);
        
        if ([columnType isEqualToString:stringType] || [columnType isEqualToString:@"f"]) 
        {
            id value = [object valueForKey:columnName];
            if (value != nil) 
            {
                [dic setObject: value forKey: columnName];
            }
        }
	}
	free(vars);
	return dic;
}

+ (BOOL) isNetConnected 
{
	//return NO; // force for offline testing
	Reachability *hostReach = [Reachability reachabilityForInternetConnection];	
	NetworkStatus netStatus = [hostReach currentReachabilityStatus];	
	return !(netStatus == NotReachable);
}

+(BOOL) isEmail:(NSString *) string
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:string];
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

/*车牌号验证 MODIFIED BY HELENSONG*/
+(BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

/*验证是否为浮点型*/
+(BOOL)validateFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+(NSString *) dealSpecialCharacter:(NSString *)content{
    
    NSString *getContent = content;
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&ldquo;"
                                                       withString:@"\""];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&rdquo;"
                                                       withString:@"\""];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&oline;"
                                                       withString:@"‾"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&larr;"
                                                       withString:@"←"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&uarr;"
                                                       withString:@"↑"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&rarr;"
                                                       withString:@"→"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&darr;"
                                                       withString:@"↓"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&frasl;"
                                                       withString:@"/"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&hellip;"
                                                       withString:@"…"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&ndash;"
                                                       withString:@"–"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&dagger;"
                                                       withString:@"†"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&lsquo;"
                                                       withString:@"‘"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&rsquo;"
                                                       withString:@"’"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&sbquo;"
                                                       withString:@"‚"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&ldquo;"
                                                       withString:@"“"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&rdquo;"
                                                       withString:@"”"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&bdquo;"
                                                       withString:@"„"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&lsaquo;"
                                                       withString:@"‹"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&rsaquo;"
                                                       withString:@"›"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&middot;"
                                                       withString:@"."];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&mdash;"
                                                       withString:@"—"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&quot;"
                                                       withString:@"\""];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&amp;"
                                                       withString:@"&"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&lt;"
                                                       withString:@"<"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&gt;"
                                                       withString:@">"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&copy;"
                                                       withString:@"©"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&laquo;"
                                                       withString:@"«"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&raquo;"
                                                       withString:@"»"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&reg;"
                                                       withString:@"®"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&acute;"
                                                       withString:@"´"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&yen;"
                                                       withString:@"¥"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&euro;"
                                                       withString:@"€"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&permil;"
                                                       withString:@"‰"];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&nbsp;"
                                                       withString:@" "];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&emsp;"
                                                       withString:@" "];
    getContent = [getContent stringByReplacingOccurrencesOfString:@"&ensp;"
                                                       withString:@" "];
    
    return getContent;
}


//消息弹出提示
void showMessage(id formatstring)
{
    UIAlertView *Point = [[[UIAlertView alloc] initWithTitle:nil message:formatstring delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
    [Point show];
}

+(void) showDialogMessage:(NSString *) content{
    UIAlertView *Point = [[[UIAlertView alloc] initWithTitle:nil message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
    [Point show];
}


+ (NSString *)sha1:(NSString *)str {
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+ (NSString *)md5Hash:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    NSString *md5Result = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5Result;
}




@end
