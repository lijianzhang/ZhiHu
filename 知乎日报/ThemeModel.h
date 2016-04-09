//
//  theme.h
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol themeModelData <NSObject>

- (NSString *)imageName;
- (NSString *)title;

@end

@interface ThemeModel : NSObject <themeModelData>
@property (nonatomic,assign,readonly) int color;
@property (nonatomic,assign,readonly) int themeID;
@property (nonatomic,copy,readonly) NSString *thumbnail;
@property (nonatomic,copy,readonly)NSString *kind;
@property (nonatomic,copy) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
