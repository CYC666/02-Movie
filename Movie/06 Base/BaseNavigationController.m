//
//  BaseNavigationController.m
//  Movie
//
//  Created by CYC on 16/4/18.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//1、给导航栏设置背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all-64"] forBarMetrics:UIBarMetricsDefault];
    
//2、修改状态栏字体(复写方法)
    
//3、修改导航栏字体
    //3.1方法一
    //self.navigationBar.barStyle = UIBarStyleBlack;      //黑底白字、白底黑字(默认)
    //3.2方法二 修改字体属性

    NSDictionary *attributesDic = @{
                                    NSForegroundColorAttributeName:[UIColor whiteColor],
                                    NSFontAttributeName:[UIFont systemFontOfSize:22],
                                    };
    self.navigationBar.titleTextAttributes = attributesDic;
    //3.3方法三 自定义，在子类里自定义
    
//4、设置透明度
    self.navigationBar.translucent = NO;
    
    
}

//修改状态栏字体的显示样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}











@end
