//
//  CXYCollectionViewFlowLayout.h
//  滑动
//
//  Created by cxy on 17/3/6.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXYCollectionViewFlowLayout : UICollectionViewFlowLayout

/**
 阻尼系数
 */
@property (nonatomic, assign) CGFloat springDamping;

/**
 频率
 */
@property (nonatomic, assign) CGFloat springFrequency;

/**
 阻力
 */
@property (nonatomic, assign) CGFloat resistanceFactor;
@end
