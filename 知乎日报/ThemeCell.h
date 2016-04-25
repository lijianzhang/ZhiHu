//
//  ThemeCell.h
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"

@interface ThemeCell : UITableViewCell
- (void)setModel:(id<themeModelData>)model;
@end
