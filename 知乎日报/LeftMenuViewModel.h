//
//  LeftMenuViewModel.h
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^update)();
@class ThemeModel;
@interface LeftMenuViewModel : NSObject
@property(nonatomic,copy)NSMutableArray<ThemeModel *>*themes;

- (instancetype)initWithDataLoadSuccess:(update)updateData;

@end
