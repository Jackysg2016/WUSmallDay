//
//  WUExploreStoreDetailCell.h
//  SmallDay
//
//  Created by wuqh on 15/10/16.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WUExploreEventModel;

@interface WUExploreStoreDetailCell : UITableViewCell

+ (WUExploreStoreDetailCell *)exploreStoreDetailCell;

- (void)updateUIWihtModel:(WUExploreEventModel *)model index:(NSInteger)index;

@end
