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
#import "UIImageView+WebCache.h"

#define VIEWSIZE [UIScreen mainScreen].bounds.size
CGFloat const TimeInterval = 5.0f;
CGFloat const ImageHeigth = 300;
IB_DESIGNABLE
@interface topStorysView ()<UIScrollViewDelegate>

@property(nonatomic,copy)NSArray<StoryModel* > *topStorys;
//@property(nonatomic,strong)UIView *leftView;
//@property(nonatomic,strong)UIView *rigthView;
//@property(nonatomic,strong)UIView *centreView;
@property (nonatomic,strong)UIPageControl *pageView;
@property(nonatomic,assign)NSInteger numberOfPage;
//@property (nonatomic,strong)NSMutableArray<UIView *> *StoryViews;
@property(nonatomic,strong)NSMutableArray<UIImageView*> *images;/**<<#text#> */
@property (nonatomic,strong)NSMutableArray<UILabel *> *titles;
@property(nonatomic,strong)NSTimer *timer;/**<<#text#> */

@end


@implementation topStorysView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _StoryViews = [NSMutableArray array];
        _images = [NSMutableArray array];
        _titles = [NSMutableArray array];
        self.scrollView.contentSize = CGSizeMake(VIEWSIZE.width*3, 0);
        self.scrollView.pagingEnabled = YES;


    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _images = [NSMutableArray array];
    _titles = [NSMutableArray array];
    self.scrollView.contentSize = CGSizeMake(VIEWSIZE.width*3, 0);
    self.scrollView.pagingEnabled = YES;

    
}

-(UIScrollView *)createScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.pagingEnabled =YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(VIEWSIZE.width*3, 0);
    _scrollView.delegate = self;
    _numberOfPage = 0;
    for (int i=0; i<self.topStorys.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*VIEWSIZE.width, 0, VIEWSIZE.width, ImageHeigth)];
        [self.images addObject:imageView];
        imageView.image = [UIImage imageNamed:@"bizhi.jpg"];
        [self.scrollView addSubview:imageView];

        UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, VIEWSIZE.width-20, 30)];
        title.numberOfLines = 0;
        title.center = CGPointMake(VIEWSIZE.width/2 + i*VIEWSIZE.width, self.h - 60);
        [self.titles addObject:title];
        [self.scrollView addSubview:title];
    }
    return _scrollView;
}


- (void)updateFrame{
    self.scrollView.frame = self.bounds;
    NSInteger index = 0;
    for (UILabel *title in self.titles) {
        title.center = CGPointMake(VIEWSIZE.width/2 +index*VIEWSIZE.width, self.h-60);
        index++;
    }
    self.pageView.center = CGPointMake(VIEWSIZE.width/2, self.h-20);
}

-(void)CreateData:(NSArray<StoryModel *> *)datas{
    self.topStorys = datas;
    [self addSubview:[self createScrollView]];
    [self addSubview:[self createPageControl]];
    [self createFistData];
    [self createTimer];
}

- (void)createFistData{
    NSInteger number = self.numberOfPage;
    NSInteger count = self.topStorys.count;
    [self setdataWithPageNumber:0 andDataNumber:(number+self.topStorys.count-1)%count];
    [self setdataWithPageNumber:1 andDataNumber:number%count];
    [self setdataWithPageNumber:2 andDataNumber:(number+1)%count];
    [self.scrollView setContentOffset:CGPointMake(VIEWSIZE.width, 0) animated:NO];

}
- (UIPageControl*)createPageControl{
    _pageView = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    _pageView.numberOfPages = self.topStorys.count;
    _pageView.center = CGPointMake(VIEWSIZE.width/2, self.h-20);
    return _pageView;
}

- (void)createTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(slideNextPageScrollView) userInfo:nil repeats:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        self.numberOfPage +=self.topStorys.count-1;
        self.numberOfPage = self.numberOfPage%self.topStorys.count;
    }else if(scrollView.contentOffset.x == 2*VIEWSIZE.width){
        self.numberOfPage += 1;
    }else{
        return;
    }
    [self updateDataWithPageNumber:self.numberOfPage andIsAnimated:NO];
}

- (void)updateDataWithPageNumber:(NSInteger)number andIsAnimated:(BOOL)isAnmated{
    NSInteger count = self.topStorys.count;
    [self setdataWithPageNumber:0 andDataNumber:(number+self.topStorys.count-1)%count];
    [self setdataWithPageNumber:1 andDataNumber:number%count];
    [self setdataWithPageNumber:2 andDataNumber:(number+1)%count];
    [self.scrollView setContentOffset:CGPointMake(VIEWSIZE.width, 0) animated:isAnmated];
    self.pageView.currentPage = self.numberOfPage%self.topStorys.count;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self createTimer];
}

- (void)setdataWithPageNumber:(NSInteger)number andDataNumber:(NSInteger)dataNumber{
    [self.images[number] sd_setImageWithURL:[NSURL URLWithString:self.topStorys[dataNumber].image]];
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:self.topStorys[dataNumber].title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    CGSize size =  [attStr boundingRectWithSize:CGSizeMake(VIEWSIZE.width-30, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    self.titles[number].attributedText =attStr;
    CGRect rect = self.titles[number].frame;
    rect.size = size;
    self.titles[number].frame = rect;
}
- (void)slideNextPageScrollView{

    self.numberOfPage ++;
//    [self.scrollView setContentOffset:CGPointMake(2*VIEWSIZE.width, 0) animated:YES];
    [UIView animateWithDuration:1.0 animations:^{
        [self.scrollView setContentOffset:CGPointMake(2*VIEWSIZE.width, 0)];
    } completion:^(BOOL finished) {
        [self updateDataWithPageNumber:self.numberOfPage andIsAnimated:NO];
    }];

}

@end
