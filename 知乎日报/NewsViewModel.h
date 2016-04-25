//
//  NewsViewModel.h
//  知乎日报
//
//  Created by Jz on 16/4/17.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class newsModel;
@interface NewsViewModel : NSObject

@property(nonatomic,strong)NSArray *storyIDs;/**<<#text#> */
@property(nonatomic,strong)NSNumber *nowStoryID;/**<<#text#> */
@property(nonatomic,copy)NSString *htmlBody;
@property(nonatomic,copy)NSString *newsImage;/**<<#text#> */
@property(nonatomic,copy)NSString *newsImageSource;/**<<#text#> */
@property(nonatomic,copy)NSString *newsTitle;
@property(nonatomic,strong)newsModel *newsModel;/**<<#text#> */

- (void)getStroyContentWithID:(NSNumber *)idNumber;
- (BOOL)getStroyContentWithBeforeStroy;
- (BOOL)getStoryContentWithNextStroy;
- (instancetype)initWithStroyID:(NSNumber *)StroyId;
@end
