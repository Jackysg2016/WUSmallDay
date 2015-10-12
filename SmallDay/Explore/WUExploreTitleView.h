//
//  WUExploreTitleView.h
//  SmallDay
//
//  Created by wuqh on 15/10/12.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WUExploreTitleView;
@protocol WUExploreTitleViewDelegate<NSObject>

- (void)exploreTitleView:(WUExploreTitleView *)exploreTitleView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface WUExploreTitleView : UIView

@property (nonatomic, weak) id<WUExploreTitleViewDelegate> delegate;

+ (instancetype)exploreTitleView;

- (void)selectItemAtIndex:(NSInteger)index;

@end
