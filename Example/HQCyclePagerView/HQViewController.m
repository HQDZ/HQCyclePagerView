//
//  HQViewController.m
//  HQCyclePagerView
//
//  Created by stevenJiechen on 04/09/2022.
//  Copyright (c) 2022 stevenJiechen. All rights reserved.
//

#import "HQViewController.h"
#import "UIImageView+YYWebImage.h"
#import "HQCyclePagerView.h"
#import "HQPageControl.h"
#import "HQCyclePagerViewCell.h"

@interface HQViewController () <HQCyclePagerViewDataSource, HQCyclePagerViewDelegate>

@property (nonatomic, strong) HQCyclePagerView *pagerView;
@property (nonatomic, strong) HQPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation HQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"HQCyclePagerView";
    [self addPagerView];
    [self addPageControl];
    [self loadData];
}



- (void)addPagerView {
    HQCyclePagerView *pagerView = [[HQCyclePagerView alloc]init];
    pagerView.layer.borderWidth = 1;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    pagerView.layout.maximumAngle = 0.5;
    // registerClass or registerNib
    [pagerView registerClass:[HQCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)addPageControl {
    HQPageControl *pageControl = [[HQPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    pageControl.pageIndicatorSize = CGSizeMake(12, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
//    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
//    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
//    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}



- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
}


- (void)loadData {
    NSMutableArray *datas = [NSMutableArray arrayWithArray:@[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=4243239694,1996254031&fm=26&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1307448735,4237364771&fm=26&gp=0.jpg",@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2126005396,748516889&fm=26&gp=0.jpg"]];
    
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
    //[_pagerView scrollToItemAtIndex:3 animate:YES];
}



#pragma mark - HQCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(HQCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(HQCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    HQCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.imagev.backgroundColor = [UIColor lightTextColor];
    NSString *url = [_datas objectAtIndex:index];
    [cell.imagev yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionUseNSURLCache];
    return cell;
}

- (HQCyclePagerViewLayout *)layoutForPagerView:(HQCyclePagerView *)pageView {
    HQCyclePagerViewLayout *layout = [[HQCyclePagerViewLayout alloc]init];
    CGAffineTransform transform = CGAffineTransformMakeScale(0.8, 0.85);
    layout.itemSize = CGSizeApplyAffineTransform(self.pagerView.frame.size, transform);
    layout.itemSpacing = 10;
    layout.minimumScale = 0.95;
    layout.layoutType = HQCyclePagerTransformLayoutLinear;
    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = YES;
    return layout;
}


#pragma mark - HQCyclePagerViewDelegate

- (void)pagerView:(HQCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pagerView:(HQCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    
    NSLog(@"select  %ld",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
