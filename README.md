# CGPopoverController
a Object-C popover controller

[![CI Status](https://img.shields.io/travis/CodeGeekXu/CGSegmentBar.svg?style=flat)](https://travis-ci.org/CodeGeekXu/CGSegmentBar)
[![Version](https://img.shields.io/cocoapods/v/CGSegmentBar.svg?style=flat)](https://cocoapods.org/pods/CGPopoverController)
[![License](https://img.shields.io/cocoapods/l/CGSegmentBar.svg?style=flat)](https://cocoapods.org/pods/CGPopoverController)
[![Platform](https://img.shields.io/cocoapods/p/CGSegmentBar.svg?style=flat)](https://cocoapods.org/pods/CGPopoverController)

## Demo

![jpeg](https://github.com/CodeGeekXu/CGPopoverController/blob/master/Example/CGPopoverController/CGPopoverController.jpeg)

![jpeg](https://github.com/CodeGeekXu/CGPopoverController/blob/master/Example/CGPopoverController/CGPopoverTableController.jpeg)

## Installation

CGPopoverController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CGPopoverController'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

```objective-c
    // TableView popover
    NSArray *items = @[@"橘子",@"香蕉",@"苹果",@"菠萝"];
    CGPopoverTableController *popover = [[CGPopoverTableController alloc]initWithItems:items];
    popover.rowHeight = 35;
    popover.popoverContentSize = CGSizeMake(90, 35*items.count);
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popover.didSelectRowBlock = ^(NSIndexPath *indexPath) {
        
    };
    [popover presentPopoverFromController:self barButtonItem:barButtonItem];
    
    // Custom popover
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
```

## Author

CodeGeekXu, codegeekxu@gmail.com

## License

CGPopoverController is available under the MIT license. See the LICENSE file for more info.
