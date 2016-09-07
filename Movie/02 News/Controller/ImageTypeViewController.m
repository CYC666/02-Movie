//
//  ImageTypeViewController.m
//  Movie
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "ImageTypeViewController.h"
#import "JSONObject.h"
#import "ImageModel.h"
#import "ImageCollectionViewCell.h"
#define ImageCollectionViewCellID @"ImageCollectionViewCellID"

@interface ImageTypeViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {

    NSMutableArray *_imageModels;

}

@end

@implementation ImageTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //加载数据
    [self _loadData];
    //创建集合视图
    [self _creatCollectionView];
    
    
}

#pragma mark - 加载数据
- (void)_loadData {

    NSArray *JSONArray = [JSONObject loadData:@"image_list"];
    _imageModels = [NSMutableArray array];
    for ( NSDictionary *dic in JSONArray) {
        ImageModel *model = [[ImageModel alloc] init];
        model.image = dic[@"image"];
        [_imageModels addObject:model];
    }

}

#pragma mark - 创建集合视图
- (void)_creatCollectionView {

    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (kScreenWidth - 5*10)/4;
    flowLayout.itemSize = CGSizeMake(width, width);
    //2.创建集合视图
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    //3.设置代理，签订协议
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //4.实现代理方法
    //注册单元格
    [collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ImageCollectionViewCellID];

}

#pragma mark - 代理方法
//单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageModels.count;
}
//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: ImageCollectionViewCellID forIndexPath:indexPath];
    cell.imageModel = _imageModels[indexPath.row];
    cell.layer.cornerRadius = 10;
    cell.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.layer.borderWidth = 3;
    return cell;
    
}
//设置白边大小
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

















@end
