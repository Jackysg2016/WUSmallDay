//
//  WUExploreEventCell.h
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WUExploreEventModel;
@interface WUExploreEventCell : UITableViewCell

+ (instancetype)exploreEventCell;

- (void)updateUIWithModel:(WUExploreEventModel *)model;

@end
