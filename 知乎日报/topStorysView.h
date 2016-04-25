//
//  topStorysView.h
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryModel.h"
typedef void(^selectImageViewNumber)(NSInteger index);

@interface topStorysView : UIView
@property (nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,copy)selectImageViewNumber block;
-(void)CreateData:(NSArray<StoryModel *> *)datas;
-(void)updateFrame;
@end
