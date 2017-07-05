//
//  UIBarButtonItem+OCRAdd.m
//  OCRResult
//
//  Created by XingJie on 2017/7/4.
//  Copyright © 2017年 xingjie. All rights reserved.
//

#import "UIBarButtonItem+OCRAdd.h"

@implementation UIBarButtonItem (OCRAdd)

+ (instancetype)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}



@end
