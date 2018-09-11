//
//  DFCycleView.h
//  DFCycleView
//
//  Created by user on 11/9/18.
//  Copyright © 2018年 DF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFCycleModel.h"

@interface DFCycleView : UIView

/**功能：初始化轮播数组
 * @param data 数据源
 * return void
 */
- (void)setCycleData:(NSArray <DFCycleModel *> *)data;

/**功能：停止轮播定时器
 * return void */
- (void)invalidateTimer;


/**功能：开启定时器
 * return void
 */
- (void)fireTimer;

@end
