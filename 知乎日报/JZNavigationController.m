//
//  JZNavigationController.m
//  知乎日报
//
//  Created by Jz on 16/4/17.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "JZNavigationController.h"

@interface JZNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    // 自定义滑动手势添加到self.view 调用系统原来的滑动返回方法
    // 即self.interactivePopGestureRecognizer.delegate的handleNavigationTransition:方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}
#pragma mark - 手势代理方法
// 是否开始触发手势，如果是根控制器就不触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 判断下当前控制器是否是根控制器
    return (self.topViewController != [self.viewControllers firstObject]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
