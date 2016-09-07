//
//  StarView.m
//  Movie
//
//  Created by CYC on 16/4/20.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "StarView.h"
#import "UIViewExt.h"

@interface StarView () {

    UIImageView *_grayView;
    UIImageView *_yellowView;
    
}

@end

@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self != nil) {
        
        [self _creatStarView];
        
    }
    
    return self;

}

//nib 文件初始化 (初始化nib 文件的时候就会自动调用这个方法)
- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self _creatStarView];
}



//创建星星视图
- (void)_creatStarView {

    //星星图标
    UIImage *grayImage = [UIImage imageNamed:@"gray"];
    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
    //灰色视图
    _grayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    [self addSubview:_grayView];
    
    //黄色视图
    _yellowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    [self addSubview:_yellowView];
    
    //根据比例对星星视图进行缩放
    float scale = self.frame.size.height / _grayView.frame.size.height;
    _grayView.transform = CGAffineTransformMakeScale(scale, scale);
    _yellowView.transform = CGAffineTransformMakeScale(scale, scale);
    
    //重新设定星星视图的位置(使用第三方框架)
    _grayView.origin = CGPointZero;
    _yellowView.origin = CGPointZero;

}


- (void)setRating:(float)rating {

    //根据评分调整黄色星星数量
    _rating = rating;
    _yellowView.width = _grayView.width * (rating / 10.0);

}










@end
