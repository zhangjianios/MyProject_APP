//
//  BaseViewController.h
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>

{
    MBProgressHUD *progressHUD;
}


@property (nonatomic, strong)UIView *personalView;
@property (nonatomic, strong)UIView *bgView;


- (void)showHUD:(NSString *)title;
- (void)completeHUD:(NSString *)title;
- (void)hiddenHUD;
- (void)backClick;


@end
