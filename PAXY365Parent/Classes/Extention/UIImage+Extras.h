//
//  UIImage+Extras.h
//  BMW
//
//  Created by penghui on 11-11-28.
//  Copyright 2011 #. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Load)

+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path;

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;

@end



@interface UIImage (Resize)

-(UIImage *) imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end

@interface UIImage (Effect)

CGImageRef Brightness(UIImage* aInputImage, float aFactor);

- (UIImage *)imageWithColoredBorder:(NSUInteger)borderThickness borderColor:(UIColor *)color withShadow:(BOOL)withShadow;

- (UIImage *)imageWithTransparentBorder:(NSUInteger)thickness;

@end
