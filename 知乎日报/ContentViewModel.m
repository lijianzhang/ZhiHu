//
//  ContentViewModel.m
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "ContentViewModel.h"
#import "StoryModel.h"

@implementation ContentViewModel
- (instancetype)initWithDataLoadSuccess:(update)updateData{
    if (self = [super init]) {
        [[RequestTool shardRequest]getLatestNewsWithSuccess:^(id data) {
            NSArray *topStorys = data[@"top_stories"];
            NSArray *Storys = data[@"stories"];
            NSMutableArray *topStoryModels  = [NSMutableArray array];
            for (NSDictionary *topStory in topStorys) {
                StoryModel *storyModel = [[StoryModel alloc]initWithDict:topStory];
                [topStoryModels addObject:storyModel];
            }
            [self setValue:topStoryModels forKey:@"topStorys"];
            
            NSMutableArray *StoryModels  = [NSMutableArray array];
            for (NSDictionary *Story in Storys) {
                StoryModel *storyModel = [[StoryModel alloc]initWithDict:Story];
                [StoryModels addObject:storyModel];
            }
            [self setValue:StoryModels forKey:@"Storys"];
            
            NSLog(@"创建主题日报数组模型成功");
            updateData();
        } andfail:^(NSError *error) {
            [self setValue:[NSArray array] forKey:@"topStorys"];
            NSLog(@"创建主题日报数组模型失败");
        }];
        
    }
    return self;
}


@end
