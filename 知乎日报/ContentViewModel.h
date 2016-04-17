//
//  ContentViewModel.h
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestTool.h"
@class StoryModel;
typedef void(^update)();
@interface ContentViewModel : NSObject
@property(nonatomic,strong,readonly)NSArray<StoryModel*> *topStorys;/**<热门消息 */
@property(nonatomic,strong)NSMutableArray<NSArray<StoryModel*>*> *Storys;/**<消息 */
@property(nonatomic,strong)NSMutableArray *dayList;/**<<#text#> */
@property(nonatomic,assign,getter=isLoding)BOOL loding;
- (instancetype)initWithDataLoadSuccess:(update)updateData;
-(void)getOldNewsWithSuccess:(update)updateData;


@end
