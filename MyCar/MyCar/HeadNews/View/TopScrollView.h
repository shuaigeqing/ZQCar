//
//  TopScrollView.h
//  MyCar
//
//  Created by 🐵 on 16-5-21.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopScrollView : UIView

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIPageControl * pageController;
@property (nonatomic,assign) int page;

@property (nonatomic,strong) NSArray * dataArr;

@property (nonatomic,assign) int choose;


- (void) loadDataFromArray:(NSArray *)array;
@end
