//
//  BaseTabBarController.m
//  Movie
//
//  Created by CYC on 16/4/18.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "BaseTabBarController.h"

#import "MyTabBarButton.h"

@interface BaseTabBarController () {

    UIImageView *_selecteImage;

}

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //给标签栏创建按钮
    [self _creatTabBarButton];
    
    self.tabBar.translucent = NO;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    //在视图将要显示的时候移除原有的标签按钮
    [self _removeTabBarButton];

}


//移除标签栏原有的按钮
- (void)_removeTabBarButton {

    //查看subviews到底是什么、有些什么
    //NSLog(@"subviews = %@", self.tabBar.subviews);
    
    //自己定义一个要删除的类
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *view in self.tabBar.subviews) {
        
        //容错
        if ([view isKindOfClass:class]) {   //当view是我定义的那个类，那么就把它从它的父视图中移除
            [view removeFromSuperview];
        }
        
    }

}

//给标签栏自定义按钮
- (void)_creatTabBarButton {
    
    //给背景添加图片
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg_all"]];
    
    float buttonWidth = kScreenWidth / 5;
    
    //添加选中标签的背景
    _selecteImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectTabbar_bg_all"]];
    _selecteImage.frame = CGRectMake(0, 0, buttonWidth - 10, buttonHeight - 5);
    [self.tabBar addSubview:_selecteImage];

    
    //创建数组存标题的名称
    NSArray *buttonTitles = @[@"首页",@"新闻",@"Top520",@"影院",@"更多"];
    //创建数组存按钮图片的名字
    NSArray *buttonImagesName = @[@"movie_home",@"msg_new",@"start_top250",@"icon_cinema",@"more_setting"];
    
    for (int i = 0; i < 5; i ++) {
        
//        //创建标签栏上的按钮
//        UIButton *tabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        tabBarButton.frame = CGRectMake(i * buttonWidth , 0, buttonWidth, buttonHeight);
//        [tabBarButton setTitle:buttonTitles[i] forState:UIControlStateNormal];
//        [tabBarButton setImage:[UIImage imageNamed:buttonImagesName[i]] forState:UIControlStateNormal];
//        [tabBarButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:tabBarButton];
//        //设置按钮图片与标题的位置
//        tabBarButton.titleEdgeInsets = UIEdgeInsetsMake(20, -25, 0, 0);
//        tabBarButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 20, 0, 10);
//
        
        //创建 UIControl 对象(可以相应用户交互,是 UIView 的子类)
        //        UIControl *tabBarControl = [[UIControl alloc]initWithFrame:CGRectMake(i * buttonWidth , 0, buttonWidth, TabBarHeight)];
        //        [tabBarControl addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        //
        //        //创建UIControl对象上的图片
        //        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((tabBarControl.frame.size.width  - 30)/2, 3, 30, 20)];
        //        imageView.image = [UIImage imageNamed:buttonImages[i]];
        //        imageView.contentMode = UIViewContentModeScaleAspectFit;
        //        [tabBarControl addSubview:imageView];
        //        //创建UIControl对象上的标题
        //        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(imageView.frame) + 5, tabBarControl.frame.size.width, 21)];
        //        label.textAlignment = NSTextAlignmentCenter;
        //        label.textColor = [UIColor whiteColor];
        //        label.font = [UIFont systemFontOfSize:14];
        //        label.text = buttonTitles[i];
        //        [tabBarControl addSubview:label];
        //        
        //        [self.tabBar addSubview:tabBarControl];
        
        
        
        
    //通过将 UIContol子类化,一方面继承了 UIcontrol 可以相应用户点击的功能,另一方面将一些比较个性化的功能添加子类中
        MyTabBarButton *tabBarButton = [[MyTabBarButton alloc] initWithFrame:CGRectMake(i * buttonWidth , 0, buttonWidth, buttonHeight) withImage:buttonImagesName[i] withTitle:buttonTitles[i]];
        tabBarButton.tag = 1000 + i;
        [tabBarButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:tabBarButton];
        
        //控制选中标签的中心
        if (i == 0) {
            _selecteImage.center = tabBarButton.center;
        }
    }

}

//按钮的响应方法
- (void)buttonAction:(UIButton *)button {

    //NSLog(@"按钮按下了");
    //点击对应的按钮就跳转到对应控制的控制器
    self.selectedIndex = button.tag - 1000;
    //添加动画
    [UIView animateWithDuration:.35 animations:^{
        _selecteImage.center = button.center;
                                                }];

}





@end
