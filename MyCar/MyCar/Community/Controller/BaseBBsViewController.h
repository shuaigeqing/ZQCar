//
//  BaseBBsViewController.h
//  MyCar
//
//  Created by 🐵 on 16-5-26.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

   BBSVIEW = 1,
    
    HOT,

}VIEW_TYPE;

@interface BaseBBsViewController : UIViewController

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,copy) NSString * url;

@property (nonatomic,assign) int page;

@property (nonatomic,assign)VIEW_TYPE type;

- (void)setMyUrl;

- (void)loadData;


@end
