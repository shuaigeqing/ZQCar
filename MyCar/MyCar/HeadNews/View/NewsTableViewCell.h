//
//  NewsTableViewCell.h
//  MyCar
//
//  Created by 🐵 on 16-5-20.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCellModel.h"

@interface NewsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *srcLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;


- (void)loadDataFromModel:(NewsCellModel *)model;

@end
