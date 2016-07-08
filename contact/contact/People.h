//
//  People.h
//  contact
//
//  Created by 刘志远 on 16/7/8.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject<NSCoding>
@property (nonatomic,copy) NSString *name; /**<名字*/
@property (nonatomic,copy) NSString *phoneNumber;/**<电话号*/
@property (nonatomic,copy) NSString *address; /**<地址*/
@property (nonatomic,copy) NSString *note;  /**<备注*/
@end
