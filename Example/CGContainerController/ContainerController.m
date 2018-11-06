//
//  ContainerController.m
//  CGContainerController_Example
//
//  Created by 徐晨光 on 2018/9/2.
//  Copyright © 2018年 CodeGeekXu. All rights reserved.
//

#import "ContainerController.h"
#import "CGViewController.h"

@interface ContainerController ()

@end

@implementation ContainerController

- (instancetype)init
{
    CGViewController *page1 = [CGViewController new];
    page1.view.backgroundColor = [UIColor whiteColor];
    
    CGViewController *page2 = [CGViewController new];
    page2.view.backgroundColor = [UIColor redColor];
    
    CGViewController *page3 = [CGViewController new];
    page3.view.backgroundColor = [UIColor greenColor];
    
    CGViewController *page4 = [CGViewController new];
    page4.view.backgroundColor = [UIColor blueColor];
    
    CGViewController *page5 = [CGViewController new];
    page5.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    CGViewController *page6 = [CGViewController new];
    page6.view.backgroundColor = [UIColor lightGrayColor];
    
    CGViewController *page7 = [CGViewController new];
    page7.view.backgroundColor = [UIColor purpleColor];
    
    self = [super initWithTitles:@[@"Page 1",@"Page 2",@"Page 3",@"Page 4",@"Page 5",@"Page 6",@"Page 7"]
                childControllers:@[page1,page2,page3,page4,page5,page6,page7]
                segmentBarHeight:40];
    if (self) {
        self.segmentBar.indicatorColor = [UIColor blueColor];
        self.segmentBar.widthStyle = CGSegmentBarWidthStyleDynamic;
        self.segmentBar.interitemSpacing = 40;
        self.segmentBar.paddingInsets = UIEdgeInsetsMake(0, 20, 0, 20);
        self.segmentBar.selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                                   NSForegroundColorAttributeName:[UIColor blueColor]};
        [self.segmentBar reload];
    }
    return self;
}

- (void)setupBanner
{
    CGFloat width = self.view.bounds.size.width;
    UIImageView *bannerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width/2)];
    bannerView.image = [UIImage imageNamed:@"banner"];
    self.headerView = bannerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
