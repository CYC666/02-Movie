//
//  CellViewController.m
//  Movie
//
//  Created by CYC on 16/4/25.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "CellViewController.h"
#import "TopTableViewCell.h"
#import "TopCellModel.h"
#import "JSONObject.h"
#import "TopHeaderCellView.h"
#import "TopHeaderModel.h"


#define TopTableViewCellID @"TopTableViewCellID"

@interface CellViewController () <UITableViewDataSource, UITableViewDelegate> {

    NSMutableArray *_topCellModels;
    NSIndexPath *_selectedIndexPath;
    UITableView *_tableView;
    TopHeaderModel *_topHeaderCellModel;
    
}

@end

@implementation CellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建表视图
    [self _creatTableView];
    //创建头视图
    [self _creatHeaderView];
    
    
}

- (void)_creatTableView {

    //1.创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight)];
    [self.view addSubview:_tableView];
    //2.设置代理，签协议
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //3.注册单元格
    [_tableView registerNib:[UINib nibWithNibName:@"TopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TopTableViewCellID];
    //4.加载数据
    [self _loadData];
    //5.实现代理方法创建单元格
}

- (void)_loadData {
    
    //获取JSON文件中的字典
    NSDictionary *JSONDic = [JSONObject loadData:@"movie_comment"];
    //获取字典中的有用信息，数组
    NSArray *list = JSONDic[@"list"];
    //实例化可变数组
    _topCellModels = [NSMutableArray array];
    
    for (NSDictionary *dic in list) {
        
        TopCellModel *model = [[TopCellModel alloc] init];
        //将数据存到model里
        model.userImage = dic[@"userImage"];
        model.nickname = dic[@"nickname"];
        model.rating = dic[@"rating"];
        model.content = dic[@"content"];
        //将存好数据后的model，添加到数组中
        [_topCellModels addObject:model];
    }
    
    //解析头视图的数据
    NSDictionary *headerDic = [JSONObject loadData:@"movie_detail"];
    _topHeaderCellModel = [[TopHeaderModel alloc] init];
    [_topHeaderCellModel setValuesForKeysWithDictionary:headerDic];

}

#pragma mark - 表视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _topCellModels.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopTableViewCellID forIndexPath:indexPath];
    //将数据传给cell
    cell.topCellModel = _topCellModels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//选中某个单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //保存点击的单元格
    _selectedIndexPath = indexPath;
    //点击哪个单元格，就刷新哪个单元格的数据
    [tableView reloadRowsAtIndexPaths:@[_selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    //一刷新就会走单元格高度确定的方法

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //根据字数调整label高度
    TopCellModel *model = _topCellModels[indexPath.row];
    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(260, 999)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{
                                                    NSFontAttributeName:[UIFont systemFontOfSize:14]
                                                        }
                                              context:nil];

    if (indexPath == _selectedIndexPath && rect.size.height + 50 > 80) {
    
        return rect.size.height + 80;
    }
    
    return 80;

}

#pragma mark - 创建头视图
- (void)_creatHeaderView {

    TopHeaderCellView *topHeaderCellView = [[[NSBundle mainBundle] loadNibNamed:@"TopHeaderCellView"
                                                                         owner:self
                                                                       options:nil] firstObject];
    topHeaderCellView.topHeaderModel = _topHeaderCellModel;     //将数据传递到头部视图子类里
    [_tableView setTableHeaderView:topHeaderCellView];

}













@end
