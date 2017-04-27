//
//  CXYCollectionViewFlowLayout.m
//  滑动
//
//  Created by cxy on 17/3/6.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import "CXYCollectionViewFlowLayout.h"
@interface CXYCollectionViewFlowLayout()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end
@implementation CXYCollectionViewFlowLayout

-(id)init{
    if ([super init]) {
        _springDamping = 0.5;
        _springFrequency = 0.8;
        _resistanceFactor = 500;
    }
    return  self;
}

-(void)prepareLayout {
    [super prepareLayout];
    
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes *item in items ) {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
            spring.length = 0;
            spring.damping = self.springDamping;
            spring.frequency = self.springFrequency;
            [_animator addBehavior:spring];
        }
    }
    
}
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [_animator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_animator layoutAttributesForCellAtIndexPath:indexPath];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior *spring in _animator.behaviors){
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabsf(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / self.resistanceFactor;
        
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint center = item.center;
        center.y += (scrollDelta>0) ? MIN(scrollDelta, scrollDelta * scrollResistance)
                                    : MAX(scrollDelta, scrollDelta * scrollResistance);
        
        item.center = center;
        
        [_animator updateItemUsingCurrentState:item];
        
    }
    
    return NO;
}
@end
