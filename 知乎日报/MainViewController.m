//
//  MainViewController.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "ContentViewController.h"
#import "SectionTitleView.h"


#define VIEWWITH [UIScreen mainScreen].bounds.size.width
#define LEFTMENUWITH VIEWWITH*3/5.0
static CGFloat const animateTime = 0.3;
static CGFloat const deviation = 70;
static BOOL isShow = NO;

typedef NS_ENUM(NSUInteger, MenuState)
{
    MenuStateClosed = 0,
    MenuStateOpening,
    MenurStateOpen,
    MenuStateClosing
};

@interface MainViewController ()<LeftMenuViewControllerDelege>
@property (nonatomic, weak)UIView *menuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuLeading;
@property (nonatomic, weak)UIView *contentView;
@property (nonatomic, assign)MenuState menuState;
@property (nonatomic, strong)UIGestureRecognizer *tap;
@property (nonatomic,strong)UIView *markView;
@end

@implementation MainViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(UIView *)markView{
    if (!_markView) {
        _markView = [[UIView alloc]initWithFrame:self.contentView.bounds];
        _markView.backgroundColor = [UIColor blackColor];
        _markView.alpha = 0.3;
    }
    return _markView;
}

- (UIGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMenu)];
    }
    return _tap;
}
#pragma mark 生命周期
- (void)viewDidLoad{
    self.navigationController.navigationBarHidden = YES;
    [self setUpGestureRecognizer];
    self.menuLeading.constant = -LEFTMENUWITH;
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"LeftMenuViewController"]) {
        LeftMenuViewController *vc = segue.destinationViewController;
        vc.delege = self;
        _menuView = vc.view;
    }
    else if ([segue.identifier isEqualToString:@"ContentViewController"]){
        ContentViewController *vc = segue.destinationViewController;
        _contentView = vc.view;
    }
}



- (IBAction)showLeftMenu:(id)sender {
    isShow?[self hideMenu]:[self showMenu];
}


#pragma mark 初始化
- (void)setUpGestureRecognizer{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.contentView addGestureRecognizer:pan];
}
#pragma mark 自定义方法
/**
 *  手势交互滑动
 */
- (void)handlePan:(UIPanGestureRecognizer *)Recoginizer{
    static CGFloat startX;
    CGFloat location = [Recoginizer translationInView:self.contentView].x;

    switch (Recoginizer.state) {
        case UIGestureRecognizerStateBegan:
            startX = location;
            if (self.menuState == MenuStateClosed) {
                self.menuState = MenuStateOpening;
            }else{
                self.menuState = MenuStateClosing;
            }
            break;
        case UIGestureRecognizerStateChanged:
            if (location - startX > 0 && self.menuState== MenuStateOpening) {
                self.menuLeading.constant = location - startX < LEFTMENUWITH?((-LEFTMENUWITH)+(location - startX)>LEFTMENUWITH?0:(-LEFTMENUWITH)+(location - startX)):0;/**< 距离等于最小的位置x + (现在位置-开始位置) */
                self.menuState = MenuStateOpening;
            }else if(self.menuState == MenuStateClosing && location - startX <0){
                self.menuLeading.constant = startX - location<LEFTMENUWITH?-(startX - location):-LEFTMENUWITH;
                self.menuState = MenuStateClosing;
            }
            [self.view layoutIfNeeded];
            break;
        case UIGestureRecognizerStateEnded:
            if (self.menuState == MenuStateOpening) {
                self.menuLeading.constant = self.menuLeading.constant>-LEFTMENUWITH+deviation?0:-LEFTMENUWITH;

            }else{
                self.menuLeading.constant = self.menuLeading.constant<-deviation?-LEFTMENUWITH:0;
            }
            if (true) {
                self.menuState = self.menuLeading.constant<-50?MenuStateClosed:MenurStateOpen;
                [UIView animateWithDuration:animateTime animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
//            if(self.menuState == MenurStateOpen || self.menuState == MenuStateClosed){
                self.menuState==MenurStateOpen?[self menuOpen]:[self menuClose];
//            }
            break;
        default:
            break;
    }
    
    
}

-(void)menuOpen{
//   [self.contentView addSubview:[[UIView alloc]initWithFrame:self.contentView.bounds]];
    [self.contentView addSubview:self.markView];
    [self.markView addGestureRecognizer:self.tap];

}
- (void)menuClose{
////    [self.contentView removeGestureRecognizer:self.tap];
    [self.markView removeGestureRecognizer:self.tap];
    [self.markView removeFromSuperview];
}
#pragma mark 导航代理
-(void)showMenu{
    self.menuLeading.constant = isShow?-LEFTMENUWITH:0;
    [UIView animateWithDuration:animateTime animations:^{
        [self.view layoutIfNeeded];

    } completion:^(BOOL finished) {
        [self menuOpen];
        isShow = !isShow;

    }];
    NSLog(@"%d",isShow);
}

-(void)hideMenu{
    self.menuLeading.constant = -LEFTMENUWITH;
    [UIView animateWithDuration:animateTime animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self menuClose];
        isShow = !isShow;
    }];
}
/**
 *  选择模块跳转
 */
-(void)selectNumberof:(NSInteger)number{
    
}
@end
