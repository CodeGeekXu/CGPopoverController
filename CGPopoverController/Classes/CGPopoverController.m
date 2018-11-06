//
//  CGPopoverController.m
//  CGPopoverController
//
//  Created by 徐晨光 on 2018/9/3.
//

#import "CGPopoverController.h"

@interface CGPopoverController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *sourceView;
@property (nonatomic, assign) CGRect sourceRect;
@property (nonatomic, strong) UIBarButtonItem *barButtonItem;

@end

@implementation CGPopoverController

- (instancetype)initWithContentView:(UIView *)contentView
{
    self = [self init];
    if (self) {
        self.contentView = contentView;
        self.popoverContentSize = contentView.bounds.size;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig
{
    self.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController * popVC = self.popoverPresentationController;
    popVC.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.contentView) {
        [self.view addSubview:self.contentView];
    }
}

#pragma mark - public method

- (void)presentPopoverFromController:(UIViewController *)controller
                          sourceView:(UIView *)sourceView
                          sourceRect:(CGRect)sourceRect
{
    if (self.popoverPresentationController.presentationStyle !=  UIModalPresentationNone) {
        self.popoverPresentationController.delegate = self;
    }
    self.sourceView = sourceView;
    self.sourceRect = sourceRect;
    self.popoverPresentationController.permittedArrowDirections = self.permittedArrowDirections;
    [controller presentViewController:self animated:YES completion:^{
        self.popoverPresentationController.passthroughViews = nil;
    }];
}

- (void)presentPopoverFromController:(UIViewController *)controller
                       barButtonItem:(UIBarButtonItem *)barButtonItem
{
    if (self.popoverPresentationController.presentationStyle !=  UIModalPresentationNone) {
        self.popoverPresentationController.delegate = self;
    }
    self.barButtonItem = barButtonItem;
    self.popoverPresentationController.permittedArrowDirections = self.permittedArrowDirections;
    [controller presentViewController:self animated:YES completion:^{
        self.popoverPresentationController.passthroughViews = nil;
    }];
}

- (void)dismissViewControllerAnimated:(BOOL)animated
{
    if (!self.beingDismissed) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    if (!self.beingDismissed) {
        [super dismissViewControllerAnimated:flag completion:completion];
    }
}

#pragma mark - setters

- (void)setPopoverContentSize:(CGSize)popoverContentSize
{
    _popoverContentSize = popoverContentSize;
    self.preferredContentSize = popoverContentSize;
}

- (void)setSourceView:(UIView *)sourceView
{
    _sourceView = sourceView;
    self.popoverPresentationController.sourceView = sourceView;
}

- (void)setSourceRect:(CGRect)sourceRect
{
    _sourceRect = sourceRect;
    self.popoverPresentationController.sourceRect = sourceRect;
}

- (void)setPermittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections
{
    _permittedArrowDirections = permittedArrowDirections;
    self.popoverPresentationController.permittedArrowDirections = permittedArrowDirections;
}

- (void)setBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    _barButtonItem = barButtonItem;
    self.popoverPresentationController.barButtonItem = barButtonItem;
}

- (void)setPopoverLayoutMargins:(UIEdgeInsets)popoverLayoutMargins
{
    _popoverLayoutMargins = popoverLayoutMargins;
    self.popoverPresentationController.popoverLayoutMargins = popoverLayoutMargins;
}

#pragma mark - UIPopoverPresentationControllerDelegate

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    
    return UIModalPresentationNone;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    return YES;
}

@end
