//
//  SectionTitleView.m
//  知乎日报
//
//  Created by Jz on 16/4/10.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "SectionTitleView.h"

@implementation SectionTitleView

- (void)layoutSubviews{
    [super layoutSubviews];
    CGPoint point = self.textLabel.center;
    point.x = self.frame.size.width/2;
    self.textLabel.center = point;
}

@end
