//
//  FoldableCollectionViewController.m
//  FoldableCollectionView
//
//  Created by offz on 3/17/2557 BE.
//  Copyright (c) 2557 off. All rights reserved.
//

#import "FoldableCollectionViewController.h"

@interface FoldableCollectionViewController ()

@property (strong,nonatomic)NSMutableIndexSet *folded;

@end

@implementation FoldableCollectionViewController

- (NSMutableIndexSet *)folded {
    if (!_folded) {
        _folded = [NSMutableIndexSet indexSet];
    }
    
    return _folded;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                           forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:@"header"
                                                                               forIndexPath:indexPath];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(didSelectSection:)]];
    view.tag = indexPath.section;
    
    return view;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 30;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.folded containsIndex:indexPath.section]) {
        return CGSizeMake(10, 10);
    }
    return CGSizeMake(50, 50);
}

#pragma mark - Actions
- (void)didSelectSection:(UITapGestureRecognizer *)sender {
    
    NSInteger selectedSection = sender.view.tag;
    
    if ([self.folded containsIndex:selectedSection]) {
        [self.folded removeIndex:selectedSection];
    } else {
        [self.folded addIndex:selectedSection];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection]];
}

@end
