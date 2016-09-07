//
//  HeaderCell.m
//  Movie
//
//  Created by CYC on 16/4/23.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "HeaderCell.h"
#import "UIImageView+WebCache.h"

@interface HeaderCell () {

    UIImageView *_headerImageView;

}

@end

@implementation HeaderCell


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self != nil) {
        //创建图片视图
        _headerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_headerImageView];     //创建好的图像视图要添加到当前单元格视图里，不然显示不了奥
    }
    return self;

}

- (void)setHeaderCellModel:(MovieModel *)headerCellModel {

    _headerCellModel = headerCellModel;
    
    //刷新数据
    NSURL *url = [NSURL URLWithString:_headerCellModel.images[@"small"]];
    [_headerImageView sd_setImageWithURL:url];
    

}




@end
