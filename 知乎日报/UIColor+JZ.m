//
//  UIColor+JZ.m
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "UIColor+JZ.h"


@implementation UIColor (JZ)
+ (instancetype)colorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue{
    return [self colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}
+ (instancetype)colorWithNavLight{
    return [self colorWithRed:37 Green:144 Blue:217];
}
+ (instancetype)colorWithNavDark{
    return [self colorWithRed:69 Green:66 Blue:70];
}

+ (instancetype)colorWithbackgroudDark{
    return [self colorWithRed:53 Green:51 Blue:54];
}
+ (instancetype)colorWithbackgroudLight{
    return [self colorWithRed:255 Green:255 Blue:255];
}
+ (instancetype)colorWithFontDark{
    return [self colorWithRed:178 Green:171 Blue:178];
}
@end
