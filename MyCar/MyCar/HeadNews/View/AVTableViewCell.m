//
//  AVTableViewCell.m
//  MyCar
//
//  Created by 🐵 on 16-5-23.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "AVTableViewCell.h"



@interface AVTableViewCell ()


//@property (nonatomic,strong) NewsCellModel * model;
@end

@implementation AVTableViewCell

//-(instancetype)initWithFrame:(CGRect)frame


-(void)loadAvFromModel:(NewsCellModel *)model{
    if (model == nil) {
        return;
    }
//     _model =model;
   
    [_IV sd_setImageWithURL:[NSURL URLWithString:model.picCover] placeholderImage:nil];
    _IV.userInteractionEnabled =YES;
    [self.View bringSubviewToFront:_IV];
    if (model.src) {
        _srcLabel.text = model.src;
    }else{
        
        _srcLabel.text = model.mediaName;
    }

    _titleLabel.text = model.title;
    _titleLabel.textColor = [UIColor whiteColor];
    _countLabel.text = [NSString stringWithFormat:@"%d",model.commentCount];
    
     _visitLabel.text = [NSString stringWithFormat:@"%d",model.totalvisit];
    _durationLabel.text = model.duration;

    
//     UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    btn.layer.cornerRadius = btn.frame.size.width/2.0;
//    btn.layer.masksToBounds = YES;
//    [btn setBackgroundImage:[UIImage imageNamed:@"播放.png"] forState:UIControlStateNormal];
//     btn.center = _View.center;
//     btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [_IV addSubview:btn];
    
    
}

#pragma mark ---createPlayer
//- (void)createPlayer{
//    _player = [[MPMoviePlayerController alloc]init];
//    _player.view.frame = _View.frame;
//    
//    //    播放界面的适配
//    _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    //    根据俯视图大小变化 自由的宽 高
//    [self.View addSubview:_player.view];
//    
//}

//- (void)btnClicked:(UIButton *)btn{
//
//    [_player play];
//    
//    _IV.hidden =YES;
//    
//    _titleLabel.hidden =YES;
//
//    _durationLabel.hidden = YES;
//}
- (void)awakeFromNib {
    // Initialization code
    
    [_IV addSubview:_titleLabel];
    [_IV addSubview:_durationLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
