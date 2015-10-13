//
//  WUExploreThemeCell.h
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WUExploreThemeModel;

@interface WUExploreThemeCell : UITableViewCell

+ (instancetype)exploreThemeCell;

- (void)updateUIWithModel:(WUExploreThemeModel *)model;

@end
