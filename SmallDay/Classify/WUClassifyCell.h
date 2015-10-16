//
//  WUClassifyCell.h
//  SmallDay
//
//  Created by wuqh on 15/10/16.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WUClassifyModel;
@interface WUClassifyCell : UICollectionViewCell

+ (instancetype)classifyCell;

- (void)updateUIWithModel:(WUClassifyModel *)model;

@end
