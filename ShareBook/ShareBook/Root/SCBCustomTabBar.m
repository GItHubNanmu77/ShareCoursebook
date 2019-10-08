//
//  SCBCustomTabBar.m
//  ShareBook
//
//  Created by cisdi on 2019/10/8.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "SCBCustomTabBar.h"

@interface SCBCustomTabBar ()

@property (nonatomic, strong) UIButton *btnCenter;

@end

@implementation SCBCustomTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.barTintColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self refreshCenterButton];
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonIndex = 0;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            CGRect subviewRect = subview.frame;
            subviewRect.size.width = buttonW;
            subviewRect.origin.x = buttonIndex * buttonW;
            subview.frame = subviewRect;
            
            buttonIndex++;
            if (buttonIndex == 2) {
                buttonIndex++;
            }
        }
    }
}

- (void)refreshCenterButton {
    
    [self bringSubviewToFront:self.btnCenter];

    self.btnCenter.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 7.5);
    CGRect temp = self.btnCenter.frame;
    temp.size.width = self.frame.size.width / 5;
    temp.size.height = self.frame.size.height;
    temp.origin.y = -15.0;
    self.btnCenter.frame = temp;
//    self.btnCenter.y = LZY_IS_IPHONEX ? - 15.0 : 0.0;
}

- (void)addCenterButton {
    self.btnCenter = [[UIButton alloc]init];
    [self.btnCenter setImage:[UIImage imageNamed:@"Publish_Normal"] forState:UIControlStateNormal];
    [self.btnCenter setImage:[UIImage imageNamed:@"Publish_Highlighted"] forState:UIControlStateSelected];
    [self.btnCenter addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnCenter];
}


- (void)pressedButton:(UIButton *)sender {
    if (self.customTabBarDelegate && [self.customTabBarDelegate respondsToSelector:@selector(tabBarDidClickCenterButton:)]) {
        [self.customTabBarDelegate tabBarDidClickCenterButton:self];
    }
}

@end
