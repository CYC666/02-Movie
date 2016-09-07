//
//  NewsTableViewCell.m
//  Movie
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"
enum NewsType{
    kWordType,
    kImageType,
    kVideoType
};

@implementation NewsTableViewCell


- (void)setNewsModel:(NewsModel *)newsModel {

    _newsModel = newsModel;
    
//刷新数据
    //新闻图片
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.image]];
    //类型图片
    if ([_newsModel.type integerValue] == kWordType ) {
        _typeImageView.image = nil;
    }else if ([_newsModel.type integerValue] == kImageType){
        _typeImageView.image = [UIImage imageNamed:@"sctpxw"];
    }else if ([_newsModel.type integerValue] == kVideoType){
        _typeImageView.image = [UIImage imageNamed:@"scspxw"];
    }
    //标题
    _titleLabel.text = _newsModel.title;
    //概述
    _summaryLabel.text = _newsModel.summary;

}








@end
