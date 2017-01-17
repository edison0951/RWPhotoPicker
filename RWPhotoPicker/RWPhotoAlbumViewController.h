//
//  RWPhotoAlbumViewController.h
//
//  Created by riven wang on 2017/1/17.
//  Copyright © 2017年 wesai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWPhotoPickerDefine.h"

@interface RWPhotoAlbumViewController : UIViewController

@property (nonatomic, assign) NSInteger imageMaxCount;
@property (nonatomic, strong) NSMutableArray *selectedImageList;  // 选中的图片列表
@property (nonatomic, copy) PhotoPickerResultBlock resultBlock;

@end
