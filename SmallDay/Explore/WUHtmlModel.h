//
//  WUHtmlModel.h
//  SmallDay
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUBaseModel.h"

@interface WUHtmlModel : WUBaseModel

+ (NSMutableArray *)parseHtml:(NSString *)htmlStr;

@property (nonatomic ,assign) BOOL isImg;
@property (nonatomic, assign) BOOL isBold;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic ,assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat imgHeight;
@property (nonatomic, assign) CGFloat textHeight;

@end
