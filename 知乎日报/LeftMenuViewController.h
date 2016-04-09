//
//  LeftMenuViewController.h
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftMenuViewControllerDelege <NSObject>

-(void)selectNumberof:(NSInteger)number;
-(void)showMenu;
-(void)hideMenu;

@end

@interface LeftMenuViewController : UIViewController
@property(nonatomic,weak)id<LeftMenuViewControllerDelege> delege;
@end
