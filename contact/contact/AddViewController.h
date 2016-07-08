//
//  AddViewController.h
//  contact
//
//  Created by 陶玉程 on 16/7/8.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGBA(rgbValue, alphaValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/ 255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

#define BLUECOLOR UIColorFromRGBA(0x54d2e2, 1)

@interface AddViewController : UIViewController

@end
