//
//  NewsHeadView.h
//  知乎日报
//
//  Created by Jz on 16/4/16.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsViewModel;


@interface NewsHeadView : UIView


- (void)setDataWithModel:(NewsViewModel *)model;

@end
