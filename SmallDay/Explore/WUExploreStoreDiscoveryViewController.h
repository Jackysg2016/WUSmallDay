//
//  WUExploreStoreDiscoveryViewController.h
//  SmallDay
//
//  Created by wuqh on 15/10/13.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUBaseViewController.h"
@class WUExploreEventModel;
@interface WUExploreStoreDiscoveryViewController : WUBaseViewController

- (instancetype)initWithModel:(WUExploreEventModel *)model topSpaceConstraint:(NSLayoutConstraint *)topSpaceConstraint heightConstraint:(NSLayoutConstraint *)heightConstraint;

@end
