//
//  ContentViewController.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "ContentViewController.h"
#import "UIColor+JZ.h"
#import "ContentViewModel.h"
#import "UIImageView+WebCache.h"
#import "StoryModel.h"
#import "topStorysView.h"
#import "UIView+JZ.h"

#define VIEWWITH [UIScreen mainScreen].bounds.size.width

@interface ContentViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (weak, nonatomic) IBOutlet UIView *navBar;
@property(nonatomic,strong)ContentViewModel *ViewModel;/**<<#text#> */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topStorysViewTop;
@property (weak, nonatomic) IBOutlet topStorysView *topStorysView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topStoryViewHeight;
@property(nonatomic,assign)NSInteger pageNumber;
@end

@implementation ContentViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    _ViewModel = [[ContentViewModel alloc] initWithDataLoadSuccess:^{
        dispatch_async(dispatch_get_main_queue(), ^{
             [self setUpWithView];
        });
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
}
- (void)setUpWithView{
    [self.contentTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    self.navBar.backgroundColor = [UIColor colorWithNavLight];
    self.navBar.alpha = 0;
    self.contentTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, VIEWWITH, 200.f)];

}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@",self.topStorysView.superview);
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat y = self.contentTableView.contentOffset.y;
        if (y<-50) {
            [self.contentTableView setContentOffset:CGPointMake(0, -50)];
        }else{
            self.topStorysViewTop.constant = -50 - y/2;
            self.topStoryViewHeight.constant = 250 - y/2;
        }
        self.navBar.alpha = y/50;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (void)dealloc{
    [self.contentTableView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
