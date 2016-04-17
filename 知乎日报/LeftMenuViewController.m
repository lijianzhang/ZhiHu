//
//  LeftMenuViewController.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "UIImageView+JZ.h"
#import "LeftMenuViewModel.h"
#import "ThemeCell.h"
@interface LeftMenuViewController()<UITableViewDataSource,UITabBarControllerDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *themsTableView;
@property (nonatomic, strong)LeftMenuViewModel *ViewModel;

@end

static  NSString * const Identifier = @"themeCell";

@implementation LeftMenuViewController



- (LeftMenuViewModel *)ViewModel{
    if (!_ViewModel) {
        _ViewModel = [[LeftMenuViewModel alloc]initWithDataLoadSuccess:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.themsTableView reloadData];
            });
    
        }];
    }
    return _ViewModel;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.themsTableView.rowHeight = 50;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ViewModel.themes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    [cell setModel:self.ViewModel.themes[indexPath.row]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor *backgroundColor = [UIColor colorWithRed:0.106 green:0.125 blue:0.141 alpha:1];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.themsTableView.bounds;
    gradient.colors = @[ (id)[UIColor clearColor].CGColor, (id)backgroundColor.CGColor];
    gradient.startPoint = CGPointMake(0.5, 1);
    gradient.endPoint = CGPointMake(0.5, 0.8);
    self.themsTableView.layer.mask = gradient;
}
- (IBAction)changeThemeColor:(id)sender {
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    BOOL isLight = [users boolForKey:@"Theme"];
    NSLog(@"%d",isLight);
    [users setBool:!isLight forKey:@"Theme"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ThemeColorChange" object:nil];
}


@end
