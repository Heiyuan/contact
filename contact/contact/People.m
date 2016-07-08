//
//  People.m
//  contact
//
//  Created by 刘志远 on 16/7/8.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import "People.h"

@implementation People
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.phoneNumber = [aDecoder decodeObjectForKey:@"phoneNumber"];
    self.address = [aDecoder decodeObjectForKey:@"phoneNumber"];
    self.note = [aDecoder decodeObjectForKey:@"note"];

    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.note forKey:@"note"];

}
@end
