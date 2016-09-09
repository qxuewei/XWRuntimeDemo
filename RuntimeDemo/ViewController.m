//
//  ViewController.m
//  RuntimeDemo
//
//  Created by 邱学伟 on 16/9/8.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

#import "Car.h"
#import "UIImage+Image.h"
#import "Car+Cool.h"
#import "NSObject+AutoProperty.h"
#import "Status.h"
#import "NSObject+Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self sendMessage];
    
//    [self exchangeMethod];
    
//    [self dynamicMethod];
    
//    [self categoryAddPropery];
    
//    [self autoProperty];
    
    [self runtimeToModel];
}

//发送消息
/**
 
 使用Runtime首先:
 1.导入头文件: #import <objc/message.h>
 2.项目target中 -> Build Setting -> 搜索msg -> 设置属性为No

 本质让对象发送消息  objc_msgSend(<#id self#>, <#SEL op, ...#>) :第一个参数:谁发送这个消息,第二个参数:发送哪个消息
 
 */
-(void)sendMessage{
    Car *car = [[Car alloc] init];
    
    //普通-调用对象方法
    [car run];
    //Runtime-调用对象方法
    objc_msgSend(car, @selector(run));
    
    //普通-调用带参数对象方法
    [car run:100];
    //Runtime-调用带参数对象方法
    objc_msgSend(car, @selector(run:),1000);
    
    //普通-调用类方法
    [Car run];
    //Runtime-调用类方法   类名调用类方法,本质类名转换成类对象
    objc_msgSend([Car class], @selector(run));
    
    //普通-调用带参数类方法
    [Car run:200];
    //Runtime-调用带参数类方法
    objc_msgSend([Car class], @selector(run:),2000);
}

/**
 *  Runtime 交换方法
 *  在需要交换方法的类里实现 交换
 */
-(void)exchangeMethod{
    [UIImage imageNamed:@"123"];
}

/**
 *  Runtime 动态添加方法
 */
-(void)dynamicMethod{
    Car *car = [[Car alloc] init];
    //通过performSelector调用未声明的，但是会报错。
    //动态添加方法就不会报错
    [car performSelector:@selector(eat:) withObject:@"馒头"];
}

/**
 *  Runtime 分类动态添加属性
 *  属性的含义即将其指针指到特定的一块存储空间
 
 如果在分类中仅仅声明一个属性而不实现,在使用这个属性会报错:
 '-[Car setName:]: unrecognized selector sent to instance 0x7fde4d940c30'

 所以必须实现自定义的这个属性的get方法和set方法
 
 一种方法是使用 static 定义全局变量,实现其 get / set 方法:
 
 #import "Car+Cool.h"
 
 @implementation Car (Cool)
 
 static NSString *_name;
 
 -(void)setName:(NSString *)name{
 _name = name;
 }
 
 -(NSString *)name{
 return _name;
 }
 
 @end
 
 另外即使用Runtime给分类动态添加属性
 
 */
-(void)categoryAddPropery{
    Car *car = [[Car alloc] init];
    car.name = @"BMW";
    NSLog(@"CAR 的名称: %@",car.name);
}

/**
 *  自动生成模型属性列表
 *  在解析JSON字典或本地字典处,利用自定义分类中的 printPropertyWithDict 类方法直接可以将字典中所有key转化为自定义模型中的属性名
 */
-(void)autoProperty{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil]];
    NSArray *dictArr = dict[@"statuses"];
    // 设计模型属性代码
    [NSObject printPropertyWithDict:dictArr[0]];
}


/**
 *  利用runtime将字典转化为模型
 *  新建NSObject的分类 利用Runtime将字典转化为模型
 */
-(void)runtimeToModel{
    NSDictionary *fileDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil]];
    NSArray *fileArr = [fileDict objectForKey:@"statuses"];
    NSLog(@"%@",fileArr);
    
    //将数据数组转化成模型数组
    __block NSMutableArray *modelArrM = [NSMutableArray array];
    
    [fileArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = (NSDictionary *)obj;
        Status *status = [Status modelWithDict:dict];
        [modelArrM addObject:status];
    }];
    
    NSLog(@"%@",modelArrM);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
