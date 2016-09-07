//
//  LargeCell.m
//  Movie
//
//  Created by CYC on 16/4/20.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "LargeCell.h"
#import "UIImageView+WebCache.h"    //导入第三方框架
#import "CellBackView.h"

@interface LargeCell () {

    UIImageView *_postImageView;
    CellBackView *_backView;
//    UIButton *_button;      //单元格上面的按钮

}

@end

@implementation LargeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
//        self.contentView.backgroundColor = [UIColor colorWithRed:0.502 green:0.000 blue:0.502 alpha:1.000];   //单元格背景颜色
        
        [self _creatSubviews];
    }
    return self;
}

//创建子视图
- (void)_creatSubviews {

    //图片视图
    _postImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_postImageView];
    _postImageView.hidden = NO;     //起始显示
    
    //背部详情视图
    _backView = [[CellBackView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_backView];
    _backView.hidden = YES;     //起始隐藏
    _backView.layer.cornerRadius = 6;
    _backView.layer.borderWidth = 4;    //边框
    _backView.layer.borderColor = [UIColor orangeColor].CGColor;
    
    
//    //视图上面的按钮
//    _button = [UIButton buttonWithType:UIButtonTypeCustom];
//    _button.frame = self.bounds;
//    [self.contentView addSubview:_button];
//    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

//在调用set方法的时候加载数据
- (void)setLargeCellModel:(MovieModel *)largeCellModel {

    _largeCellModel = largeCellModel;
    
    //将数据传递给CellBackView
    _backView.cellBackViewModel = _largeCellModel;
    
    
    //查看数据是否已经成功加载
    //NSLog(@"_largeCellModel = %@", _largeCellModel);
    
    //通过第三方框架，用URL方式从网络获取图片，给海报上图片
    NSURL *url = [NSURL URLWithString:_largeCellModel.images[@"large"]];
    [_postImageView sd_setImageWithURL:url];

}






//翻转单元格视图
- (void)buttonAction:(UIButton *)button {
    
    UIViewAnimationOptions options = _backView.hidden ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft;

    [UIView transitionWithView:self
                      duration:.35
                       options:options
                    animations:^{
                        _backView.hidden = !_backView.hidden;
                        _postImageView.hidden = !_postImageView.hidden;
                    }
                    completion:^(BOOL finished) {
                        ;
                    }];
    

}

//重置cell状态
- (void)resetCell {

    _postImageView.hidden = NO;
    _backView.hidden = YES;
    
}









@end
