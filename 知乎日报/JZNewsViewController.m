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

#define NEWSVIEWWITH  [UIScreen mainScreen].bounds.size.width
#define NEWSVIEWHEIGHT  [UIScreen mainScreen].bounds.size.height
const CGFloat headViewHeigth = 320;
const CGFloat headViewY = -100;
@interface JZNewsViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)  UIWebView *newsWebView;/**< 内容 */
@property(nonatomic, strong)NewsHeadView *headView;/**<<#text#> */
@property (nonatomic, strong)newsModel *model;
@property (nonatomic, assign, getter=isLight)BOOL Light;
@end

@implementation JZNewsViewController



#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    self.Light = YES;
//    [self preferredStatusBarStyle];
//    self.navigationController.navigationBarHidden = NO;
//    [self.view addSubview:_newsView];
    // Do any additional setup after loading the view.
    
}



#pragma mark - 自定方法

- (void)setStroyId:(NSNumber *)stroyId{
    _stroyId = stroyId;
    [self instanceWebView];
    [self instanceHeadView];
    [[RequestTool shardRequest]getNewWithNewId:_stroyId AndSuccess:^(id requestData) {
        self.model = [[newsModel alloc]initWithDict:requestData];
        [self.newsWebView loadHTMLString:[self.model htmlBody] baseURL:nil];
        [self.headView setDataWithModel:self.model];
    } andFail:^(NSError *error) {
        
    }];
}




#pragma mark - 初始化界面
- (void)instanceWebView{
    _newsWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, NEWSVIEWWITH,NEWSVIEWHEIGHT)];
    _newsWebView.scrollView.delegate = self;
    [self.view addSubview:_newsWebView];
    
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
//        [self.newsWebView setY:20 -y/2];
    }
    if (y>(headViewHeigth+headViewY-20)){
        self.Light = NO;
        [self preferredStatusBarStyle];
        [self.headView setY:(headViewY -headViewHeigth+headViewY+20)];
        [self.headView setH:0];
//        [self.newsWebView setY:20];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [self preferredStatusBarStyle];

    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        [self.newsWebView setY:0];

    }
}
- (void)dealloc{
    NSLog(@"JZNewsViewController 销毁");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
