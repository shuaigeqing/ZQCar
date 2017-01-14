//
//  TopScrollView.m
//  MyCar
//
//  Created by 🐵 on 16-5-21.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "TopScrollView.h"
#import "NewsCellModel.h"
#import "NewsDetailViewController.h"
#import "AppDelegate.h"
#import "BaseTabBarController.h"


@implementation TopScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        float width = self.bounds.size.width;
        float height =self.bounds.size.height;
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        
        _scrollView.contentSize =CGSizeMake(SCREEN_WIDTH * 3, self.bounds.size.height);
        
        _scrollView.pagingEnabled = YES;
        
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator =NO;
         [self addSubview:_scrollView];
        
        _pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(width-100, height-20, 100, 20)];
        _pageController.numberOfPages = 3;
        _pageController.currentPage =0;
        
        _pageController.currentPageIndicatorTintColor = [UIColor greenColor];
        
        [self addSubview:_pageController];
        
         [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timeRefresh:) userInfo:nil repeats:YES];

    }
    return self;
}

-(void)loadDataFromArray:(NSArray *)array{
    if (array.count <=0) {
        return ;
    }
    _dataArr = array;
    float width = self.bounds.size.width;
    float height =self.bounds.size.height;
    for (int i =0; i<3; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, 200)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 1000+i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicked:)];
        
        [imageView addGestureRecognizer:tap];
        NewsCellModel * model = array[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.picCover]];
        [_scrollView addSubview:imageView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(width * i, height-25, SCREEN_WIDTH, 25)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:0.5];
        label.font = [UIFont systemFontOfSize:18];
        label.text = model.title;
        [_scrollView addSubview:label];
        
    }



}

- (void)tapClicked:(UITapGestureRecognizer *)tap{
    if (_dataArr.count <=0) {
        return;
    }
    NewsDetailViewController * detail = [[NewsDetailViewController alloc]init];
    UIImageView * iv =(UIImageView *)tap.view;
    NSInteger index = iv.tag -1000;
    NewsCellModel * model = _dataArr[index];
    detail.NewsID = model.newsId;
    detail.choose = self.choose;
    detail.hidesBottomBarWhenPushed =YES;

    BaseTabBarController * tabBar = (BaseTabBarController *)self.window.rootViewController;
    UINavigationController * navi = [tabBar.viewControllers firstObject];
    [navi pushViewController:detail animated:YES];

}
- (void)timeRefresh:(NSTimer *)time{

    _page ++;
    
    if (_page>=3) {
        _page =0;
    }
    _scrollView.contentOffset =CGPointMake(self.bounds.size.width * _page, 0);
    
    _pageController.currentPage = _page;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
