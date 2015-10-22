//
//  UIImage+Extras.m
//  BMW
//
//  Created by penghui on 11-11-28.
//  Copyright 2011 #. All rights reserved.
//

#import "UIImage+Extras.h"


@implementation UIImage (Effect)

CGImageRef Brightness(UIImage* aInputImage, float aFactor)
{
    CGImageRef img=aInputImage.CGImage;
	
    CFDataRef dataref=CGDataProviderCopyData(CGImageGetDataProvider(aInputImage.CGImage));
	
    int length=CFDataGetLength(dataref);
    UInt8 *data=(UInt8 *)CFDataGetBytePtr(dataref);
	
    // Perform operation on pixels
    for(int index=0;index<length;index+=4)
    {
        // Go For BRIGHTNESS
        for(int i=0;i<3;i++)
        {
            if(data[index+i]+aFactor<0)
            {
                data[index+i]=0;
            }
            else
            {
                if(data[index+i]+aFactor>255)
                {
                    data[index+i]=255;
                }
                else
                {
                    data[index+i]+=aFactor;
                }
            }
        }
    }
	
    // .. Take image attributes
    size_t width=CGImageGetWidth(img);
    size_t height=CGImageGetHeight(img);
    size_t bitsPerComponent=CGImageGetBitsPerComponent(img);
    size_t bitsPerPixel=CGImageGetBitsPerPixel(img);
    size_t bytesPerRow=CGImageGetBytesPerRow(img);
	
    // .. Do the pixel manupulation
    CGColorSpaceRef colorspace=CGImageGetColorSpace(img);
    CGBitmapInfo bitmapInfo=CGImageGetBitmapInfo(img);
    CFDataRef newData=CFDataCreate(NULL,data,length);
    CGDataProviderRef provider=CGDataProviderCreateWithCFData(newData);
	
    // .. Get the Image out of this raw data
    CGImageRef newImg=CGImageCreate(width,height,bitsPerComponent,bitsPerPixel,bytesPerRow,colorspace,bitmapInfo,provider,NULL,true,kCGRenderingIntentDefault);
	
    // .. Prepare the image from raw data
    UIImage* rawImage = [[[UIImage alloc] initWithCGImage:newImg] autorelease];
	
    // .. done with all,so release the references
    CFRelease(newData);
    CGImageRelease(newImg);
    CGDataProviderRelease(provider);
    CFRelease(dataref);
	
    return rawImage.CGImage;
}


static CGImageRef CreateMask(CGSize size, NSUInteger thickness)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                       size.width,
                                                       size.height,
                                                       8,
                                                       size.width * 32,
                                                       colorSpace,
                                                       kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    if (bitmapContext == NULL) 
    {
        NSLog(@"create mask bitmap context failed");
		return nil;
    }
    
    // fill the black color in whole size, anything in black area will be transparent.
    CGContextSetFillColorWithColor(bitmapContext, [UIColor blackColor].CGColor);
    CGContextFillRect(bitmapContext, CGRectMake(0, 0, size.width, size.height));
    
    // fill the white color in whole size, anything in white area will keep.
    CGContextSetFillColorWithColor(bitmapContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(bitmapContext, CGRectMake(thickness, thickness, size.width - thickness * 2, size.height - thickness * 2));
    
    // acquire the mask
    CGImageRef maskImageRef = CGBitmapContextCreateImage(bitmapContext);
    
    // clean up
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    
    return maskImageRef;
}

- (UIImage *)imageWithColoredBorder:(NSUInteger)borderThickness borderColor:(UIColor *)color withShadow:(BOOL)withShadow
{
    size_t shadowThickness = 0;
    if (withShadow) 
    {
        shadowThickness = 2;
    }
    
    size_t newWidth = self.size.width + 2 * borderThickness + 2 * shadowThickness;
    size_t newHeight = self.size.height + 2 * borderThickness + 2 * shadowThickness;
    CGRect imageRect = CGRectMake(borderThickness + shadowThickness, borderThickness + shadowThickness, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextSetShadow(ctx, CGSizeZero, 4.5f);
    [color setFill];
    CGContextFillRect(ctx, CGRectMake(shadowThickness, shadowThickness, newWidth - 2 * shadowThickness, newHeight - 2 * shadowThickness));
    CGContextRestoreGState(ctx);
    [self drawInRect:imageRect];
    //CGContextDrawImage(ctx, imageRect, self.CGImage); //if use this method, image will be filp vertically
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    return img;
}

- (UIImage *)imageWithTransparentBorder:(NSUInteger)thickness
{      
    size_t newWidth = self.size.width + 2 * thickness;
    size_t newHeight = self.size.height + 2 * thickness;
    
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = bitsPerPixel * newWidth;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();    
    if(colorSpace == NULL) 
    {
		NSLog(@"create color space failed");
		return nil;
	}
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                       newWidth,
                                                       newHeight,
                                                       bitsPerComponent,
                                                       bytesPerRow,
                                                       colorSpace,
                                                       kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    if (bitmapContext == NULL) 
    {
        NSLog(@"create bitmap context failed");
		return nil;
    }
    
    // acquire image with opaque border 
    CGRect imageRect = CGRectMake(thickness, thickness, self.size.width, self.size.height);
    CGContextDrawImage(bitmapContext, imageRect, self.CGImage);
    CGImageRef opaqueBorderImageRef = CGBitmapContextCreateImage(bitmapContext);
    
    // acquire image with transparent border 
    CGImageRef maskImageRef = CreateMask(CGSizeMake(newWidth, newHeight), thickness);
    CGImageRef transparentBorderImageRef = CGImageCreateWithMask(opaqueBorderImageRef, maskImageRef);
    UIImage *transparentBorderImage = [UIImage imageWithCGImage:transparentBorderImageRef];
    
    // clean up
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(bitmapContext);
    CGImageRelease(opaqueBorderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

@end

@implementation UIImage (Load)

+ (UIImage *) imageWithContentsOfResolutionIndependentFile:(NSString *) path 
{
    return [[[UIImage alloc] initWithContentsOfResolutionIndependentFile:path] autorelease];
}

- (id) initWithContentsOfResolutionIndependentFile:(NSString *) path 
{
    if ( [[[UIDevice currentDevice] systemVersion] intValue] >= 4 && [[UIScreen mainScreen] scale] == 2.0 ) 
	{
        NSString *path2x = [[path stringByDeletingLastPathComponent] 
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.%@", 
                                                            [[path lastPathComponent] stringByDeletingPathExtension], 
                                                            [path pathExtension]]];
        
        if ( [[NSFileManager defaultManager] fileExistsAtPath:path2x] ) 
		{
            return [self initWithCGImage:[[UIImage imageWithData:[NSData dataWithContentsOfFile:path2x]] CGImage] scale:2.0 orientation:UIImageOrientationUp];
        }
    }
    
    return [self initWithData:[NSData dataWithContentsOfFile:path]];
}

@end


@implementation UIImage (Resize)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;      
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }      
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
