//
//  PostView.m
//  Movie
//
//  Created by CYC on 16/4/20.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "PostView.h"
#import "LargeCollectionView.h"
#import "PostCollectionViewFlowLayout.h"
#import "HeaderCollectionView.h"
#import "MovieModel.h"



@interface PostView () {

    LargeCollectionView *_largeCollectionView;
    PostCollectionViewFlowLayout *_largeFlowLayout;
    UIImageView *_headerView;
    HeaderCollectionView *_headerCollectionView;
    UIControl *_maskView;
    UILabel *_movieTitle;
    
}

@end


@implementation PostView

//移除观察者
- (void)dealloc {

    [_largeCollectionView removeObserver:self forKeyPath:@"currentPage"];
    [_headerCollectionView removeObserver:self forKeyPath:@"currentPage"];

}


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor clearColor];
        [self _creatLargeCollection];   //创建集合视图
        [self _creatMaskView];          //创建遮罩视图
        [self _creatHeaderView];        //创建头视图
        [self _createGesture];          //创建手势
        [self _creatMovieTitle];        //创建底部电影标题
        
        //添加观察者，观察大海报视图跟小海报视图的currentPage
        [_largeCollectionView addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew context:nil];
        [_headerCollectionView addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

//观察者的响应方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    //查看值
    //NSLog(@"%@", change);
    
    //获取到监控到的最新的属性的变化之后的值
    NSInteger index = [change[@"new"] integerValue];
    NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    //修改底部电影标题
    MovieModel *model = _postMoviesData[index];
    _movieTitle.text = model.title;

    
    
    //如果大海报进行滑动的时候,小海报也会跟着进行滑动,小海报滑动,大海报进行滑动,这样引起循环引用,最终造成野指针的错误,\
    //解决方案: 当监控到滑动的时候,先判断一下变化的属性和自身一样不,如果不一样就滑动,如果一样就不进行滑动
    if ([object isKindOfClass:[LargeCollectionView class]] && _headerCollectionView.currentPage != index) {
        //让小的海报视图跟着一起动
        [_headerCollectionView scrollToItemAtIndexPath:itemIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //手动更新小视图的currentPage
        _headerCollectionView.currentPage = index;
        
    } else if ([object isKindOfClass:[HeaderCollectionView class]] && _largeCollectionView.currentPage != index) {
        //让大的海报视图跟着一起动
        [_largeCollectionView scrollToItemAtIndexPath:itemIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //手动更新大海报视图的currentPage
        _largeCollectionView.currentPage = index;
    }

}

//创建集合视图
- (void)_creatLargeCollection {

//1、创建布局对象
    _largeFlowLayout = [[PostCollectionViewFlowLayout alloc] init];
    
//2、创建集合视图
    //创建CGRact  宏定义视图的一些属性数值
    CGRect largeRect = CGRectMake(0, 50, kScreenWidth, kScreenHeight - NavigationBarHeight - buttonHeight - kMovieFooterViewHeight - kMovieHeaderViewHeight + 50);
    _largeCollectionView = [[LargeCollectionView alloc] initWithFrame:largeRect collectionViewLayout:_largeFlowLayout];
    _largeCollectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_largeCollectionView];
//3、签协议、设代理
//4、实现代理方法

}
//创建头视图
- (void)_creatHeaderView {
    
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kMovieHeaderViewOffSet, kScreenWidth,kMovieHeaderViewHeight)];
    //创建拉伸的头视图图片
    UIImage *image = [UIImage imageNamed:@"indexBG_home"];
    //拉伸图片
    UIImage *imageNew = [image stretchableImageWithLeftCapWidth:0 topCapHeight:4];
    //拉伸后的图片设置为头视图的图片
    _headerView.image = imageNew;
    
    //打开用户交互
    _headerView.userInteractionEnabled = YES;
    [self addSubview:_headerView];
    
    //创建 button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((kScreenWidth - 20)/2, kMovieHeaderViewHeight - 20, 20, 20);
    button.tag = 1000;
    [button setBackgroundImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:button];
    
    //创建头视图的集合视图
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kScreenWidth*0.2, kMovieHeaderViewOffSet);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _headerCollectionView = [[HeaderCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kMovieHeaderViewOffSet) collectionViewLayout:flowLayout];
    [_headerView addSubview:_headerCollectionView];
}
//头视图的伸缩
- (void)buttonAction:(UIButton *)button {
    
    if (button.selected == YES) {
        
        [self _hideHeaderView];

    } else {
    
        [self _showHeaderView];

    }
    
}
//显示视图
- (void)_showHeaderView {
    UIButton *button = [_headerView viewWithTag:1000];
    button.selected = YES;
    //头视图下移
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.35];
    _headerView.transform = CGAffineTransformMakeTranslation(0, kMovieHeaderViewOffSet);
    [UIView commitAnimations];
    //遮罩视图显示
    _maskView.hidden = NO;
}
//隐藏视图
- (void)_hideHeaderView {
    UIButton *button = [_headerView viewWithTag:1000];
    button.selected = NO;
    //头视图上移(复原状态)
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.35];
    _headerView.transform = CGAffineTransformMakeTranslation(0, 0);
    [UIView commitAnimations];
    //遮罩视图隐藏
    _maskView.hidden = YES;
    
}
//加载数据
- (void)setPostMoviesData:(NSArray *)postMoviesData {

    _postMoviesData = postMoviesData;
    
    //将数据传给集合视图
    _largeCollectionView.largeCollectionViewMoviesData = _postMoviesData;
    //将数据传给头视图
    _headerCollectionView.largeCollectionViewMoviesData = _postMoviesData;
    
    //设置刚加载数据时电影标题
    MovieModel *model = _postMoviesData[0];
    _movieTitle.text = model.title;
}
//遮罩视图
- (void)_creatMaskView {

    _maskView = [[UIControl alloc] initWithFrame:self.bounds];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:.3];
    _maskView.hidden = YES;
    [self addSubview:_maskView];
    
    [_maskView addTarget:self action:@selector(_hideHeaderView) forControlEvents:UIControlEventTouchUpInside];

}
//创建手势
- (void)_createGesture {
    //手势对象
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(_showHeaderView)];
    //手势
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;     //向下的手势
    [self addGestureRecognizer:swipeGesture];

}
//创建底部电影标题
- (void)_creatMovieTitle {

    _movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight - buttonHeight - 130, kScreenWidth, 50)];
    _movieTitle.textAlignment = NSTextAlignmentCenter;
    _movieTitle.font = [UIFont systemFontOfSize:22];
    _movieTitle.textColor = [UIColor orangeColor];
    [self addSubview:_movieTitle];

}















@end
