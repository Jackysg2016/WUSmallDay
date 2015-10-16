//
//  WUClassifyModel.h
//  SmallDay
//
//  Created by wuqh on 15/10/16.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUBaseModel.h"

@interface WUClassifyModel : WUBaseModel

@property (nonatomic, strong) NSNumber *ev_count;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;

@end
