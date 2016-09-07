//
//  Top520ViewController.m
//  Movie
//
//  Created by CYC on 16/4/18.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "Top520ViewController.h"
#import "JSONObject.h"
#import "TopModel.h"
#import "TopCollectionViewCell.h"
#import "CellViewController.h"

#define TopCellID @"TopCellID"


@interface Top520ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {

    NSMutableArray *_topModels;

}

@end

@implementation Top520ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //1.加载数据
    [self _loadData];
    //2.创建集合视图
    [self _creatCollectionView];
    
}

#pragma mark - 加载数据
- (void)_loadData {
    
    //解析JSON文件
    NSDictionary *JSONDic = [JSONObject loadData:@"top250"];
    //加载JSON字典中的subjects数组
    NSArray *subjects = JSONDic[@"subjects"];
    //实例化topModels
    _topModels = [NSMutableArray array];
    
    //循环取出subjects里的数据
    for (NSDictionary *dic in subjects) {
        //建一个model对象存数据
        TopModel *model = [[TopModel alloc] init];
        //从subjects里取出数据,下面这个方法会自动根据对象键值取出数据,但是由于subjects里面键存在关键字，需复写setvalue：forunderfinedkey方法
        [model setValuesForKeysWithDictionary:dic];
        //将获取数据后的model存到可变数组里
        [_topModels addObject:model];
    }

}
#pragma mark - 创建集合视图
- (void)_creatCollectionView {

    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    float width = (kScreenWidth - 10*4)/3;
    float height = width + 50;
    flowLayout.itemSize = CGSizeMake(width, height);
    //2.创建集合视图
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight - buttonHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    //3.设置代理，签协议
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //4.注册单元格(子类化)
    [collectionView registerClass:[TopCollectionViewCell class] forCellWithReuseIdentifier:TopCellID];
    //5.实现协议方法
    

}

#pragma mark - 集合视图代理方法
//返回单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _topModels.count;

}
//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建单元格
    TopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TopCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    //将数据传给子类化的cell里
    cell.topCellModel = _topModels[indexPath.item];
    return cell;

}
//设置白边
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, 10, 10, 10);

}

//点击单元格响应
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    //创建视图控制器
    CellViewController *cellViewController = [[CellViewController alloc] init];
    [self.navigationController pushViewController:cellViewController animated:YES];

}




@end
