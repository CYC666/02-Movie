//
//  LargeCell.h
//  Movie
//
//  Created by CYC on 16/4/20.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface LargeCell : UICollectionViewCell

@property (strong, nonatomic)MovieModel *largeCellModel;

- (void)buttonAction:(UIButton *)button;    //翻转单元格

- (void)resetCell;      //重置单元格状态

@end
