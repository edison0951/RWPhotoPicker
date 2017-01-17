//
//  RWPhotoAlbumTableViewCell.m
//
//  Created by riven wang on 2017/1/17.
//  Copyright © 2017年 wesai. All rights reserved.
//

#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "RWPhotoAlbumTableViewCell.h"
#import "RWPhotoPickerDefine.h"
#import "RWPhotoAlbumModel.h"

@implementation RWPhotoAlbumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)updateWithModel:(RWPhotoAlbumModel *)albumModel
{
    [albumModel.group setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger gCount = [albumModel.group numberOfAssets];
    
    self.textLabel.text = [NSString stringWithFormat:@"%@ (%zi)",[albumModel.group valueForProperty:ALAssetsGroupPropertyName], gCount];
    [self.imageView setImage:[UIImage imageWithCGImage:[albumModel.group posterImage]]];
}
@end
