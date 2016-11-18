//
//  BaseTabBarViewController.h
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseButton.h"

@interface BaseTabBarViewController : UITabBarController

@property (nonatomic, strong)BaseButton *lastButton;

/**
 *  将视图控制器添加到标签控制器上
 */

- (UIViewController *)addViewController:(NSString *)name title:(NSString *)title image:(NSString *)image;



@end

