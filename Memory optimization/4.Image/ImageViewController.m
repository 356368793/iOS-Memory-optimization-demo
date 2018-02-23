//
//  ImageViewController.m
//  Memory optimization
//
//  Created by xiaochen on 2018/2/23.
//  Copyright © 2018年 xiaochen. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageCollectionViewCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define kCellIdentifier @"ImageCollectionViewCellIdentifier"

@interface ImageViewController () <UICollectionViewDataSource> {
    NSArray<UIImage *> *_images;
}

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation ImageViewController

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat spacing = 10;
        CGFloat wh = (kWidth - spacing * 3) / 2;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = spacing;
        layout.minimumInteritemSpacing = spacing;
        layout.itemSize = CGSizeMake(wh, wh);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCellIdentifier];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableArray *tmpImages = [NSMutableArray array];
//
//    _images = [[NSArray array];
    
    [self.view addSubview:self.collectionView];
}

- (void)dealloc {
    NSLog(@"%@ dealloc!!!", [self class]);
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [_images count];
    return 12;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"imageViewImage%02ld.png", (long)indexPath.item];
#pragma mark - 图片加载内存占用问题 -
    // 初始化时内存占用为 42M
    // 加载之后为 56M，控制器dealloc 之后内存并没有明显减少
//    cell.imageView.image = [UIImage imageNamed:imageName];
    
    // 加载之后为 56M，控制器dealloc 之后内存明显减少，回到之前水平 44M 左右
    NSString *file = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    cell.imageView.image = [UIImage imageWithContentsOfFile:file];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}


@end
