//
//  WUHtmlImgCell.h
//  SmallDay
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WUHtmlModel;

@interface WUHtmlImgCell : UITableViewCell

+ (instancetype)htmlImgCell;

- (void)updateUIWithModel:(WUHtmlModel *)model;

@end
