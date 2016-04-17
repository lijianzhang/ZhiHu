//
//  RefreshView.h
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshView : UIView
- (void)changeStatusWith:(CGFloat)progress;
- (void)startAnimating;
- (void)stopAnimating;
@end
