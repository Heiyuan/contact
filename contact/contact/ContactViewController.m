//
//  ContactViewController.m
//  contact
//
//  Created by 陶玉程 on 16/7/8.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import "ContactViewController.h"
#import "People.h"
#import "ContactTableViewCell.h"

static NSString *contactCell = @"ContactTableViewCell";

@interface ContactViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *buttonReturn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
}

- (void)setSubViews{
    [_buttonReturn addTarget:self action:@selector(dissMissVC) forControlEvents:UIControlEventTouchUpInside];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:contactCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:contactCell];
}

- (void)dissMissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contactArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contactCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[ContactTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:contactCell];
    }
    People *contact = [_contactArray objectAtIndex:indexPath.row];
    [cell setContact:contact];
    return  cell;
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
