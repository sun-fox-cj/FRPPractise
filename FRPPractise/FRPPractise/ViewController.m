//
//  ViewController.m
//  FRPPractise
//
//  Created by cjfire on 2017/1/31.
//  Copyright © 2017年 cjfire. All rights reserved.
//

#import "ViewController.h"
#import "FRPPhotoImporter.h"
#import "FRPCell.h"

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic , strong) NSArray *photosArray;
@property (nonatomic, weak) UICollectionView* collectionView;

@end

@implementation ViewController

static NSString * CellIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    //Configure self
    self.title = @"Popular on 500px";
    
    //Configure View
    [self.collectionView registerClass:[FRPCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    //Reactive Stuff
    @weakify(self);
    [RACObserve(self, photosArray) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    //Load data
    [self loadPopularPhotos];
}

- (void)setupUI {
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    UICollectionView* collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self.view addSubview:collectionview];
    _collectionView = collectionview;
    
    _collectionView.dataSource = self;
}

- (void)loadPopularPhotos{
    [[FRPPhotoImporter importPhotos] subscribeNext:^(id x){
        self.photosArray = x;
    } error:^(NSError * error){
        NSLog(@"Couldn't fetch photofrom 500px: %@",error);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FRPCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setPhotoModel:self.photosArray[indexPath.row]];
    
    return cell;
}

@end
