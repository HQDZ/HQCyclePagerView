//
//  HQCyclePagerViewCell.m
//  HQCyclePagerView_Example
//
//  Created by Klay on 2022/4/10.
//  Copyright © 2022 HQTeam. All rights reserved.
//

#import "HQCyclePagerViewCell.h"

@interface HQCyclePagerViewCell ()

@property (nonatomic, strong) UIImageView *imagev;

@end

@implementation HQCyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addImagev];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addImagev];
    }
    return self;
}


- (void)addImagev {
    UIImageView *imagev = [[UIImageView alloc]init];
    imagev.contentMode = UIViewContentModeScaleAspectFill;
    imagev.clipsToBounds = YES;
    [self addSubview:imagev];
    _imagev = imagev;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imagev.frame = self.bounds;
}


@end
