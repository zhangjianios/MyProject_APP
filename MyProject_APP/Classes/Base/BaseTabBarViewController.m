//
//  BaseTabBarViewController.m
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseTabBarViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  调整底部按钮的背景颜色
     *
     *  @return
     */
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  在viewWillAppear中删除系统的标签栏,创建自定义的标签栏
 *
 *  @return
 */

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.lastButton == nil) {
        //移除系统的tababr
        [self removeTabBar];
        
        //创建自己的tabbar
        [self createTabBar];
    }
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
}


- (void)push{
    
    [self removeTabBar];
    
    [self createTabBar];
}

- (void)removeTabBar{
    
    //1.取到tabbar的所子视图
    NSArray *tabbars = self.tabBar.subviews;
    //2.遍历子视图,捎带着把子视图移除
    for (UIView *view in tabbars) {
        
        //取到tababr上的所有子视图
        Class tababr = NSClassFromString(@"UITabBarButton");
        
        if ([view isKindOfClass:tababr]) {
            //从父视图中移除
            [view removeFromSuperview];
        }
        
    }
    
}


/**
 *  创建自定义的标签样式.分为选中状态和未选中状态,图片样式不同
 */

- (void)createTabBar{
    
    //创建按钮
    NSArray *normalImages = @[@"tabbar_home.png",@"tabbar_message_center.png", @"tabbar_discover@2x.png",@"tabbar_profile.imageset"];
    
    NSArray *selectedImages = @[@"tabbar_home_selected.png", @"tabbar_message_center_selected.png", @"tabbar_discover_selected.png", @"tabbar_profile_selected.png"];
    
    NSArray *titleArray = @[@"首页", @"消息", @"应用", @"我的"];
    CGFloat width = kScreenWidth / titleArray.count;
    CGFloat height = self.tabBar.height;
    
    for (int i = 0; i < normalImages.count; i ++) {
        BaseButton *tabBtn = [[BaseButton alloc]initWithFrame:CGRectMake(width * i, 5, width, height - 5) title:[titleArray objectAtIndex:i] imageWidth:20 normalImage:[normalImages objectAtIndex:i] selectedImage:[selectedImages objectAtIndex:i] selectedColor:KColor];
        
        tabBtn.tag = 2016 + i;
        [tabBtn addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:tabBtn];
        
        if (i == 0) {
            tabBtn.selected = YES;
            self.lastButton = tabBtn;
        }
        
    }
}
- (void)tabBarClick:(BaseButton *)btn{
    
    if (self.lastButton!=btn) {
        self.lastButton.selected = NO;
        btn.selected = YES;
    }
    
    self.selectedViewController = self.viewControllers[btn.tag - 2016];
    self.lastButton = btn;
}

#pragma mark - InterFaceMethod
//name：要添加的视图控制器的名字
-(UIViewController *)addViewController:(NSString *)name title:(NSString *)title image:(NSString *)image{
    //通过这个方法可以得到名称为viewController的类名
    Class viewControllerName = NSClassFromString(name);
    
    //多态：父类指针指向子类的对象
    UIViewController* viewController = [[viewControllerName alloc]init];
    
    
    //设置标签栏的标题
    viewController.title = title;
    //设置标签栏的图片
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    
    //将视图控制器添加到导航
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    
    //将标签栏的数组转化为可变的数组
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    
    [array addObject:nav];
    
    //将数组重新赋给标签栏的数组
    self.viewControllers = array;
    
    return viewController;
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
