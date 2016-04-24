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
#import "ContentViewCell.h"
#import "RefreshView.h"
#import "SectionTitleView.h"
#import "JZNewsViewController.h"
#import "NewsViewModel.h"

#define VIEWWITH [UIScreen mainScreen].bounds.size.width
#define VIEWHEIGHT [UIScreen mainScreen].bounds.size.height

CGFloat const scrollImageHeigth = 400;
CGFloat const ScrollViewHeight =250;
CGFloat const ScrollViewTop = -50;
CGFloat const rowItemHeigth = 88;
@interface ContentViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (weak, nonatomic) IBOutlet UIView *navBar;
@property(nonatomic,strong)ContentViewModel *ViewModel;/**<<#text#> */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topStorysViewTop;
@property (weak, nonatomic) IBOutlet topStorysView *topStorysView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topStoryViewHeight;
@property (weak, nonatomic) IBOutlet RefreshView *refreshView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navbarHeight;
@property (weak, nonatomic) IBOutlet UILabel *homeTitle;
@property(nonatomic,assign)NSInteger pageNumber;
@end

@implementation ContentViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    _ViewModel = [[ContentViewModel alloc] initWithDataLoadSuccess:^{
        dispatch_async(dispatch_get_main_queue(), ^{
             [self setUpWithView];
            [self.contentTableView reloadData];
        });
    }];
    self.topStorysView.block = ^(NSInteger index){
        NewsViewModel *model = [[NewsViewModel alloc]initWithStroyID:self.ViewModel.topStorys[index].storyID];
        model.storyIDs = self.ViewModel.storyIDs;
        JZNewsViewController *vc = [[JZNewsViewController alloc]initWithNewsViewModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeColor) name:@"ThemeColorChange" object:nil];
    
}
- (void)viewWillAppear:(BOOL)animated{
}
- (void)setUpWithView{
    [self.contentTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    self.navBar.backgroundColor = [UIColor colorWithNav];
    self.navBar.alpha = 0;
    self.contentTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, VIEWWITH, ScrollViewHeight+ScrollViewTop)];
    [self.topStorysView CreateData:self.ViewModel.topStorys];
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.rowHeight = 88;
    [self.contentTableView registerClass:[SectionTitleView class] forHeaderFooterViewReuseIdentifier:@"SectionTitleView"];

}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat y = self.contentTableView.contentOffset.y;
        [self.view layoutIfNeeded];
        [self.refreshView changeStatusWith:(y/(-40.0))];
        if (self.contentTableView.contentOffset.y<-40.0&&!self.contentTableView.dragging) {
            [self.refreshView startAnimating];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.refreshView stopAnimating];
            });
        }
        if (y<ScrollViewTop) {
            [self.contentTableView setContentOffset:CGPointMake(0, ScrollViewTop)];
        }else{
            self.topStorysViewTop.constant = ScrollViewTop - y/2;
            self.topStoryViewHeight.constant = ScrollViewHeight - y/2;
        }

        self.navBar.alpha = y/ScrollViewHeight*2;
        [self.topStorysView updateFrame];
        if (y + rowItemHeigth > self.contentTableView.contentSize.height - [UIScreen mainScreen].bounds.size.height) {
            if (!self.ViewModel.isLoding) {
                [self.ViewModel getOldNewsWithSuccess:^{
                    dispatch_async(dispatch_get_main_queue(), ^{

                        [self.contentTableView reloadData];
                    });
                }];
            }
        }
    }
}

- (void)changeColor{
    [UIView animateWithDuration:0.3f animations:^{
        self.navBar.backgroundColor = [UIColor colorWithNav];
        [self abc:self.contentTableView];
    }];


}

-(void)abc:(UIView*)view{
    if ([view isKindOfClass:[UITableViewCell class]]) {
            view.backgroundColor = [UIColor colorWithbackgroud];
    }
    else if ([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        UITableViewHeaderFooterView *HeaderFooterView = (UITableViewHeaderFooterView *)view;
        HeaderFooterView.contentView.backgroundColor = [UIColor colorWithNav];
    }
    else if (view.subviews>0) {
        for (UIView* subView in view.subviews) {
            [self abc:subView];
        }
    }else return ;
    
}

#pragma mark uitableView代理


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.ViewModel.Storys.count;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ViewModel.Storys[section].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithbackgroud];
    [cell ShowDataWIthModel:self.ViewModel.Storys[indexPath.section][indexPath.row]];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [UIView new];
    }
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionTitleView"];
    view.contentView.backgroundColor = [UIColor colorWithNav];
    view.textLabel.attributedText = [[NSAttributedString alloc] initWithString:self.ViewModel.dayList[section] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 36;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        self.navbarHeight.constant = 56;
        self.homeTitle.alpha = 1.f;
        
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        self.navbarHeight.constant = 20;
        self.homeTitle.alpha = 0.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    
    NewsViewModel *model = [[NewsViewModel alloc]initWithStroyID:self.ViewModel.Storys[indexPath.section][indexPath.row].storyID];
    model.storyIDs = self.ViewModel.storyIDs;
    JZNewsViewController *vc = [[JZNewsViewController alloc]initWithNewsViewModel:model];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)dealloc{
    [self.contentTableView removeObserver:self forKeyPath:@"contentOffset"];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ThemeColorChange" object:nil];
}

@end
