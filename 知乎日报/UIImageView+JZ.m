//
//  UIImageView+JZ.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "UIImageView+JZ.h"

@implementation UIImageView (JZ)
-(UIImageView *)setRound:(CGFloat) round{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:round].CGPath);
    CGContextClip(context);
    [self.image drawInRect:self.bounds];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    self.image = image;
    UIGraphicsEndImageContext();
    return self;
}

@end
