//
//  BaseButton.h
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @e-out-other:0-imageView:button上显示的图片
 * @e-out-other:1-titleLabel:button上显示的标题
 * @e-in-other:2-selectedImage:选中状态下显示的图片
 * @e-in-other:3-normalImage:正常状态下显示的图片
 * @e-in-other:4-selectedColor:选中状态下的字体颜色
 * @date-author:自定义一个上部显示图片下部显示标题的button，并能根据button的选择状态改变图片和标题的颜色
 */

@interface BaseButton : UIControl

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImage *normalImage;
@property (nonatomic, strong)UIImage *selectedImage;

@property (nonatomic, strong)UIColor *selectedColor;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageWidth:(CGFloat)imageWidth normalImage:(NSString *)imageName selectedImage:(NSString *)selectedImage selectedColor:(UIColor*)color;



@end
