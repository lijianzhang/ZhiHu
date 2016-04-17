//
//  ContentViewCell.m
//  知乎日报
//
//  Created by Jz on 16/4/9.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "ContentViewCell.h"
#import "UIImageView+WebCache.h"

@interface ContentViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;



@end
@implementation ContentViewCell
- (void)ShowDataWIthModel:(StoryModel*)data{

    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:data.images.firstObject]];
    self.title.text = data.title;
}
@end
