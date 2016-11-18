
//版权所有：版权所有(C) 2013，东信移动控股有限公司
//系统名称：MBProgressHUD扩展
//文件名称：UIWindow+MBProgressHUD.h
//作　　者：金峰
//完成日期：2013-6-7
//功能说明：MBProgressHUD扩展于UIView
//-----------------------------------------

#import "UIWindow+MBProgressHUD.h"
#import "MBProgressHUD.h"
#import "UIImageExtend.h"
@implementation UIWindow (MBProgressHUD)

/**
 @brief:只显示文字视图
 @param:text,文字
 */
- (void)showHUDWithText:(NSString *)text{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    [self addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:2];
}
/**
 @brief:显示菊花视图
 @param:block,过程方法
 @param:completion,结束方法
 */
- (void)showHUDCicleWhileExecutingBlock:(dispatch_block_t)block
                        completionBlock:(void (^)())completion{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    [self addSubview:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        block();
        sleep(3);
    }completionBlock:^{
        completion();
        [hud removeFromSuperview];
    }];
}

/**
 @brief:显示菊花视图和文字
 @param:text,文字
 @param:block,过程方法
 @param:completion,结束方法
 */
- (void)showHUDWithCicleAndText:(NSString *)text
            WhileExecutingBlock:(dispatch_block_t)block
                completionBlock:(void (^)())completion{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    hud.labelText = text;
    [self addSubview:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        block();
        sleep(3);
    }completionBlock:^{
        completion();
        [hud removeFromSuperview];
    }];
    
}

/**
 @brief:显示完成视图和文字
 @param:text,文字
 @param:block,过程方法
 @param:completion,结束方法
 */
- (void)showHUDWithCusteomViewAndText:(NSString *)text
            WhileExecutingBlock:(dispatch_block_t)block
                completionBlock:(void (^)())completion{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage getImageFromMyBundleWithName:@"37x-Checkmark.png"]];
    hud.labelText = text;
    [self addSubview:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    }completionBlock:^{
        completion();
        [hud removeFromSuperview];
    }];
}



/**
 @brief:显示完成视图和文字
 @param:beginText,开始文字
 @param:finishText,结束文字
 @param:block,过程方法
 @param:completion,结束方法
 */
- (void)showHUDWithCicleAndBeginText:(NSString *)beginText
                          FinishText:(NSString *)finishText
                 WhileExecutingBlock:(dispatch_block_t)block
                     completionBlock:(void (^)())completion{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    hud.labelText = beginText;
    [self addSubview:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        block();
        sleep(3);
    }completionBlock:^{
        [hud removeFromSuperview];
        sleep(0.5);
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc]initWithImage:[UIImage getImageFromMyBundleWithName:@"37x-Checkmark.png"]];
        hud.labelText = finishText;
        [self addSubview:hud];
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        }completionBlock:^{
            completion();
            [hud removeFromSuperview];
        }];
        
    }];
    
    
    [self showHUDWithCicleAndText:beginText WhileExecutingBlock:block completionBlock:^{
        
    }];
    
}

@end
