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
#import <pop/POP.h>

static NSString *contactCell = @"ContactTableViewCell";

@interface ContactViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *buttonReturn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

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
    _tableView.layer.cornerRadius = 10.f;
    _tableView.layer.masksToBounds = YES;
    _tableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [_tableView registerNib:[UINib nibWithNibName:contactCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:contactCell];
    _mainView.alpha = 0;
    _bgImageView.image = _backImage;
}

- (void)dissMissVC {
    __weak __typeof(self)weakSelf = self;
    POPBasicAnimation *mainAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    mainAnimation.toValue = @0.f;
    mainAnimation.duration = 0.6f;
    [_mainView pop_addAnimation:mainAnimation forKey:nil];
    
    POPBasicAnimation *backAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    backAnimation.toValue = @1.f;
    backAnimation.duration = 0.6f;
    [_bgImageView pop_addAnimation:backAnimation forKey:nil];
    [backAnimation setCompletionBlock:^(POPAnimation *aa, BOOL finish) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    POPBasicAnimation *mainAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    mainAnimation.toValue = @1.f;
    mainAnimation.duration = 0.6f;
    [_mainView pop_addAnimation:mainAnimation forKey:nil];
    
    POPBasicAnimation *backAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    backAnimation.fromValue = @1.0f;
    backAnimation.toValue = @0.f;
    backAnimation.duration = 0.6f;
    [_bgImageView pop_addAnimation:backAnimation forKey:nil];
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
//    if (_contactArray.count == 1) {
//        cell.layer.cornerRadius = 10;
//    } else {
//        if (indexPath.row == _contactArray.count - 1) {
//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//            maskLayer.frame = cell.bounds;
//            maskLayer.path = maskPath.CGPath;
//            cell.layer.mask = maskLayer;
//        } else if (indexPath.row == 0) {
//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//            maskLayer.frame = cell.bounds;
//            maskLayer.path = maskPath.CGPath;
//            cell.layer.mask = maskLayer;
//        } else {
//            cell.layer.cornerRadius = 0;
//        }
//    }
//    cell.layer.masksToBounds = YES;
    return  cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_contactArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        //归档
        NSArray *sandBox = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 1, YES);
        NSString *path = [sandBox firstObject];
        NSString *docPath = [path stringByAppendingPathComponent:@"people.plist"];
        [NSKeyedArchiver archiveRootObject:_contactArray toFile:docPath];
    }
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
