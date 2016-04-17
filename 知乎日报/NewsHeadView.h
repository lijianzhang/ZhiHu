//
//  NewsHeadView.h
//  知乎日报
//
//  Created by Jz on 16/4/16.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsModel.h"
@interface NewsHeadView : UIView
- (void)setDataWithModel:(id <newsModelData>)model;
@end
