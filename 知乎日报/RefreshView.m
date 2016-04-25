//
//  RefreshView.m
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "RefreshView.h"
#import "UIView+JZ.h"


@interface RefreshView ()

@property(nonatomic,strong)UIActivityIndicatorView *IndicatorView;
@property(nonatomic,strong)CAShapeLayer *animateLayer;

@end
@implementation RefreshView

- (CAShapeLayer *)animateLayer{
    if (!_animateLayer) {
        CGFloat radius = MIN(self.w, self.h)/2-3;
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.w/2-radius, self.h/2-radius, 2*radius, 2*radius)];
        _animateLayer = [[CAShapeLayer alloc]init];
        _animateLayer.path = path.CGPath;
        _animateLayer.strokeEnd = 0;
        _animateLayer.opacity =0.f;
        _animateLayer.lineWidth = 1.0f;
        _animateLayer.strokeColor = [UIColor whiteColor].CGColor;
        _animateLayer.fillColor = nil;
    }
    return _animateLayer;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.layer addSublayer:self.animateLayer];
    _IndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:self.bounds];
    [self addSubview:_IndicatorView];

}
- (void)changeStatusWith:(CGFloat)progress{
    self.animateLayer.strokeEnd = progress;
    self.animateLayer.opacity = progress;
}

- (void)startAnimating{
    self.animateLayer.strokeEnd = 0;
    self.animateLayer.opacity = 0;
    [self.IndicatorView startAnimating];
}

- (void)stopAnimating{
    [self.IndicatorView stopAnimating];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
