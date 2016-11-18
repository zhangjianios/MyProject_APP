//
//  LeftSlideViewController.h
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UIView_extra.h"
#import "MMDrawerController.h"
/**
 *  使用第三方实现侧滑的抽屉式效果
 */

@interface LeftSlideViewController : MMDrawerController

+ (LeftSlideViewController *)shareRootDrawerController;

- (void)setGestureNone;

- (void)setGestureAll;
@end
