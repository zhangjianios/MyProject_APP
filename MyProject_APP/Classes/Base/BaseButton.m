//
//  BaseButton.m
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageWidth:(CGFloat)imageWidth normalImage:(NSString *)imageName selectedImage:(NSString *)selectedImage selectedColor:(UIColor *)color{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - imageWidth)/2.0, 0, imageWidth, imageWidth)];
        self.imageView.image = [UIImage imageNamed:imageName];
        
        [self addSubview:self.imageView];
        
        self.normalImage = [UIImage imageNamed:imageName];
        self.selectedImage = [UIImage imageNamed:selectedImage];
        
        self.selectedColor = color;
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageWidth, self.width, self.height - imageWidth)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = title;
        
        CGFloat fontSize = kScreenWidth != 320 ? 16 : 14;
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [self addSubview:self.titleLabel];
        
    }
    
    return self;
}

/**
 *  重写selected的set方法,根据是否被选中的状态,来进行图片和title的样式改变
 *
 *  @param selected
 */
- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        self.imageView.image = self.selectedImage;
        self.titleLabel.textColor = self.selectedColor;
    }else{
        self.imageView.image = self.normalImage;
        self.titleLabel.textColor = [UIColor blackColor];
    }
}


@end
