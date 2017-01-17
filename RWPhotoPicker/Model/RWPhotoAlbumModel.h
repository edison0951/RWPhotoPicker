//
//  RWPhotoAlbumModel.h
//
//  Created by riven wang on 2017/1/17.
//  Copyright © 2017年 wesai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsGroup;
@interface RWPhotoAlbumModel : NSObject
@property (nonatomic, strong) ALAssetsGroup* group;
@property (nonatomic, strong) UIImage* thumbImage;
@end
