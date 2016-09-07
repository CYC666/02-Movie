//
//  HomeTableViewCell.m
//  Movie
//
//  Created by CYC on 16/4/19.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"

@implementation HomeTableViewCell



- (void)layoutSubviews {
    
    //更新数据
    _movieLabel.text = _cellModel.title;    //标题
    _ratingLabel.text = [NSString stringWithFormat:@"评分:%.1f", [_cellModel.rating[@"average"] floatValue]];     //评分
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@", _cellModel.year];      //上映年份
    
    //网络加载图片
    NSURL *url = [NSURL URLWithString:_cellModel.images[@"medium"]];
    [_movieImageView sd_setImageWithURL:url];     //必须得导入第三方框架
    
    
    
    
//    //星星图标
//    UIImage *grayImage = [UIImage imageNamed:@"gray"];
//    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
//    //灰色视图
//    UIImageView *grayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
//    grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
//    [_ratingView addSubview:grayView];
//    
//    //黄色视图
//    UIImageView *yellowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
//    yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
//    [_ratingView addSubview:yellowView];
//    
//    //根据比例对星星视图进行缩放
//    float scale = _ratingView.frame.size.height / grayView.frame.size.height;
//    grayView.transform = CGAffineTransformMakeScale(scale, scale);
//    yellowView.transform = CGAffineTransformMakeScale(scale, scale);
//    
//    //重新设定星星视图的位置(使用第三方框架)
//    grayView.origin = CGPointZero;
//    yellowView.origin = CGPointZero;
    
//    //根据评分调整黄色星星数量
//    float rating = [_cellModel.rating[@"average"] floatValue] / 10.0;
//    yellowView.width = yellowView.width * rating;

    //星星
    _starView.rating = [_cellModel.rating[@"average"] floatValue];
    
    
    
    
    
    
    
}





@end
