//
//  CGContainerController.m
//  CGContainerController
//
//  Created by 徐晨光 on 2018/9/2.
//

#import "CGContainerController.h"
#import <Masonry/Masonry.h>

@interface CGContainerController ()<
UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, assign) CGFloat segmentBarHeight;
@property (nonatomic, strong) CGSegmentBar *segmentBar;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CGContainerController

- (instancetype)initWithTitles:(NSArray *)titles
              childControllers:(NSArray *)controllers
              segmentBarHeight:(CGFloat)segmentBarHeight
{
    self = [super init];
    
    if (self) {
        _childControllers = controllers;
        _titles = [NSArray arrayWithArray:titles];
        self.segmentBarHeight    = segmentBarHeight;
        self.bounces = YES;
        self.scrollEnabled = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public methods

- (void)setSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated
{
    [self.segmentBar setSelectedIndex:selectIndex animated:animated];
    [self scrollCollectionViewToIndex:selectIndex animated:animated];
}

#pragma mark - setters

- (void)setHeaderView:(UIView *)headerView
{
    if (!self.viewLoaded) {
        return;
    }
    
    if (self.headerView) {
        [self.headerView removeFromSuperview];
    }
    
    _headerView = headerView;
    [self.view addSubview:headerView];
    
    [self placeSubViews];
    [self.collectionView reloadData];
}

- (void)setFooterView:(UIView *)footerView
{
    if (!self.viewLoaded) {
        return;
    }
    
    if (self.footerView) {
        [self.footerView removeFromSuperview];
    }
    
    _footerView = footerView;
    [self.view addSubview:footerView];
    
    [self placeSubViews];
    [self.collectionView reloadData];
}

- (void)setBounces:(BOOL)bounces
{
    _bounces = bounces;
    self.collectionView.bounces = bounces;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled
{
    _scrollEnabled = scrollEnabled;
    self.collectionView.scrollEnabled = scrollEnabled;
}

#pragma mark - Private Methods

- (void)setupSubViews
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.segmentBar];
    [self.view addSubview:self.collectionView];
    [self placeSubViews];
    [self.collectionView reloadData];
    
    self.segmentBar.titles = self.titles;
}

- (void)placeSubViews
{
    if (self.headerView) {
        [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            } else {
                make.top.equalTo(self.view);
            }
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.height.offset(CGRectGetHeight(self.headerView.bounds));
        }];
    }
    
    if (self.footerView) {
        [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            }else{
                make.bottom.equalTo(self.view);
            }
            
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.height.offset(CGRectGetHeight(self.footerView.bounds));
        }];
    }
    
    [self.segmentBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        if (self.headerView) {
            make.top.equalTo(self.headerView.mas_bottom);
        }else{
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            }else{
                make.top.equalTo(self.view);
            }
        }
        
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.offset(self.segmentBarHeight);
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.segmentBar.mas_bottom);
        
        if (self.footerView) {
            make.bottom.equalTo(self.footerView.mas_top);
        }else{
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            }else{
                make.bottom.equalTo(self.view);
            }
        }
    }];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)scrollCollectionViewToIndex:(NSInteger)index animated:(BOOL)animated
{
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView selectItemAtIndexPath:selectedIndexPath
                                      animated:animated
                                scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    if (self.didChangeControllerBlock) {
        self.didChangeControllerBlock(self);
    }
}

#pragma mark - UICollectionView代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childControllers.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell"
                                                                           forIndexPath:indexPath];
    
    cell.selected = NO;
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UIViewController *subViewController = self.childControllers[indexPath.item];
    if(![self.childViewControllers containsObject:subViewController]){
        [self addChildViewController:subViewController];
    }
    subViewController.view.frame = cell.contentView.bounds;
    subViewController.preferredContentSize = cell.contentView.bounds.size;
    [cell.contentView addSubview:subViewController.view];
    [subViewController viewWillAppear:NO];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = (int)scrollView.contentOffset.x / (scrollView.bounds.size.width);
    if (index != self.segmentBar.selectedIndex) {
        
        [self.segmentBar setSelectedIndex:index animated:YES];
        if (self.didChangeControllerBlock) {
            self.didChangeControllerBlock(self);
        }
    }
}

#pragma mark - getters

- (UICollectionView *)collectionView
{
    if(!_collectionView){
        
        UICollectionViewFlowLayout *laout = [[UICollectionViewFlowLayout alloc]init];
        laout.minimumLineSpacing = 0;
        laout.minimumInteritemSpacing = 0;
        laout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:laout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = self.bounces;
        _collectionView.scrollEnabled = self.scrollEnabled;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    
    return _collectionView;
}

- (CGSegmentBar *)segmentBar
{
    if (!_segmentBar) {
        CGSegmentBar *segmentBar = [[CGSegmentBar alloc]init];
        segmentBar.backgroundColor = [UIColor whiteColor];
        segmentBar.titles = self.titles;
        segmentBar.widthStyle = CGSegmentBarWidthStyleFixed;
        segmentBar.interitemSpacing = 30;
        segmentBar.paddingInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        segmentBar.indicatorHeight = 2;
        segmentBar.indicatorColor = [UIColor blueColor];
        [segmentBar reload];
        
        __weak typeof(self) weakSelf = self;
        segmentBar.didSelectItemBlock = ^(NSUInteger index) {
            [weakSelf scrollCollectionViewToIndex:index animated:YES];
        };
        
        _segmentBar = segmentBar;
    }
    
    return _segmentBar;
}

@end
