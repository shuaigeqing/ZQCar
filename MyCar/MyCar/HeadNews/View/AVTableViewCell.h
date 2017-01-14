//
//  AVTableViewCell.h
//  MyCar
//
//  Created by 🐵 on 16-5-23.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCellModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AVTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *View;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *srcLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UILabel *visitLabel;

@property (strong, nonatomic) IBOutlet UIImageView *IV;

@property (strong, nonatomic) IBOutlet UILabel *durationLabel;

@property (nonatomic,strong) MPMoviePlayerController * player;
- (void)loadAvFromModel:(NewsCellModel *)model;

@end
