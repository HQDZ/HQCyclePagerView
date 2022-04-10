//
//  HQCyclePagerView.h
//  HQCyclePagerView_Example
//
//  Created by Klay on 2022/4/10.
//  Copyright © 2022 HQTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include(<HQCyclePagerView/HQCyclePagerView.h>)
#import <HQCyclePagerView/HQCyclePagerTransformLayout.h>
#else
#import "HQCyclePagerTransformLayout.h"
#endif
#if __has_include(<HQCyclePagerView/TYPageControl.h>)
#import <HQCyclePagerView/HQPageControl.h>
#endif


NS_ASSUME_NONNULL_BEGIN

typedef struct {
    NSInteger index;
    NSInteger section;
}HQIndexSection;

// pagerView scrolling direction
typedef NS_ENUM(NSUInteger, HQPagerScrollDirection) {
    HQPagerScrollDirectionLeft,
    HQPagerScrollDirectionRight,
};

@class HQCyclePagerView;
@protocol HQCyclePagerViewDataSource <NSObject>

- (NSInteger)numberOfItemsInPagerView:(HQCyclePagerView *)pageView;

- (__kindof UICollectionViewCell *)pagerView:(HQCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index;

/**
 return pagerView layout,and cache layout
 */
- (HQCyclePagerViewLayout *)layoutForPagerView:(HQCyclePagerView *)pageView;

@end

@protocol HQCyclePagerViewDelegate <NSObject>

@optional

/**
 pagerView did scroll to new index page
 */
- (void)pagerView:(HQCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

/**
 pagerView did selected item cell
 */
- (void)pagerView:(HQCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index;
- (void)pagerView:(HQCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndexSection:(HQIndexSection)indexSection;

// custom layout
- (void)pagerView:(HQCyclePagerView *)pageView initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;

- (void)pagerView:(HQCyclePagerView *)pageView applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;


// scrollViewDelegate

- (void)pagerViewDidScroll:(HQCyclePagerView *)pageView;

- (void)pagerViewWillBeginDragging:(HQCyclePagerView *)pageView;

- (void)pagerViewDidEndDragging:(HQCyclePagerView *)pageView willDecelerate:(BOOL)decelerate;

- (void)pagerViewWillBeginDecelerating:(HQCyclePagerView *)pageView;

- (void)pagerViewDidEndDecelerating:(HQCyclePagerView *)pageView;

- (void)pagerViewWillBeginScrollingAnimation:(HQCyclePagerView *)pageView;

- (void)pagerViewDidEndScrollingAnimation:(HQCyclePagerView *)pageView;

@end


@interface HQCyclePagerView : UIView

// will be automatically resized to track the size of the pagerView
@property (nonatomic, strong, nullable) UIView *backgroundView;

@property (nonatomic, weak, nullable) id<HQCyclePagerViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id<HQCyclePagerViewDelegate> delegate;

// pager view, don't set dataSource and delegate
@property (nonatomic, weak, readonly) UICollectionView *collectionView;
// pager view layout
@property (nonatomic, strong, readonly) HQCyclePagerViewLayout *layout;

/**
 is infinite cycle pageview
 */
@property (nonatomic, assign) BOOL isInfiniteLoop;

/**
 pagerView automatic scroll time interval, default 0,disable automatic
 */
@property (nonatomic, assign) CGFloat autoScrollInterval;

@property (nonatomic, assign) BOOL reloadDataNeedResetIndex;

/**
 current page index
 */
@property (nonatomic, assign, readonly) NSInteger curIndex;
@property (nonatomic, assign, readonly) HQIndexSection indexSection;

// scrollView property
@property (nonatomic, assign, readonly) CGPoint contentOffset;
@property (nonatomic, assign, readonly) BOOL tracking;
@property (nonatomic, assign, readonly) BOOL dragging;
@property (nonatomic, assign, readonly) BOOL decelerating;


/**
 reload data, !!important!!: will clear layout and call delegate layoutForPagerView
 */
- (void)reloadData;

/**
 update data is reload data, but not clear layuot
 */
- (void)updateData;

/**
 if you only want update layout
 */
- (void)setNeedUpdateLayout;

/**
 will set layout nil and call delegate->layoutForPagerView
 */
- (void)setNeedClearLayout;

/**
 current index cell in pagerView
 */
- (__kindof UICollectionViewCell * _Nullable)curIndexCell;

/**
 visible cells in pageView
 */
- (NSArray<__kindof UICollectionViewCell *> *_Nullable)visibleCells;


/**
 visible pageView indexs, maybe repeat index
 */
- (NSArray *)visibleIndexs;

/**
 scroll to item at index
 */
- (void)scrollToItemAtIndex:(NSInteger)index animate:(BOOL)animate;
- (void)scrollToItemAtIndexSection:(HQIndexSection)indexSection animate:(BOOL)animate;
/**
 scroll to next or pre item
 */
- (void)scrollToNearlyIndexAtDirection:(HQPagerScrollDirection)direction animate:(BOOL)animate;

/**
 register pager view cell with class
 */
- (void)registerClass:(Class)Class forCellWithReuseIdentifier:(NSString *)identifier;

/**
 register pager view cell with nib
 */
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;

/**
 dequeue reusable cell for pagerView
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
