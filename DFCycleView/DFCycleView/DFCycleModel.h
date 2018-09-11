//
//  DFCycleModel.h
//  DFCycleView
//
//  Created by user on 11/9/18.
//  Copyright © 2018年 DF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFCycleModel : NSObject
/// 图片路径
@property (nonatomic, copy) NSString *imageUrl;
/// 介绍
@property (nonatomic, copy) NSString *summary;

/// 工厂方法
+ (instancetype)initWithImageUrl:(NSString *)imageUrl andSummary:(NSString *)summary;

@end
