//
//  NSObject+Model.m
//  RuntimeDemo
//
//  Created by 邱学伟 on 16/9/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>
@implementation NSObject (Model)
+(instancetype)modelWithDict:(NSDictionary *)dict{
    //1.创建
    id objc = [[self alloc] init];
    
    //获取本类中所有属性列表
    /*
     * class_copyIvarList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
     * 遍历当前对象(模型)中所有成员属性
     * class_copyIvarList:把成员属性列表复制一份给你
     * Ivar *:指向一个成员变量数组,指向Ivar指针
     * Class cls :获取哪个类的成员属性列表
     * outCount :成员属性总数
     */
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    //解析获取到的成员属性列表
    for (int i = 0; i < count; i++) {
        //每个成员属性
        Ivar oneProperty = ivarList[i];
        //成员属性名称
        NSString *onePropertyName = [NSString stringWithUTF8String:ivar_getName(oneProperty)];
        //成员属性类型
        NSString *onePropertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(oneProperty)];
        //获取字典的key,以便得到value给模型赋值
        NSString *key = [onePropertyName substringFromIndex:1];
        //当前可以所对应的value
        id value = dict[key];
        //二级转换,在解析过程中可能会遇到多层解析的情况,即字典中某一value值也为字典,此时需要进行模型的二级转换,同样利用Runtime的方式
        if ([value isKindOfClass:[NSDictionary class]] && ![onePropertyType containsString:@"NS"]) {
            //此时可确定模型中某一成员属性为另一模型而并非NSDictionary
            //使用递归算法,将其转化为另一自定义模型
            //此时打印的  onePropertyType 为 @"User" 需要进行截取 获得最终的类名
            onePropertyType = [onePropertyType substringFromIndex:2];
            onePropertyType = [onePropertyType substringToIndex:(onePropertyType.length-1)];
            Class customModel =  NSClassFromString(onePropertyType);
            if (customModel) {
                value = [customModel modelWithDict:value];
            }
        }
        //给模型当前属性赋值
        if (value) {
            [objc setValue:value forKey:key];
        }
//        NSLog(@"%@",objc);
    }
    
    return objc;
}
@end
