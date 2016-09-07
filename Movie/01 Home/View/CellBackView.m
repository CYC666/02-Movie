//
//  CellBackView.m
//  Movie
//
//  Created by CYC on 16/4/21.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "CellBackView.h"
#import "UIImageView+WebCache.h"


@implementation CellBackView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self != nil) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"CellBackView" owner:self options:nil] firstObject];
        
        
    }
    return self;
}


- (void)setCellBackViewModel:(MovieModel *)cellBackViewModel {

    _cellBackViewModel = cellBackViewModel;
    
    _MovieLabel.text = _cellBackViewModel.title;
    _ratingLabel.text = [NSString stringWithFormat:@"评分:%.1f", [_cellBackViewModel.rating[@"average"] floatValue]];
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@", _cellBackViewModel.year];
    
    NSURL *url = [NSURL URLWithString:_cellBackViewModel.images[@"large"]];
    [_cellBackImageView sd_setImageWithURL:url];
    
    _starView.rating = [_cellBackViewModel.rating[@"average"] floatValue];
    
    

}





////刷新数据
//- (void)layoutSubviews {    //后面的view会重现，很奇怪
//
//    _MovieLabel.text = _cellBackViewModel.title;
//    _ratingLabel.text = [NSString stringWithFormat:@"评分:%.1f", [_cellBackViewModel.rating[@"average"] floatValue]];
//    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@", _cellBackViewModel.year];
//    
//    NSURL *url = [NSURL URLWithString:_cellBackViewModel.images[@"medium"]];
//    [_cellBackImageView sd_setImageWithURL:url];
//
//}


@end
