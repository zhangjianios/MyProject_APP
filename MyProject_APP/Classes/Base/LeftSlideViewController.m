//
//  LeftSlideViewController.m
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LeftSlideViewController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface LeftSlideViewController ()

@end


static LeftSlideViewController *root = nil;

@implementation LeftSlideViewController
+ (LeftSlideViewController *)shareRootDrawerController{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        root = [[LeftSlideViewController alloc]init];
    });
    return root;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //布局
    [self initLayout];
    
    //设置动画
    [self setAnimation];
}

- (void)initLayout{
    
    BaseTabBarViewController *bsTabBarVC = [[BaseTabBarViewController alloc]init];
    
    [bsTabBarVC addViewController:@"HomePageViewController" title:@"首页" image:@""];
    [bsTabBarVC addViewController:@"MessageCenterViewController" title:@"消息" image:@""];
    [bsTabBarVC addViewController:@"DiscoverViewController" title:@"应用" image:@""];
    [bsTabBarVC addViewController:@"MyProfileViewController" title:@"我的" image:@""];
    
    self.centerViewController = bsTabBarVC;
    PersonalCenterViewController *leftVC = [[PersonalCenterViewController alloc]init];
    self.leftDrawerViewController = leftVC;
    
}

- (void)setAnimation{
    
    //设置左右显示的宽度
    [self setMaximumLeftDrawerWidth:kScreenWidth * 5.0 / 6.0];
    //设置阴影
    [self setShowsShadow:NO];
//    //设置手势的作用区域
//        [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//        [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置动画的回调
    [self setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
        MMDrawerControllerDrawerVisualStateBlock block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  设置手势作用的区域
 */

- (void)setGestureNone{
    
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)setGestureAll{
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}












/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
