//
//  SCBTabBarController.m
//  ShareBook
//
//  Created by cisdi on 2019/10/8.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "SCBTabBarController.h"
#import "SCBCustomTabBar.h"
#import "SCBNavigationController.h"
#import "SCBHomeViewController.h"
#import "SCBMineViewController.h"
#import "SCBBookViewController.h"
#import "SCBFindViewController.h"

@interface SCBTabBarController () <SCBCustomTabBarDelagate>

@property (nonatomic, strong) SCBCustomTabBar *customTabBar;
@end

@implementation SCBTabBarController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDefaultTabBarAppearance];
    [self setupChildViewControllers];
    [self setupCustomizeTabBarAppearance];
    
}

/**
 * 设置子控制器
 */
- (void)setupChildViewControllers {
    SCBHomeViewController *homeVC = [[SCBHomeViewController alloc] init];
    SCBNavigationController *homeNav = [[SCBNavigationController alloc] initWithRootViewController:homeVC];
      
    SCBBookViewController *bookVC = [[SCBBookViewController alloc] init];
    SCBNavigationController *bookNav = [[SCBNavigationController alloc] initWithRootViewController:bookVC];

    SCBFindViewController *findVC = [[SCBFindViewController alloc] init];
    SCBNavigationController *findNav = [[SCBNavigationController alloc] initWithRootViewController:findVC];
    
    SCBMineViewController *mineVC = [[SCBMineViewController alloc] init];
    SCBNavigationController *mineNav = [[SCBNavigationController alloc] initWithRootViewController:mineVC];
    
    self.viewControllers = @[homeNav, bookNav, findNav, mineNav];
}

/**
 *  设置自定义外观
 */
- (void)setupCustomizeTabBarAppearance {
    // 背景图片
    self.customTabBar.backgroundColor = [UIColor whiteColor];
    
    // 文字、图标
    NSArray *itemTitleArray = @[@"首页", @"书柜", @"发现", @"我的"];
    NSArray *itemImageNameArray = @[@"Home", @"Book", @"Find", @"Mine"];
    
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger index = 0; index < itemTitleArray.count; index++) {
        NSString *title = itemTitleArray[index];
        NSString *normalImagePath = [NSString stringWithFormat:@"%@_Normal", itemImageNameArray[index]];
        UIImage *normalImage = [UIImage imageNamed:normalImagePath];
        NSString *highlightedImagePath = [NSString stringWithFormat:@"%@_Highlighted", itemImageNameArray[index]];
        UIImage *highlightedImage = [UIImage imageNamed:highlightedImagePath];
        [items addObject:@{ @"Title": title, @"Image": normalImage, @"SelectedImage": highlightedImage }];
    }
    
    [self setupTabBarItem:items];
    
    // 字体
    UIFont *font = [UIFont systemFontOfSize:11];
    [self setNormalFont:font];
    [self setSelectedFont:font];
    
    // 默认颜色
    UIColor *normanlColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    [self setNormalColor:normanlColor];
    
    // 选中颜色
    UIColor *selectedColor = [UIColor colorWithRed:24/255.0 green:129/255.0 blue:247/255.0 alpha:1];
    [self setSelectedColor:selectedColor];
    
    [self.customTabBar addCenterButton];
    // 调整凸出按钮和小红点的位置
    [self.customTabBar refreshCenterButton];
}

/**
 *  设置默认外观
 */
- (void)setDefaultTabBarAppearance{
    //分割线
       CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5);
       UIGraphicsBeginImageContext(rect.size);
       CGContextRef context = UIGraphicsGetCurrentContext();
       CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.8 alpha:1].CGColor);
       CGContextFillRect(context, rect);
       UIImage *shadowImage = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       
       // 自定义的tabBar替换掉系统自带的tabBar
       self.customTabBar = [[SCBCustomTabBar alloc] init];
       self.customTabBar.customTabBarDelegate = self;
       self.customTabBar.backgroundImage = [[UIImage alloc] init];
       self.customTabBar.shadowImage = shadowImage;
       [self setValue:self.customTabBar forKey:@"tabBar"];
       
       // 默认字体
       self.normalFont = [UIFont systemFontOfSize:11.0];
       // 默认颜色
       self.normalColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
       // 选中字体
       self.selectedFont = [UIFont systemFontOfSize:11.0];
       // 默认选中颜色
       self.selectedColor = [UIColor colorWithRed:0.00 green:0.40 blue:1.00 alpha:1.00];
}

#pragma mark - SCBCustomTabBarDelegate
- (void)tabBarDidClickCenterButton:(SCBCustomTabBar *)tabBar {
    
}

/**
 *  设置 TabBarItem
 *
 *  @param items       数组
 */
- (void)setupTabBarItem:(NSArray *)items{
    // 图片选中颜色不透明
    self.customTabBar.tintColor = [UIColor colorWithRed:0.00 green:0.40 blue:1.00 alpha:1.00];
    
    NSInteger index = 0;
    for (UITabBarItem *item in self.customTabBar.items) {
        if (index >= items.count) {
            break;
        }
        
        NSDictionary *dict = items[index];
        NSString *title = dict[@"Title"];
        UIImage *image = dict[@"Image"];
        UIImage *selectedImage = dict[@"SelectedImage"];
        
        [item setTitle:title];
        [item setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        item.titlePositionAdjustment = UIOffsetMake(0.0, LZY_IS_IPHONEX ? 3.0 : -3.0);
        
        index++;
    }
}


/**
 *  TabBarItem 文字默认字体
 *
 *  @param normalFont normalFont description
 */
- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    
    [self setTabBarItemAttributes];
}

/**
 *  TabBarItem 文字选中字体
 *
 *  @param selectedFont selectedFont description
 */
- (void)setSelectedFont:(UIFont *)selectedFont {
    _selectedFont = selectedFont;
    
    [self setTabBarItemAttributes];
}

/**
 *  TabBarItem 文字默认颜色
 *
 *  @param normalColor normalColor description
 */
- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    
    [self setTabBarItemAttributes];
}

/**
 *  TabBarItem 文字选中颜色
 *
 *  @param selectedColor selectedColor description
 */
- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    
    [self setTabBarItemAttributes];
}

/**
 *  设置 TabBarItem 字体与颜色
 */
- (void)setTabBarItemAttributes {
    for (UITabBarItem *item in self.customTabBar.items) {
        [item setTitleTextAttributes:@{ NSFontAttributeName: self.normalFont, NSForegroundColorAttributeName: self.normalColor } forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{ NSFontAttributeName: self.selectedFont, NSForegroundColorAttributeName: self.selectedColor } forState:UIControlStateSelected];
    }
}
@end
