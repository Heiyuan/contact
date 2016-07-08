//
//  People.h
//  contact
//
//  Created by 刘志远 on 16/7/8.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UIColorFromRGBA(rgbValue, alphaValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/ 255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

#define BLUECOLOR UIColorFromRGBA(0x54d2e2, 1)

@interface People : NSObject<NSCoding>
@property (nonatomic,copy) NSString *name; /**<名字*/
@property (nonatomic,copy) NSString *phoneNumber;/**<电话号*/
//@property (nonatomic,copy) NSString *address; /**<地址*/
//@property (nonatomic,copy) NSString *note;  /**<备注*/
@property (nonatomic,copy) NSString *shopStyle; /**<0新店，1已有店铺*/
@end
