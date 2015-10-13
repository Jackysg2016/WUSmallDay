//
//  WUAppUtils.h
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WUAppUtils : NSObject

#pragma mark - 导航栏左侧按钮
+ (NSArray *)createBackButtonWithTarget:(id)target selector:(SEL)selector;

#pragma mark - Json文件转数组 字典
+ (NSArray *)arrayWithFileName:(NSString *)fileName;
+ (NSDictionary *)dictionaryWithFileName:(NSString *)fileName;

@end
