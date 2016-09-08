//
//  Car.m
//  RuntimeDemo
//
//  Created by 邱学伟 on 16/9/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "Car.h"

#import <objc/message.h>

@implementation Car
+(void)run{
    NSLog(@"类方法-跑");
}
-(void)run{
    NSLog(@"对象方法-跑");
}
+(void)run:(NSUInteger)kilometer{
    NSLog(@"类方法-跑 %zd 公里",kilometer);
}
-(void)run:(NSUInteger)kilometer{
    NSLog(@"对象方法-跑 %zd 公里",kilometer);
}


/**
 *  默认一个方法都有两个参数,self,_cmd,隐式参数
 *  self:方法调用者
 *  _cmd:调用方法的编号
 */
void dynamicMethod(id self, SEL _cmd, id param){
    NSLog(@"动态添加的方法 eat 的:%@",param);
}

// 动态添加方法,首先实现这个resolveInstanceMethod
// resolveInstanceMethod调用:当调用了没有实现的方法没有实现就会调用resolveInstanceMethod
// resolveInstanceMethod作用:就知道哪些方法没有实现,从而动态添加方法
// sel:没有实现对象方法
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(eat:)) {
        
        //动态添加eat方法
        /**
         *  class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
         *  cls:给哪个类添加方法
         *  name:添加的方法的方法编号是什么
         *  imp:方法实现,函数入口,函数名
         *  types:方法类型
         */
        class_addMethod(self, sel, (IMP)dynamicMethod, "v@:@");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

//类方法
+(BOOL)resolveClassMethod:(SEL)sel{
    return [super resolveClassMethod:sel];
}

@end
