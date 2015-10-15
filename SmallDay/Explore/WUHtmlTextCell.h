//
//  WUHtmlTextCell.h
//  SmallDay
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WUHtmlModel;
@interface WUHtmlTextCell : UITableViewCell

+ (instancetype)htmlTextCell;

- (void)updateUIWithModel:(WUHtmlModel *)model;

@end
