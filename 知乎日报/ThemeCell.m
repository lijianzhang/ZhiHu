//
//  ThemeCell.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "ThemeCell.h"

@interface ThemeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ThemeCell

- (void)setModel:(id<themeModelData>)model{
    self.title.text = [model title];
}
@end
