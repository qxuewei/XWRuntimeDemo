

#import <Foundation/Foundation.h>

@class User;

@interface Status : NSObject


// 写一段程序自动生成属性代码
@property (nonatomic, assign) NSInteger ID;
// 解析字典自动生成属性代码
@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) NSInteger reposts_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) int attitudes_count;

@property (nonatomic, strong) NSString *idstr;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) int comments_count;

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) NSDictionary *retweeted_status;

// 模型的属性名跟字典一一对应

+ (__kindof Status *)statusWithDict:(NSDictionary *)dict;

@end
