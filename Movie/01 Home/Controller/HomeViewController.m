//
//  HomeViewController.m
//  Movie
//
//  Created by CYC on 16/4/18.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "HomeViewController.h"
#import "MovieModel.h"
#import "JSONObject.h"
#import "HomeTableViewCell.h"
#import "PostView.h"

#define CellID @"CYC666"



@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate> {

    //导航栏右边按钮
    UIView *_backgroundView;
    UIButton *_button1;
    UIButton *_button2;
    
    //中部视图
    PostView *_postView;
    UITableView *_listView;
    NSMutableArray *_moviesData;     //model数组
    

}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//1、背景颜色

    
//2、自定义导航栏标题视图
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];    //frame，长度无关紧要，超出设置还能显示,但是高度是必须的
    titleLabel.text = @"首页";                           //label文本内容
    titleLabel.textColor = [UIColor whiteColor];        //字体颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;   //居中
    titleLabel.font = [UIFont systemFontOfSize:22];     //字体大小
    self.navigationItem.titleView = titleLabel;         //设置label为导航栏标题
    // [self.navigationItem.titleView addSubview:titleLabel];       //错误，不行
    
    //6、加载数据
    [self _loadData];
    
//3、给导航栏右边添加按钮
    [self _creatRightButton];

//4、添加海报视图
    [self _creatPostView];
    
//5、添加列表视图
    [self _creatListView];
    
}

#pragma mark - 创建右边按钮
- (void)_creatRightButton {

    //背景视图
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    UIBarButtonItem *backgroundView = [[UIBarButtonItem alloc] initWithCustomView:_backgroundView]; //转型
    self.navigationItem.rightBarButtonItem = backgroundView;
    //按钮一
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame = CGRectMake(1, 2, 48, 26);
    [_button1 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [_button1 setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateNormal];
    _button1.hidden = NO;  //起始显示
    [_backgroundView addSubview:_button1];
    [_button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
 
    //按钮二
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button2.frame = CGRectMake(1, 2, 48, 26);
    [_button2 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [_button2 setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    _button2.hidden = YES;   //起始隐藏
    [_backgroundView addSubview:_button2];
    [_button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 创建海报视图
- (void)_creatPostView {

    _postView = [[PostView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - buttonHeight - NavigationBarHeight)];
    _postView.hidden = NO;     //起始显示
    
    //将数据传到海报视图
    _postView.postMoviesData = _moviesData;
//    _postView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_postView];
    
}

#pragma mark - 创建列表视图
- (void)_creatListView {

    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - buttonHeight - NavigationBarHeight)
                                             style:UITableViewStylePlain];

//    _listView.backgroundColor = [UIColor yellowColor];
    _listView.hidden = YES;      //起始隐藏
    [self.view addSubview:_listView];
    
    
    //设置代理
    _listView.dataSource = self;
    _listView.delegate = self;
    
    //注册单元格
    [_listView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID];
    

}

#pragma mark - 右边按钮响应
- (void)buttonAction:(UIButton *)sender {
    
//1、按钮的翻转
    //创建翻转变量
    UIViewAnimationOptions optionsA = _button1.hidden ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft;
    [UIView transitionWithView:_backgroundView
                      duration:.5
                       options:optionsA
                    animations:^{       //动画过程中要做的事
                        _button1.hidden = !_button1.hidden;
                        _button2.hidden = !_button2.hidden;
                    }
                    completion:^(BOOL finished) {
                        ;               //动画完成后要做的事
                    }];
//2、主视图的翻转
    UIViewAnimationOptions optionsB = _button1.hidden ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionWithView:self.view
                      duration:.5
                       options:optionsB
                    animations:^{
                        _postView.hidden = !_postView.hidden;
                        _listView.hidden = !_listView.hidden;
                    }
                    completion:^(BOOL finished) {
                        ;
                    }];
    //注意:为了使底部去除白底，应该在标签栏将标签栏设置成不透明
    
}

#pragma mark - 解析JSON、加载数据
- (void)_loadData {

////1、获取boundls包中JSON的文件路径
//    NSString *JSONPath = [[NSBundle mainBundle] pathForResource:@"new_movie" ofType:@"json"];
////2、将路径中的JSON转化成二进制文件
//    NSData *JSONData = [NSData dataWithContentsOfFile:JSONPath];
////3、将二进制文件转成对象
//    NSDictionary *JSONDic = [NSJSONSerialization JSONObjectWithData:JSONData
//                                                            options:NSJSONReadingMutableContainers
//                                                              error:nil];
    
    NSDictionary *JSONDic = [JSONObject loadData:@"new_movie"];
    
//4、查看取出的内容是什么,不应该这样子打印查看，会出现编码问题
    //NSLog(@"%@", JSONDic);
    
    //从字典中取出subjects数组
    NSArray *subjects = JSONDic[@"subjects"];

//5、创建model存储json数据
    _moviesData = [NSMutableArray array];
    
    for (NSDictionary *dic in subjects) {
        MovieModel *movieModel = [[MovieModel alloc] init];
        //存储数据
        movieModel.rating = dic[@"rating"];
        movieModel.genres = dic[@"genres"];
        movieModel.title = dic[@"title"];
        movieModel.collect_count = [dic[@"collect_count"] integerValue];    //将对象转化成基本数据类型
        movieModel.original_title = dic[@"original_title"];
        movieModel.year = dic[@"year"];
        movieModel.images = dic[@"images"];
        
        [_moviesData addObject:movieModel];     //讲取出数据的model存到数组中
        
    }
    
    //查看取出数据后的model对象
    //NSLog(@"%@", moviesModel);

}

#pragma mark - 表视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _moviesData.count;   //model的个数就是单元格的个数

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    //选中效果为 无
    
    cell.cellModel = _moviesData[indexPath.row];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;

}











@end
