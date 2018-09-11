//
//  DFCycleView.m
//  DFCycleView
//
//  Created by user on 11/9/18.
//  Copyright © 2018年 DF. All rights reserved.
//

#import "DFCycleView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define kDefalutImageName @"image_default"
#define kBottomH 30


@interface DFCycleView ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *leftIV;
@property (nonatomic, weak) UIImageView *centerIV;
@property (nonatomic, weak) UIImageView *rightIV;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UILabel *summaryLabel;

@property (nonatomic, strong) NSArray<DFCycleModel*> *dataArray;
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;  //定时器用于滚动轮播图

@property (nonatomic, assign) NSInteger currentPage;  //当前页
@end

@implementation DFCycleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self adjustFrame];
}





#pragma mark ============ private method
- (void)setupUI {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    UIImageView *leftIV = [[UIImageView alloc] init];
    [scrollView addSubview:leftIV];
    self.leftIV = leftIV;
    
    UIImageView *centerIV = [[UIImageView alloc] init];
    [scrollView addSubview:centerIV];
    self.centerIV = centerIV;
    
    UIImageView *rightIV = [[UIImageView alloc] init];
    [scrollView addSubview:rightIV];
    self.rightIV = rightIV;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    UILabel *summaryLabel = [[UILabel alloc] init];
    summaryLabel.text = @"";
    summaryLabel.textColor = [UIColor whiteColor];
    summaryLabel.font = [UIFont systemFontOfSize:15.0f];
//    summaryLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:summaryLabel];
    self.summaryLabel = summaryLabel;
    
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
//    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [bottomView addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 使pageControl不响应点击事件
    pageControl.userInteractionEnabled = NO;
}


/// 适配
- (void)adjustFrame {
    CGRect frame = self.bounds;
    self.scrollView.frame = frame;
    self.leftIV.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    self.centerIV.frame = CGRectMake(CGRectGetWidth(frame), 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    self.rightIV.frame = CGRectMake(CGRectGetWidth(frame) * 2, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    
    self.bottomView.frame = CGRectMake(0, CGRectGetHeight(frame) - kBottomH, CGRectGetWidth(frame), kBottomH);
    self.summaryLabel.frame = CGRectMake(10, 0, CGRectGetWidth(frame), kBottomH);
    CGSize pageSize = [self.pageControl sizeForNumberOfPages:self.dataArray.count];
    self.pageControl.frame = CGRectMake(CGRectGetWidth(frame) - 10 - pageSize.width, 0, pageSize.width, kBottomH);
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(frame) * 3, CGRectGetHeight(frame))];
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(frame), 0)];
}


/// 更新当前的index
- (void)updateCurrentPageWithDirector:(BOOL)isRight{
    NSInteger pageCount = self.dataArray.count;
    if (pageCount == 0) {
        return;
    }
    if (isRight) {
        self.currentPage = self.currentPage > 0 ? (self.currentPage - 1) : (pageCount - 1);
    }else{
        self.currentPage = (self.currentPage + 1) % pageCount;
    }
}

//定时器自动轮播
- (void)animalImage{
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * 2, 0)];
    } completion:^(BOOL finished) {
        if (finished) {
            [self updateCurrentPageWithDirector:NO];
            [self updateScrollViewAndImage];
        }
    }];

}


//滚动后更新scrollView的位置和显示的图片
- (void)updateScrollViewAndImage{
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.bounds), 0)];
    
    NSInteger pageCount = self.dataArray.count;
    if (pageCount == 0) {
        return;
    }
    //
    NSInteger leftIndex = (_currentPage > 0) ? (_currentPage - 1) : (pageCount - 1);
    NSInteger rightIndex = (_currentPage < pageCount - 1) ? (_currentPage + 1) : 0;
    
    DFCycleModel *leftmodel = self.dataArray[leftIndex];
    DFCycleModel *centerModel = self.dataArray[_currentPage];
    DFCycleModel *rightModel = self.dataArray[rightIndex];
    
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:leftmodel.imageUrl]
                   placeholderImage:[UIImage imageNamed:kDefalutImageName]];
    [self.centerIV sd_setImageWithURL:[NSURL URLWithString:centerModel.imageUrl]
                     placeholderImage:[UIImage imageNamed:kDefalutImageName]];
    [self.rightIV sd_setImageWithURL:[NSURL URLWithString:rightModel.imageUrl]
                    placeholderImage:[UIImage imageNamed:kDefalutImageName]];
    
    self.summaryLabel.text = centerModel.summary;
    
    [self.pageControl setCurrentPage:_currentPage];
    
    NSLog(@"%ld", _currentPage);
    
}

#pragma mark ============ UIScrollerViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0)
    {
        [self updateCurrentPageWithDirector:YES];
    }
    else if (scrollView.contentOffset.x > CGRectGetWidth(scrollView.frame))
    {
        [self updateCurrentPageWithDirector:NO];
        
    }else{
        return;
    }
    [self updateScrollViewAndImage];
    
    [self fireTimer];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}


#pragma mark ============ public method
- (void)setCycleData:(NSArray<DFCycleModel *> *)data {
    self.dataArray = data;
    self.currentPage = 0;
    self.pageControl.numberOfPages = data.count;
    [self updateScrollViewAndImage];
    [self adjustFrame];
    self.scrollView.scrollEnabled = data.count > 1;
    [self fireTimer];
}



- (void)invalidateTimer {
    if (_timer && [_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)fireTimer {
    [self invalidateTimer];
    //如果有图片才开启定时器
    if (self.dataArray.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(animalImage) userInfo:nil repeats:YES];
    }
}

@end
