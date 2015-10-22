//
//  JLSplash.m
//  JLSplashDemo
//
//  Created by Jayson Lane on 3/31/12.
//  Copyright (c) 2012 Jayson Lane.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this 
//  software and associated documentation files (the "Software"), to deal in the Software 
//  without restriction, including without limitation the rights to use, copy, modify, merge, 
//  publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
//  to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies 
//  or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
//  IN THE SOFTWARE.

    
#import <QuartzCore/QuartzCore.h>
#import "JLSplash.h"

@implementation JLSplash

- (id) init {
    
    self = [super init];
    
    if(self){
        
        [self setImage: [UIImage imageNamed:@"Default.jpg"]];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            //iPhone
            self.frame = CGRectMake(0, 0, 320, 480);
        } else {
            //iPad
            self.frame = CGRectMake(0, 0, 1024, 768);
        }
        
    }
 
    return self;
}

- (void) animationType: (int) animationType withDuration: (float) duration {
    
    switch(animationType){
            
        case 0:{         //Book Open
            
            [[self superview] bringSubviewToFront: self];
            
            //set anchorpoint
            self.layer.anchorPoint = CGPointMake(0, 0.5);
            
            //reset the image view frame
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                //iPhone
                self.frame = CGRectMake(0, 0, 320, 480);
            }
            
            [UIView animateWithDuration:duration
                            delay:0.6
                            options:(UIViewAnimationCurveEaseOut)
                             animations:^{
                                 self.layer.transform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 1, 0);
                             } completion:^(BOOL finished){
                                 //remove the imageview from the view
                                 [self removeFromSuperview];
                             }];
            break;
        }
        case 1:{         //Fade Out
            
            [[self superview] bringSubviewToFront: self];
            
            [UIView animateWithDuration:duration
                                  delay:0.6
                                options:(UIViewAnimationCurveEaseOut)
                             animations:^{
                                 self.layer.opacity = 0;
                             } completion:^(BOOL finished){
                                 //remove the imageview from the view
                                 [self removeFromSuperview];
                             }];
                        
            
            break;
        }
        case 2:{         //Size Up
            
            [[self superview] bringSubviewToFront: self];
            
            //set anchorpoint
            //self.layer.anchorPoint = CGPointMake(0, 0);
            
            [UIView animateWithDuration:duration
                                  delay:0.6
                                options:(UIViewAnimationCurveEaseOut)
                             animations:^{
                                 self.layer.transform = CATransform3DMakeScale(10, 10, 10);
                                 self.layer.opacity = 0;
                                
                                 
                             } completion:^(BOOL finished){
                                 //remove the imageview from the view
                                 [self removeFromSuperview];
                             }];            
            
            break;
        }
        default:{       //Fade Out
            
            [[self superview] bringSubviewToFront: self];
            
            [UIView animateWithDuration:duration
                                  delay:0.6
                                options:(UIViewAnimationCurveEaseOut)
                             animations:^{
                                 self.layer.opacity = 0;
                             } completion:^(BOOL finished){
                                 //remove the imageview from the view
                                 [self removeFromSuperview];
                             }];
            
            break;
        }
            
            
            
    }
    
    
    
}

@end
