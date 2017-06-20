//
//  ViewController.m
//  ScaleTest
//
//  Created by 郭丹 on 2017/6/20.
//  Copyright © 2017年 DataMesh. All rights reserved.
//

#import "ViewController.h"
#import "PicCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) CGRect rect;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_imgV addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    
    UIImageView *tempV = [[UIImageView alloc] initWithImage:_imgV.image];
    tempV.frame = _imgV.frame;
    _imgV.image = nil;
    [_imgV addSubview:tempV];
    CGRect rect = [_collection convertRect:self.rect toView:_imgV];
    [UIView animateWithDuration:1 animations:^{
        tempV.frame = rect;
    } completion:^(BOOL finished) {
        _imgV.hidden = YES;
        [tempV removeFromSuperview];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", indexPath.row + 1]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    self.indexPath = indexPath;
    PicCollectionViewCell *cell = (PicCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.rect = cell.frame;
    UIImageView *tempV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row + 1]]];
    CGRect rect = [collectionView convertRect:cell.frame toView:_imgV];
    tempV.frame = rect;
    [_imgV addSubview:tempV];
    _imgV.hidden = NO;
    [UIView animateWithDuration:1 animations:^{
        tempV.bounds = _imgV.frame;
        tempV.center = _imgV.center;
    } completion:^(BOOL finished) {
        [tempV removeFromSuperview];
        _imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
