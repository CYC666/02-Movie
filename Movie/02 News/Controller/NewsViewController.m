//
//  NewsViewController.m
//  Movie
//
//  Created by CYC on 16/4/18.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "JSONObject.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#import "WordTypeViewController.h"
#import "ImageTypeViewController.h"
#define NewsTableViewCellID @"NewsTableViewCellID"
enum NewsType{
    kWordType,
    kImageType,
    kVideoType
};

@interface NewsViewController () <UITableViewDataSource, UITableViewDelegate> {

    NSMutableArray *_newsModels;
    UITableView *_newsTableView;
    UIImageView *_headerImageView;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //1.加载数据
    [self _loadData];
    //2.创建表视图
    [self _creatTabelView];
    //3.创建头部放大视图
    [self _pushDownImage];
    
    
    
    
    
    
    
    
    
    
}


#pragma mark - 创建表视图
- (void)_creatTabelView {

    //1.创建表视图
//    UITableView *newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight)];//错误
    _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight - buttonHeight) style:UITableViewStylePlain];
    [self.view addSubview:_newsTableView];
    //2.设置代理，签协议
    _newsTableView.dataSource = self;
    _newsTableView.delegate = self;
    //3.注册单元格(子类化)
    [_newsTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell"
                                              bundle:[NSBundle mainBundle]]
        forCellReuseIdentifier:NewsTableViewCellID];

    //4.实现代理方法
}


#pragma mark - 加载数据
- (void)_loadData {

    NSArray *JSONArray = [JSONObject loadData:@"news_list"];
    _newsModels = [NSMutableArray array];
    for (NSDictionary *dic in JSONArray) {
        NewsModel *model = [[NewsModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_newsModels addObject:model];
    }

}

#pragma mark - 表视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _newsModels.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsTableViewCellID forIndexPath:indexPath];
    cell.newsModel = _newsModels[indexPath.row];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;

}

#pragma mark - 头部放大视图
- (void)_pushDownImage {
    //创建头视图(不起显示的作用,用来设置头视图的初始高度)
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    _newsTableView.tableHeaderView = headerView;
    //表视图头视图上覆盖的图片
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    NewsModel *pushDownModel = _newsModels[0];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:pushDownModel.image]];
    [self.view addSubview:_headerImageView];
    //删除第一条 数据
    if (_newsModels.count > 0) {
        [_newsModels removeObjectAtIndex:0];
        [_newsTableView reloadData];
    }
    

}

#pragma mark - 头部视图的放大功能
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 0) {  //视图上拉
        _headerImageView.top = -offset;     //头视图向上平移
    } else if (offset < 0) {    //视图下拉
        //获取图片的新高度
        CGFloat newHeight = 200 + ABS(offset);
        //同比例放大宽度
        CGFloat newWidth = newHeight*(kScreenWidth / 200);
        //给头部图片视图设置新的frame
        _headerImageView.frame = CGRectMake(-(newWidth - kScreenWidth)/2, 0, newWidth, newHeight);
    }

}

#pragma mark - 根据单元格不同，加载不同视图控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NewsModel *model = _newsModels[indexPath.row];
    NSInteger type = [model.type integerValue];
    if (type == kWordType) {
        //转到另一个视图控制器
        WordTypeViewController *wordTypeViewController = [[WordTypeViewController alloc] init];
        //然后隐藏标签栏
        wordTypeViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wordTypeViewController animated:YES];

    } else if (type == kImageType) {
        //转到另一个视图控制器
        ImageTypeViewController *imageTypeViewController = [[ImageTypeViewController alloc] init];
        //然后隐藏标签栏
        imageTypeViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:imageTypeViewController animated:YES];
        
    } else if (type == kVideoType) {
        
    }

}











@end
