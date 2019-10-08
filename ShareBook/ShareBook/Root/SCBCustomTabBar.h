//
//  SCBCustomTabBar.h
//  ShareBook
//
//  Created by cisdi on 2019/10/8.
//  Copyright © 2019 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCBCustomTabBar;

NS_ASSUME_NONNULL_BEGIN

@protocol SCBCustomTabBarDelagate <NSObject>

@optional
- (void)tabBarDidClickCenterButton:(SCBCustomTabBar *)tabBar;

@end

@interface SCBCustomTabBar : UITabBar

@property (nonatomic, weak) id<SCBCustomTabBarDelagate> customTabBarDelegate;
/**
 *   增加中间按钮
 */
- (void)addCenterButton;
/**
 *  调整中间按钮位置
 */
- (void)refreshCenterButton;
@end

NS_ASSUME_NONNULL_END
