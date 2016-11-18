//
//  BaseViewController.m
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     * 在全局设置状态栏不隐藏，解决横屏时候状态栏隐藏的问题
     */
    [UIApplication sharedApplication].statusBarHidden=NO;
    //    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = KColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view autoresizingMask];
    self.view.backgroundColor = [UIColor colorWithRed:239 / 255.0f green:239 / 255.0f blue:239 / 255.0f alpha:1.0f];
    
    /**
     * 获取到系统的delegate
     *
     */
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    /**
     * 拿到系统的根控制器
     *
     */
    LeftSlideViewController *leftVC = (LeftSlideViewController *)delegate.window.rootViewController;
    if (self.navigationController.viewControllers.count == 1) {
        /**
         * 当导航控制器的控制器个数为1的时候，在一级界面，打开侧滑手势
         *
         */
        [leftVC setGestureAll];
        //        [self panGestureRecognizer];
        /**
         * 判断当前的控制器是不是导航控制器的根控制器，如果是根控制器才创建登录按钮
         *
         */
        //        [self initLeftNavigationBar];
    }else {
        /**
         * 当导航控制器的控制器个数不为1的时候，关闭侧滑手势
         *
         */
        [self backButton];
        [leftVC setGestureNone];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden=NO;
    /**
     * 获取到系统的delegate
     *
     */
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    /**
     * 拿到系统的根控制器
     *
     */
    LeftSlideViewController *leftVC = (LeftSlideViewController *)delegate.window.rootViewController;
    if (self.navigationController.viewControllers.count == 1) {
        /**
         * 当导航控制器的控制器个数为1的时候，在一级界面，打开侧滑手势
         *
         */
        [leftVC setGestureAll];
        //        [self panGestureRecognizer];
        /**
         * 判断当前的控制器是不是导航控制器的根控制器，如果是根控制器才创建登录按钮
         *
         */
        //            [self initLeftNavigationBar];
    }else {
        /**
         * 当导航控制器的控制器个数不为1的时候，关闭侧滑手势
         *
         */
        [leftVC setGestureNone];
    }
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - customMethod
/**
 * 创建登录按钮
 * @e-ctrl:1-button:登录
 * @e-out-other:2-imageView:头像
 *
 */
- (void)initLeftNavigationBar {
    /**
     * @reqno:H1511110066
     * @date-designer:20151112-chenfei01
     * @date-author:20151112-chenfei01:已经登录则显示头像
     *
     */
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    headerImageView.layer.cornerRadius = 15.0f;
    headerImageView.layer.masksToBounds = YES;
    headerImageView.userInteractionEnabled = YES;
    headerImageView.image = [UIImage imageNamed:@"icon_head.png"];
    UIControl* button = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerImageView addSubview:button];
    UIBarButtonItem *headerItem = [[UIBarButtonItem alloc] initWithCustomView:headerImageView];
    self.navigationItem.leftBarButtonItem = headerItem;
    
}

- (void)controlClick:(UIControl*)control {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    LeftSlideViewController *leftVC = (LeftSlideViewController *)delegate.window.rootViewController;
    //    [leftVC toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    //    [self creatPersonalCenterView];
}

- (void)backButton {
    UIButton* backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    backbutton.frame = CGRectMake(0, 0, 20, 20);
    [backbutton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backbutton setImage:[UIImage imageNamed:@"botton_return.png"] forState:UIControlStateNormal];
    [backbutton setImage:[UIImage imageNamed:@"botton_return.png"] forState:UIControlStateHighlighted];
    [backbutton setImage:[UIImage imageNamed:@"botton_return.png"] forState:UIControlStateSelected];
    UIBarButtonItem* leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
}
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 * @reqno:H1511110066
 * @date-designer:20151112-chenfei01
 * @date-author:20151112-chenfei01:登录按钮的点击事件
 *
 */
//- (void)loginButton {
//    RMLoginViewController *loginViewController = [[RMLoginViewController alloc] init];
//    [self.navigationController pushViewController:loginViewController animated:YES];
//}

//- (BOOL)shouldAutorotate {
//
//    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
//    return NO;
//}

#pragma mark 创建侧边的个人中心栏
- (void)creatPersonalCenterView {
    CGFloat width = kScreenWidth*5.0/6.0;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (self.personalView==nil) {
        self.personalView = [[UIView alloc] initWithFrame:window.bounds];
        self.personalView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.personalView.alpha = 0;
        [window addSubview:self.personalView];
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(-width, 0, width, kScreenHeight)];
        [self.personalView addSubview:self.bgView];
        PersonalCenterViewController* personalVC = [[PersonalCenterViewController alloc] init];
        personalVC.view.frame = CGRectMake(0, 0, width, kScreenHeight);
        [self.bgView addSubview:personalVC.view];
        
        //在窗口遮罩部分添加点击事件，点击后隐藏侧边个人中心
        UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(width, 0, kScreenWidth-width, kScreenHeight)];
        [control addTarget:self action:@selector(hiddenPersonalView) forControlEvents:UIControlEventTouchUpInside];
        [window addSubview:control];
    }
    [self showPersonalCenterView];
}

#pragma mark 侧滑手势
- (void)panGestureRecognizer {
    UISwipeGestureRecognizer *rightSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipAction:)];
    [self.view addGestureRecognizer:rightSwip];
}
//平移
- (void)rightSwipAction:(UISwipeGestureRecognizer *)pan{
//        CGFloat width = kScreenWidth*5/6;
//        CGPoint point = [pan locationInView:self.view];
//        if (self.personalView.left!=0) {
//            self.personalView.left++;
//        }
    [UIView animateWithDuration:1 animations:^{
        self.personalView.alpha = 1;
        self.bgView.left = 0;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 显示侧边个人中心
- (void)showPersonalCenterView {
    //    CGFloat width = kScreenWidth*5/6;
    [UIView animateWithDuration:1 animations:^{
        self.personalView.alpha = 1;
        self.bgView.left = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenPersonalView {
    
    [UIView animateWithDuration:1 animations:^{
        self.personalView.alpha = 0;
        self.bgView.right = 0;
    } completion:^(BOOL finished) {
        
    }];
    
}

//显示加载的视图
/**
 * @reqno:H1602230009
 * @date-designer:20160224-chenfei01
 * @date-author:20160224-chenfei01:在基类中添加显示加载遮罩的方法，如果需要用到遮罩就调用此方法
 */
- (void)showHUD:(NSString *)title{
    progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //让背景变暗
    progressHUD.dimBackground = YES;
    //设置文本
    progressHUD.labelText = title;
}
/**
 * @reqno:H1602230009
 * @date-designer:20160224-chenfei01
 * @date-author:20160224-chenfei01:在基类中添加显示加载遮罩的方法，如果需要用到遮罩就调用此方法
 */
//加载完成提示的视图
- (void)completeHUD:(NSString *)title{
    if (progressHUD) {
        progressHUD.mode = MBProgressHUDModeCustomView;
        progressHUD.labelText = title;
        
        [progressHUD hide:YES afterDelay:1];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [progressHUD removeFromSuperview];
            progressHUD = nil;
        });
    }
}

- (void)hiddenHUD {
    if (progressHUD) {
        [progressHUD hide:YES afterDelay:1];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [progressHUD removeFromSuperview];
            progressHUD = nil;
        });
    }
}


@end
