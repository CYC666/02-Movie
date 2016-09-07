//
//  ImageCollectionViewCell.m
//  Movie
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"



@implementation ImageCollectionViewCell


- (void)setImageModel:(ImageModel *)imageModel {

    _imageModel = imageModel;
    //更新数据
    [_cellImageView sd_setImageWithURL:[NSURL URLWithString:_imageModel.image]];

}



@end
