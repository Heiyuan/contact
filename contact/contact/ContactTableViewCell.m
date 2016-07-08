//
//  ContactTableViewCell.m
//  contact
//
//  Created by 陶玉程 on 16/7/8.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "People.h"

@interface ContactTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;

@end

@implementation ContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setContact:(People *)contact {
    _nameLabel.text = contact.name;
    _phoneNumberLabel.text = contact.phoneNumber;
    _styleLabel.text = [contact.shopStyle integerValue] ? @"已有店铺" : @"开新店";
}

@end
