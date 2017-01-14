//
//  BaseHeadNewsViewController.h
//  MyCar
//
//  Created by 🐵 on 16-5-20.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopScrollView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface BaseHeadNewsViewController : UIViewController

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) NSMutableArray * buttonArr;

@property (nonatomic,copy) NSString * url;

@property (nonatomic,copy) NSString * buttonURL;

@property (nonatomic,strong) TopScrollView * topScroll;

@property (nonatomic,assign) int page;

@property (nonatomic,assign) int choose;

@property (nonatomic,strong) MPMoviePlayerController * player;


- (void)setMyUrl;

- (void)loadData;
@end
