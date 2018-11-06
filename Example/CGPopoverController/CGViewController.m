//
//  CGViewController.m
//  CGPopoverController
//
//  Created by codegeekxu@gmail.com on 09/03/2018.
//  Copyright (c) 2018 codegeekxu@gmail.com. All rights reserved.
//

#import "CGViewController.h"
#import "CGPopoverTableController.h"

@interface CGViewController ()

@end

@implementation CGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"气泡";
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"选择"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(didTapRightBarItem:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapRightBarItem:(UIBarButtonItem *)barButtonItem
{
    NSArray *items = @[@"橘子",@"香蕉",@"苹果",@"菠萝"];
    CGPopoverTableController *popover = [[CGPopoverTableController alloc]initWithItems:items];
    popover.rowHeight = 35;
    popover.popoverContentSize = CGSizeMake(90, 35*items.count);
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popover.didSelectRowBlock = ^(NSIndexPath *indexPath) {
        
    };
    [popover presentPopoverFromController:self barButtonItem:barButtonItem];
}

- (IBAction)didTapCustomPopover:(UIButton *)sender {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 45)];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    label.text = @"自定义气泡,你可以使用自定义view来显示气泡";
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 230, 45)];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:label];
    
    CGPopoverController *popover = [[CGPopoverController alloc]initWithContentView:contentView];
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    [popover presentPopoverFromController:self sourceView:sender
                               sourceRect:sender.bounds];
}

@end
