//
//  SCBTabBarController.h
//  ShareBook
//
//  Created by cisdi on 2019/10/8.
//  Copyright © 2019 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCBTabBarController : UITabBarController
/// TabBarItem 文字默认字体
@property (nonatomic, strong) UIFont *normalFont;
/// TabBarItem 文字选中字体
@property (nonatomic, strong) UIFont *selectedFont;
/// TabBarItem 文字默认颜色
@property (nonatomic, strong) UIColor *normalColor;
/// TabBarItem 文字选中颜色
@property (nonatomic, strong) UIColor *selectedColor;

@end

NS_ASSUME_NONNULL_END
