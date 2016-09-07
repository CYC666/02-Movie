//
//  TopHeaderCellView.m
//  Movie
//
//  Created by CYC on 16/4/25.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "TopHeaderCellView.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "BaseNavigationController.h"

@implementation TopHeaderCellView


- (void)setTopHeaderModel:(TopHeaderModel *)topHeaderModel {

    _topHeaderModel = topHeaderModel;
    
    //图片
    [_topHeaderCellImageView sd_setImageWithURL:[NSURL URLWithString:_topHeaderModel.image]];
    //电影标题
    _titleLabel.text = _topHeaderModel.titleCn;
    //导演
    _directors.text = _topHeaderModel.directors[0];
    //类型
    _type.text = [NSString stringWithFormat:@"%@  %@  %@  %@", _topHeaderModel.type[0],_topHeaderModel.type[1],_topHeaderModel.type[2],_topHeaderModel.type[3]];
    //区域和时间
    _detialRelease.text = [NSString stringWithFormat:@"%@  %@", _topHeaderModel.detialRelease[@"location"], _topHeaderModel.detialRelease[@"date"]];
    
    //滑动视图
    NSArray *images = _topHeaderModel.images;
    //定义每一张图片的宽度
    float width = _imagesScrollView.size.width/4;
    //定义内容尺寸
    _imagesScrollView.contentSize = CGSizeMake(width*images.count+30, _imagesScrollView.height);
    _imagesScrollView.showsHorizontalScrollIndicator = NO;
    //在滑动视图上添加图片
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(width+3), 0, width, _imagesScrollView.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_topHeaderModel.images[i]]];
        [_imagesScrollView addSubview:imageView];
    }

}

//播放按钮响应
- (IBAction)playButton:(UIButton *)sender {
    //获取当前view对应的导航器
    BaseNavigationController *baseNavigationController = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[2];
    //创建播放器
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/06/21/mp4/120621112404690593.mp4"]];
    //在另一个界面开始播放
    [baseNavigationController presentMoviePlayerViewControllerAnimated:player];
    
}




















@end
