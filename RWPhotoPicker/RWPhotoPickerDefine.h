//
//  RWPhotoPickerDefine.h
//
//  Created by riven wang on 2017/1/17.
//  Copyright © 2017年 wesai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PhotoPickerResultBlock)(NSArray *photos);

#define RGBCOLOR_HEX(rgbValue)                                                                   \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                           \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                              \
blue:((float)(rgbValue & 0xFF)) / 255.0                                       \
alpha:1.0]

#define RGBACOLOR_HEX(rgbValue,a)                                                                   \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                           \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                              \
blue:((float)(rgbValue & 0xFF)) / 255.0                                       \
alpha:(a)/1.0]
