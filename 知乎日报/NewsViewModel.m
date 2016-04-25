//
//  NewsViewModel.m
//  知乎日报
//
//  Created by Jz on 16/4/17.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "NewsViewModel.h"
#import "newsModel.h"
#import "RequestTool.h"

@implementation NewsViewModel


- (NSString *)htmlBody{
     return [NSString stringWithFormat:@"<html><head><link rel='stylesheet' href='%@'><body>%@</body></head></html>",self.newsModel.css.firstObject,self.newsModel.body];
}
- (NSString *)newsImage{
    return self.newsModel.image;
}
- (NSString *)newsImageSource{
    return self.newsModel.image_source;
}
- (NSString *)newsTitle{
    return self.newsModel.title;
}

- (instancetype)initWithStroyID:(NSNumber *)StroyId{
    self = [super init];
    if (self) {
        self.nowStoryID = StroyId;
        [self getStroyContentWithID:StroyId];
    }
    return self;
}

- (void)getStroyContentWithID:(NSNumber *)idNumber{
    [[RequestTool shardRequest]getNewWithNewId:idNumber AndSuccess:^(id requestData) {
        self.newsModel = [[newsModel alloc]initWithDict:requestData];
    } andFail:^(NSError *error) {
        self.newsModel = [[newsModel alloc]init];
    }];
}
- (BOOL)getStroyContentWithBeforeStroy{
    NSInteger index = [self.storyIDs indexOfObject:self.nowStoryID];
    if (--index>=0) {
        [self getStroyContentWithID:self.storyIDs[index]];
        self.nowStoryID = self.storyIDs[index];
        return YES;
    }
    return NO;
    
}
- (BOOL)getStoryContentWithNextStroy{
    NSInteger index = [self.storyIDs indexOfObject:self.nowStoryID];
    if (++index<self.storyIDs.count) {
        [self getStroyContentWithID:self.storyIDs[index]];
        self.nowStoryID = self.storyIDs[index];
        return YES;
    }
    return NO;
}
@end
