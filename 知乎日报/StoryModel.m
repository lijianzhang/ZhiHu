//
//  StoryModel.m
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel
- (instancetype)initWithDict:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"storyID"];
    }
    
    if ([key isEqualToString:@"multipic"]) {
        [self setValue:value forKey:@"isMultipic"];
    }
    
}
@end
