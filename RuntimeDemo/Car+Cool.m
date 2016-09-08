//
//  Car+Cool.m
//  RuntimeDemo
//
//  Created by 邱学伟 on 16/9/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "Car+Cool.h"
#import <objc/message.h>

@implementation Car (Cool)

//全局存在,影响内存 - 不推荐
//static NSString *_name;

-(void)setName:(NSString *)name{
//    _name = name;
    
    
    /**
     *  跟所添加的属性产生关联
     *  objc_setAssociatedObject(<#id object#>, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
     *
     *  @param object 给哪个对象添加属性
     *  @param key   属性名,根据key获取关联对象 void * == id
     *  @param value  属性名所关联的值
     *  @param policy  关联的策略
     */
    objc_setAssociatedObject(self, @"CarName", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)name{
//    return _name;
    
    /**
     *  根据关联的key 获取所关联的值
     *  objc_getAssociatedObject(<#id object#>, <#const void *key#>)
     *
     *  @param object 给哪个对象所添加的属性
     *  @param key    属性名,可根据此key 值获取其之前所关联的值
     *
     */
    return objc_getAssociatedObject(self, @"CarName");
}
@end
