//
//  DFCycleModel.m
//  DFCycleView
//
//  Created by user on 11/9/18.
//  Copyright © 2018年 DF. All rights reserved.
//

#import "DFCycleModel.h"

@implementation DFCycleModel

+ (instancetype)initWithImageUrl:(NSString *)imageUrl andSummary:(NSString *)summary {
    DFCycleModel *model = [[DFCycleModel alloc] init];
    model.imageUrl = imageUrl;
    model.summary = summary;
    return model;
}

@end
