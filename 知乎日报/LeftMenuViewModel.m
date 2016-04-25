//
//  LeftMenuViewModel.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "LeftMenuViewModel.h"
#import "ThemeModel.h"
#import "RequestTool.h"
@interface LeftMenuViewModel ()

@end

@implementation LeftMenuViewModel


- (instancetype)initWithDataLoadSuccess:(update)updateData{
    if (self = [super init]) {
        [[RequestTool shardRequest]getThemesWithSuccess:^(id data) {
            NSArray *themesArray = data[@"others"];
            NSMutableArray *themeModels  = [NSMutableArray array];
            ThemeModel *fistModel = [[ThemeModel alloc]init];
            fistModel.name =@"首页";
            [_themes addObject:fistModel];
            for (NSDictionary *theme in themesArray) {
                ThemeModel *themeModel = [[ThemeModel alloc]initWithDict:theme];
                [themeModels addObject:themeModel];;
            }
            [_themes addObjectsFromArray:themeModels];

            updateData();
        } andfail:^(NSError *error) {
            _themes = [NSMutableArray array];

        }];

    }
    return self;
}

- (NSMutableArray<ThemeModel *> *)themes{
    if (!_themes) {
        _themes = [NSMutableArray array];
    }
    return _themes;
}

@end
