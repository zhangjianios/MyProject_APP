//
//  UIView+ViewController.m
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
- (UIViewController *)viewController{
    
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next);
    return nil;
}

@end
