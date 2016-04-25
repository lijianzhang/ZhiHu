//
//  UIView+JZ.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "UIView+JZ.h"

@implementation UIView (JZ)
- (CGFloat)x{
    return self.frame.origin.x;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (CGFloat)h{
    return self.frame.size.height;
}
- (CGFloat)w{
    return self.frame.size.width;
}

- (void)setX:(CGFloat)X{
    self.frame = CGRectMake(X, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)setY:(CGFloat)Y{
    self.frame = CGRectMake(self.frame.origin.x, Y, self.frame.size.width, self.frame.size.height);
}
- (void)setW:(CGFloat)W{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, W, self.frame.size.height);
}
- (void)setH:(CGFloat)H{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, H);
}
@end
