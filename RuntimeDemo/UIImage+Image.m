//
//  UIImage+Image.m
//  02-Runtime(交换方法)
//
//  Created by xiaomage on 15/10/22.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "UIImage+Image.h"

#import <objc/message.h>

@implementation UIImage (Image)
// 加载这个分类的时候调用
+ (void)load
{
    // 交换方法实现,方法都是定义在类里面
    // class_getMethodImplementation:获取方法实现
    // class_getInstanceMethod:获取对象
    // class_getClassMethod:获取类方法
    // IMP:方法实现
    
    // imageNamed
    // Class:获取哪个类方法
    // SEL:获取方法编号,根据SEL就能去对应的类找方法
    Method imageNameMethod = class_getClassMethod([UIImage class], @selector(imageNamed:));
    
    // xmg_imageNamed
    Method xmg_imageNamedMethod = class_getClassMethod([UIImage class], @selector(xmg_imageNamed:));
    
    // 交换方法实现
    method_exchangeImplementations(imageNameMethod, xmg_imageNamedMethod);
    
}

// 运行时
// 先写一个其他方法,实现这个功能
+ (UIImage *)xmg_imageNamed:(NSString *)imageName
{
    // 1.加载图片
    UIImage *image = [UIImage xmg_imageNamed:imageName];
    // 2.判断功能
    if (image == nil) {
        NSLog(@"加载image为空");
    }
    return image;
}

@end
