//
//  CGContainerController.h
//  CGContainerController
//
//  Created by 徐晨光 on 2018/9/2.
//

#import <UIKit/UIKit.h>
#import <CGSegmentBar/CGSegmentBar.h>

@class CGContainerController;

typedef void(^CGContainerDidChangeBlock)(CGContainerController *container);

@interface CGContainerController : UIViewController

/**
 setter properties
 */
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, assign) BOOL bounces;
@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, copy) CGContainerDidChangeBlock didChangeControllerBlock;

/**
 getter properties
 */
@property (nonatomic, readonly) CGSegmentBar *segmentBar;
@property (nonatomic, readonly) NSArray *titles;
@property (nonatomic, readonly) NSArray *childControllers;

/**
 init
 */
- (instancetype)initWithTitles:(NSArray *)titles
              childControllers:(NSArray *)controllers
              segmentBarHeight:(CGFloat)segmentBarHeight;

/**
 setlect child controller
 */
- (void)setSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated;

@end
