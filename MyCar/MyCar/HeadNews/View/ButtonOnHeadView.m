//
//  ButtonOnHeadView.m
//  MyCar
//
//  Created by 🐵 on 16-5-22.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import "ButtonOnHeadView.h"

@implementation ButtonOnHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    float width = self.bounds.size.width;
    _ImageView=[[UIImageView alloc]initWithFrame:CGRectMake(width/3.0, width/10.0, width/3.0,  width/3.0)];
    
    _ImageView.layer.cornerRadius = _ImageView.frame.size.width/2;
    _ImageView.layer.masksToBounds = YES;
    [self addSubview:_ImageView];
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,width, 15)];
    _label.center=CGPointMake(_ImageView.center.x,CGRectGetMaxY(_ImageView.frame)+11);
    _label.textColor=[UIColor blackColor];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.font=[UIFont systemFontOfSize:12];
    [self addSubview:_label];
}

- (void)loadDataFromModel:(HeadButtonModel *)model{

    [_ImageView sd_setImageWithURL:[NSURL URLWithString:model.converImg]];
    _label.text = model.title;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
