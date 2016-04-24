//
//  JZNewsViewController.m
//  知乎日报
//
//  Created by Jz on 16/4/16.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "JZNewsViewController.h"
#import "RequestTool.h"
#import "newsModel.h"
#import "UIView+JZ.h"
#import "NewsHeadView.h"
#import <WebKit/WebKit.h>
#import "NewsViewModel.h"

#define NEWSVIEWWITH  [UIScreen mainScreen].bounds.size.width
#define NEWSVIEWHEIGHT  [UIScreen mainScreen].bounds.size.height
const CGFloat headViewHeigth = 320;
const CGFloat headViewY = -100;
@interface JZNewsViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)  UIWebView *newsWebView;/**< 内容 */
@property(nonatomic, strong)NewsHeadView *headView;/**<<#text#> */
@property (nonatomic, strong)NewsViewModel *ViewModel;
@property (nonatomic, assign, getter=isLight)BOOL Light;
@end

@implementation JZNewsViewController



#pragma mark - 生命周期

- (instancetype)initWithNewsViewModel:(NewsViewModel *)newsViewModle{
    self = [super init];
    if (self) {
        self.ViewModel = newsViewModle;
        [self.ViewModel addObserver:self forKeyPath:@"newsModel" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self instanceWebView];
    [self instanceHeadView];


    
}

- (void)transitionAnimationIsNext:(BOOL)isNest{
    CGFloat y = isNest?NEWSVIEWHEIGHT: -NEWSVIEWHEIGHT;
    UIView *temp = [self.view snapshotViewAfterScreenUpdates:NO];
    temp.frame = self.view.bounds;
    if (![self.ViewModel getStroyContentWithBeforeStroy]) {
        return;
    } ;
    [[UIApplication sharedApplication].windows.lastObject addSubview:temp];
    self.view.transform = CGAffineTransformMakeTranslation(0,y);
    [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:2.0f options:0 animations:^{
        self.view.transform = CGAffineTransformIdentity;
        temp.transform = CGAffineTransformMakeTranslation(0, -y);

    } completion:^(BOOL finished) {
        [temp removeFromSuperview];
    }];

}

#pragma mark - 自定方法




#pragma mark - 初始化界面
- (void)instanceWebView{
    _newsWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, NEWSVIEWWITH,NEWSVIEWHEIGHT)];
    _newsWebView.scrollView.delegate = self;
    [self.view addSubview:_newsWebView];
    _newsWebView.backgroundColor = [UIColor whiteColor];
    
}

- (void)instanceHeadView{
    _headView = [[NewsHeadView alloc]initWithFrame:CGRectMake(0, headViewY, NEWSVIEWWITH, headViewHeigth)];
    [self.view addSubview:_headView];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    if (self.isLight) {
        return UIStatusBarStyleLightContent;
    }else{
        return UIStatusBarStyleDefault;
    }
}

#pragma mark - scrollView代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y<headViewY) {
        scrollView.contentOffset = CGPointMake(0, headViewY);
    }else if (y<headViewHeigth+headViewY-20&&y>headViewY){
        [self.headView setY:(headViewY -y/2)];
        [self.headView setH:(headViewHeigth -y/2)];
        [self.headView layoutIfNeeded];
    }
    if (y>(headViewHeigth+headViewY-20)){
        self.Light = NO;
        [self preferredStatusBarStyle];
        [self.headView setY:(headViewY -headViewHeigth+headViewY+20)];
        [self.headView setH:0];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [self preferredStatusBarStyle];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"scrollView.contentOffset.y%f",y);
    NSLog(@"scrollView.contentSize.height%f",scrollView.contentSize.height-headViewHeigth-200);
    if (y<headViewY+20) {
        [self transitionAnimationIsNext:NO];
    }else if((scrollView.contentOffset.y + scrollView.frame.size.height)>(scrollView.contentSize.height)){
        [self transitionAnimationIsNext:YES];
    }

}


 #pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString: @"newsModel"]) {
        [self.newsWebView loadHTMLString:self.ViewModel.htmlBody baseURL:nil];
        [self.headView setDataWithModel:self.ViewModel];
    }
}

- (void)dealloc{
    [self.ViewModel removeObserver:self forKeyPath:@"newsModel"];
}


@end
