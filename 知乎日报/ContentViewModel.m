//
//  ContentViewModel.m
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "ContentViewModel.h"
#import "StoryModel.h"
@interface ContentViewModel ()
@property(nonatomic,copy)NSString *time;
@end
@implementation ContentViewModel


- (instancetype)initWithDataLoadSuccess:(update)updateData{
    if (self = [super init]) {
        self.loding = YES;
        _Storys = [NSMutableArray array];
        _dayList = [NSMutableArray array];
        _storyIDs = [NSMutableArray array];
        [[RequestTool shardRequest]getLatestNewsWithSuccess:^(id data) {
            self.loding = NO;
            NSArray *topStorys = data[@"top_stories"];
            NSArray *Storys = data[@"stories"];
            self.time = data[@"date"];
            NSString *time = [self stringConvertToSectionTitleText:self.time];
            [self.dayList addObject:time];
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
                [self.storyIDs addObject:storyModel.storyID];
            }
            [self.Storys addObject:StoryModels];
            
            updateData();
        } andfail:^(NSError *error) {
            [self setValue:[NSArray array] forKey:@"topStorys"];
        }];
        
    }
    return self;
}

-(void)getOldNewsWithSuccess:(update)updateData{
    self.loding = YES;
    [[RequestTool shardRequest] getOldNewsBefone:self.time WithSuccess:^(id requestData) {
        self.loding = NO;
        self.time = requestData[@"date"];
        NSString *time = [self stringConvertToSectionTitleText:self.time];
        [self.dayList addObject:time];
        NSArray *Storys = requestData[@"stories"];
        NSMutableArray *StoryModels  = [NSMutableArray array];
        for (NSDictionary *Story in Storys) {
            StoryModel *storyModel = [[StoryModel alloc]initWithDict:Story];
            [StoryModels addObject:storyModel];
            [self.storyIDs addObject:storyModel.storyID];
        }
        updateData();
        [self.Storys addObject:StoryModels];
    } andfail:^(NSError *error) {
        
    }];
}

- (NSString*)stringConvertToSectionTitleText:(NSString*)str {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:str];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CH"];
    [formatter setDateFormat:@"MM月dd日 EEEE"];
    NSString *sectionTitleText = [formatter stringFromDate:date];
    
    return sectionTitleText;
}

//- (StoryModel *)getStoryModelWithIndexPath:(NSIndexPath *)indexPath{
////    _Storys[indexPath.section][indexPath.row];
//}

@end
