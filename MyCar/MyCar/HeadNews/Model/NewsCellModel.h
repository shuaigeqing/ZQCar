//
//  NewsCellModel.h
//  MyCar
//
//  Created by 🐵 on 16-5-20.
//  Copyright (c) 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsCellModel : NSObject


@property (nonatomic,assign) int commentCount;

@property (nonatomic,copy) NSString * newsId;

@property (nonatomic,copy) NSString * picCover;

@property (nonatomic,copy) NSString * src;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,assign) int type;

@property (nonatomic,copy) NSString * mp4Link;

@property (nonatomic,copy) NSString * duration;

@property (nonatomic,copy) NSString * mediaName;

@property (nonatomic,assign) int totalvisit;

@end
