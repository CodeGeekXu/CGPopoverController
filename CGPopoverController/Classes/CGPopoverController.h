//
//  CGPopoverController.h
//  CGPopoverController
//
//  Created by 徐晨光 on 2018/9/3.
//

#import <UIKit/UIKit.h>

@interface CGPopoverController : UIViewController

/**
 setter properties
 */
@property (nonatomic, assign) CGSize popoverContentSize;
@property (nonatomic, assign) UIPopoverArrowDirection permittedArrowDirections;
@property (nonatomic, assign) UIEdgeInsets popoverLayoutMargins;

/**
 getter properties
 */
@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic, readonly) UIView *sourceView;
@property (nonatomic, readonly) UIBarButtonItem *barButtonItem;

/**
 init
 */
- (instancetype)initWithContentView:(UIView *)contentView;


/**
 present

 @param controller present view controller
 @param sourceView source view
 @param sourceRect souree view rect
 */
- (void)presentPopoverFromController:(UIViewController *)controller
                          sourceView:(UIView *)sourceView
                          sourceRect:(CGRect)sourceRect;

/**
 present

 @param controller present view controller
 @param barButtonItem source barButtonItem
 */
- (void)presentPopoverFromController:(UIViewController *)controller
                       barButtonItem:(UIBarButtonItem *)barButtonItem;

//dismiss
- (void)dismissViewControllerAnimated:(BOOL)animated;

@end
