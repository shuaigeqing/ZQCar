//
//  HotTableViewCell.h
//  MyCar
//
//  Created by 🐵 on 16-5-26.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSModel.h"

@interface HotTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *authorLabel;

@property (strong, nonatomic) IBOutlet UILabel *forumNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;

- (void)loadDataFromModel:(BBSModel *)model;


@end
