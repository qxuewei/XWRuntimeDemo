//
//  NSObject+Model.h
//  RuntimeDemo
//
//  Created by 邱学伟 on 16/9/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  利用Runtime根据字典模型转模型

#import <Foundation/Foundation.h>

@interface NSObject (Model)

/**
 *  根据字典转模型
 *
 *  @param dict 字典
 *
 *  @return 模型
 */
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end
