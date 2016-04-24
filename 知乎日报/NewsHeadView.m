//
//  NewsHeadView.m
//  知乎日报
//
//  Created by Jz on 16/4/16.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "NewsHeadView.h"
#import "UIImageView+WebCache.h"
#import "NewsViewModel.h"

@interface NewsHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *source;


@end

@implementation NewsHeadView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        UIView *view = [[NSBundle mainBundle]loadNibNamed:className owner:self options:nil].firstObject;
        [self addSubview:view];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        UIView *view = [[NSBundle mainBundle]loadNibNamed:className owner:self options:nil].firstObject;
        view.frame = self.bounds;
        [self addSubview:view];
    }
    return self;
}

- (void)setDataWithModel:(NewsViewModel *)model{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.newsImage]];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title.text = model.newsTitle;
        self.source.text = model.newsImageSource;
        [self layoutIfNeeded];
    });

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
