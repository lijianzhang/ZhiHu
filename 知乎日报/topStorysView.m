//
//  topStorysView.m
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "topStorysView.h"
#import "StoryModel.h"
#import "UIView+JZ.h"
#import "UIColor+JZ.h"

#define VIEWSIZE [UIScreen mainScreen].bounds.size
CGFloat const TimeInterval = 5.0f;

IB_DESIGNABLE
@interface topStorysView ()

@property(nonatomic,copy)NSArray<StoryModel* > *topStorys;
//@property(nonatomic,strong)UIView *leftView;
//@property(nonatomic,strong)UIView *rigthView;
//@property(nonatomic,strong)UIView *centreView;
@property (nonatomic,strong)UIPageControl *pageView;
@property(nonatomic,assign)NSInteger numberOfPage;
@property (nonatomic,strong)NSMutableArray<UIView *> *StoryViews;
@property(nonatomic,strong)NSTimer *timer;/**<<#text#> */

@end


@implementation topStorysView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _StoryViews = [NSMutableArray array];
        self.contentSize = CGSizeMake(VIEWSIZE.width*3, 0);
        self.pagingEnabled = YES;
        [self addAllChildView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _StoryViews = [NSMutableArray array];
    self.contentSize = CGSizeMake(VIEWSIZE.width*3, 0);
    self.pagingEnabled = YES;
    [self addAllChildView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];

}


-(void)addAllChildView{
    
    for (int i=0; i<3; i++) {
        [self initWithStoryViewWithNumber:i];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:TimeInterval target:self selector:@selector(slideNextPageScrollView) userInfo:nil repeats:YES];
    
}

- (void)initWithStoryViewWithNumber:(NSInteger)number{
    UIView *storyView = [[UIView alloc]initWithFrame:CGRectMake(number*VIEWSIZE.width, 0, VIEWSIZE.width, 300)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:storyView.bounds];
    imageView.image = [UIImage imageNamed:@"Account_Avatar"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [storyView addSubview:imageView];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, VIEWSIZE.width, 30)];
    title.center = CGPointMake(VIEWSIZE.width/2, self.h - 60);
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithFontDark];
    title.text =@"测试";
    [storyView addSubview:title];
    [_StoryViews addObject:storyView];
    [self addSubview:storyView];
}

//- (void)LoadImageData{
//    self.pageNumber = 0;
//    [self.images[0] sd_setImageWithURL:[NSURL URLWithString:self.ViewModel.topStorys.lastObject.image]];
//    [self.images[1] sd_setImageWithURL:[NSURL URLWithString:self.ViewModel.topStorys.firstObject.image]];
//    [self.images[2] sd_setImageWithURL:[NSURL URLWithString:self.ViewModel.topStorys[1].image]];
//    [self.pageScrollView setContentOffset:CGPointMake(VIEWWITH, 0)];
//    self.pageView.numberOfPages = self.ViewModel.topStorys.count;
//
//}

//-(void)updateImageData{
//    NSInteger count = self.ViewModel.topStorys.count;
//    CGFloat contentOffX = self.pageScrollView.contentOffset.x;
//    if (contentOffX == 0) {
//        self.pageNumber = (self.pageNumber+count-1)%count;
//
//    }else if(contentOffX == 2*VIEWWITH){
//
//         self.pageNumber = (self.pageNumber+1)%count;
//    }
//    self.pageView.currentPage = self.pageNumber;
//    [self.images[0] sd_setImageWithURL:[NSURL URLWithString:self.ViewModel.topStorys[(self.pageNumber+count-1)%count].image]];
//    [self.images[1] sd_setImageWithURL:[NSURL URLWithString:self.ViewModel.topStorys[(self.pageNumber)%count].image]];
//    [self.images[2] sd_setImageWithURL:[NSURL URLWithString:self.ViewModel.topStorys[(self.pageNumber+1)%count].image]];
//    [self.pageScrollView setContentOffset:CGPointMake(VIEWWITH, 0)];
//
//}

- (void)setImageWithNumber:(NSInteger)number andImageUrl:(NSString *)url{

}
- (void)slideNextPageScrollView{

    [self setContentOffset:CGPointMake(VIEWSIZE.width+self.contentOffset.x, 0) animated:YES];

}

@end
