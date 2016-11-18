
//版权所有：版权所有(C) 2013，东信移动控股有限公司
//系统名称：MBProgressHUD扩展
//文件名称：UIWindow+MBProgressHUD.h
//作　　者：金峰
//完成日期：2013-6-7
//功能说明：MBProgressHUD扩展于UIView
//-----------------------------------------

#import <UIKit/UIKit.h>

@interface UIWindow (MBProgressHUD)

/**
 @brief:只显示文字视图
 @param:text,文字
 */
- (void)showHUDWithText:(NSString *)text;

/**
 @brief:显示菊花视图
 @param:block,过程方法
 @param:completion,结束方法
 */
- (void)showHUDCicleWhileExecutingBlock:(dispatch_block_t)block
                        completionBlock:(void (^)())completion;

/**
 @brief:显示菊花视图和文字
 @param:text,文字
 @param:block,过程方法
 @param:completion,结束方法
 */
- (void)showHUDWithCicleAndText:(NSString *)text
            WhileExecutingBlock:(dispatch_block_t)block
                completionBlock:(void (^)())completion;

/**
 @brief:显示完成视图和文字
 @param:text,文字
 @param:block,过程方法
 @param:completion,结束方法
 */
- (void)showHUDWithCusteomViewAndText:(NSString *)text
                  WhileExecutingBlock:(dispatch_block_t)block
                      completionBlock:(void (^)())completion;

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
                     completionBlock:(void (^)())completion;

@end
