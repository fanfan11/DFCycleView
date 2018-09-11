//
//  ViewController.m
//  DFCycleView
//
//  Created by user on 11/9/18.
//  Copyright © 2018年 DF. All rights reserved.
//

#import "ViewController.h"
#import "DFCycleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}


- (void)setupUI {
    self.view.backgroundColor = [UIColor yellowColor];
    
    //轮播控件
    DFCycleView *carouselSV = [[DFCycleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) / 320 * 160)];
    carouselSV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:carouselSV];
    
    DFCycleModel *model0 = [DFCycleModel initWithImageUrl:@"http://pic.58pic.com/58pic/17/27/03/07B58PIC3zg_1024.jpg" andSummary:nil];
    DFCycleModel *model1 = [DFCycleModel initWithImageUrl:@"http://pic.58pic.com/58pic/13/56/99/88f58PICuBh_1024.jpg" andSummary:nil];
    DFCycleModel *model2 = [DFCycleModel initWithImageUrl:@"http://pic.58pic.com/58pic/17/77/53/558d11422a923_1024.png" andSummary:nil];
    DFCycleModel *model3 = [DFCycleModel initWithImageUrl:@"http://pic.58pic.com/58pic/13/18/14/87m58PICVvM_1024.jpg" andSummary:nil];
    DFCycleModel *model4 = [DFCycleModel initWithImageUrl:@"http://pic.qiantucdn.com/58pic/17/79/77/41N58PICaMu_1024.jpg" andSummary:nil];
    
    
    
    
    [carouselSV setCycleData:@[model0, model1, model2, model3, model4]];
}



@end
