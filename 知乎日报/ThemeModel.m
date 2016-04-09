//
//  theme.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "ThemeModel.h"

@implementation ThemeModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _themeID = (int)value;
    }else if ([key isEqualToString:@"description"]){
        _kind = value;
    }else{
        return;
    }
}

- (NSString *)imageName{
    return @"";
}
- (NSString *)title{
    return self.name;
}
@end
