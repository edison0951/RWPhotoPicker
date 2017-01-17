//
//  RWPhotoPickerViewController.h
//
//  Created by riven wang on 2017/1/17.
//  Copyright © 2017年 wesai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWPhotoPickerDefine.h"
#import <AssetsLibrary/ALAssetRepresentation.h>

@interface RWPhotoPickerViewController : UICollectionViewController
//是否是视频
@property (nonatomic, assign) BOOL isDuringVideo;
//允许最大图片数
@property (nonatomic, assign) NSInteger imageMaxCount;
//已经选中的图片列表
@property (nonatomic, readonly) NSArray *selectedImageList;
//选择的相册
@property (nonatomic, strong) ALAssetsGroup* assetGroup;

@property (nonatomic, copy) PhotoPickerResultBlock resultBlock;

//@property (nonatomic, weak) id<WSPhotoListDelegate> delegate;

- (instancetype)initWithSelectedImages:(NSArray *)selectedImages;
//打开相机
- (void)openCamera;
//选中图片
//- (void)photoPressed:(WSPhotoListItem *)item indexPath:(NSIndexPath *)indexPath;
@end
