//
//  WUExploreEventHeaderView.h
//  SmallDay
//
//  Created by wuqh on 15/10/13.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WUExploreEventHeaderView;
@protocol WUExploreEventHeaderViewDelegate<NSObject>

- (void)exploreEventHeaderView:(WUExploreEventHeaderView *)exploreEventHeaderView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface WUExploreEventHeaderView : UIView

@property (nonatomic, weak) id<WUExploreEventHeaderViewDelegate> delegate;

- (void)selectItemAtIndex:(NSInteger)index;

@end
