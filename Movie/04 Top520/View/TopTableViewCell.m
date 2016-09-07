//
//  TopTableViewCell.m
//  Movie
//
//  Created by CYC on 16/4/25.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "TopTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation TopTableViewCell


- (void)setTopCellModel:(TopCellModel *)topCellModel {

    _topCellModel = topCellModel;
    
    //更新数据
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_topCellModel.userImage]];
    _nickName.text = _topCellModel.nickname;
    _rating.text = [NSString stringWithFormat:@"%.1f", [_topCellModel.rating floatValue]];
    _content.text = _topCellModel.content;
}




@end
