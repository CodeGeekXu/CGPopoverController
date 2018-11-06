//
//  CGPopoverTableController.m
//  CGPopoverController
//
//  Created by 徐晨光 on 2018/9/3.
//

#import "CGPopoverTableController.h"

static NSString *const cellIdentfire = @"normalCell";

@interface CGPopoverTableController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;

@end

@implementation CGPopoverTableController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public method

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

- (void)reloadTableViewForItems:(NSArray *)items
{
    self.items = items;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(0, 0, self.popoverContentSize.width, self.popoverContentSize.height);
}

#pragma mark - tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfire];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = @"";
    cell.textLabel.attributedText = nil;
    
    id text = self.items[indexPath.row];
    if ([text isKindOfClass:[NSString class]]) {
        cell.textLabel.text = text;
    }else if([text isKindOfClass:[NSAttributedString class]]){
        cell.textLabel.attributedText = text;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.didSelectRowBlock) {
        self.didSelectRowBlock(indexPath);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy load

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentfire];
        _tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = (self.rowHeight > 0) ? self.rowHeight : 40;
    }
    return _tableView;
}

@end
