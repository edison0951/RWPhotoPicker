//
//  RWPhotoAlbumViewController.m
//
//  Created by riven wang on 2017/1/17.
//  Copyright © 2017年 wesai. All rights reserved.
//

#import "RWPhotoAlbumViewController.h"
#import "RWPhotoPickerViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

#import "RWPhotoAlbumModel.h"
#import "RWPhotoAlbumTableViewCell.h"

@interface RWPhotoAlbumViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) ALAssetsLibrary *library;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation RWPhotoAlbumViewController

#pragma mark - Property
- (ALAssetsLibrary *)library
{
    if (_library == nil) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setShowsVerticalScrollIndicator:NO];
    }
    return _tableView;
}

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.添加子View
    [self.view addSubview:self.tableView];
    self.title = @"相册";
    // 2.添加相册数据
    [self loadAlbumData];
    // 3.设置顶部右上按钮
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    [self.navigationItem setRightBarButtonItem:cancelItem];
    // 4.添加监听
    [self addNotificationObserver];
}


#pragma mark - Private

- (void)addNotificationObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responseToLibraryChanged:) name:ALAssetsLibraryChangedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(assetChanged:) name:ALAssetLibraryUpdatedAssetsKey object:nil];
}

- (void)loadAlbumData
{
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       @autoreleasepool {
                           void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                           {
                               if (group == nil) {
                                   return;
                               }
                               NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                               NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                               
                               RWPhotoAlbumModel *albumModel = [RWPhotoAlbumModel new];
                               albumModel.group = group;
                               if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
                                   [self.dataArray insertObject:albumModel atIndex:0];
                               }else {
                                   [self.dataArray addObject:albumModel];
                                   
                                   [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
                               }
                           };
                           
                           void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                               
                               UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                               [alert show];
                               
                               NSLog(@"A problem occured %@", [error description]);
                           };
                           [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                                                       usingBlock:assetGroupEnumerator
                                                     failureBlock:assetGroupEnumberatorFailure];
                       }
                   });
}

- (void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - notification

- (void)responseToLibraryChanged:(NSNotification*)note
{
    NSSet* AssetsKey = note.userInfo[@"ALAssetLibraryUpdatedAssetsKey"];
    if (AssetsKey) {
        
        [AssetsKey enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            
            NSURL* urlStr = obj;
            [self.library assetForURL:urlStr resultBlock:^(ALAsset *asset) {
                
            } failureBlock:^(NSError *error) {
                
            }];
        }];
        
    }
    [self loadAlbumData];
}

- (void)assetChanged:(NSNotification*)note
{
    NSLog(@"assetChanged:%@", note.userInfo);
}

#pragma mark -TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RWPhotoAlbumTableViewCell *cell = nil;
    NSString *cellIdentifier = NSStringFromClass([RWPhotoAlbumTableViewCell class]);
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[RWPhotoAlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    RWPhotoAlbumModel *albumModel = [self.dataArray objectAtIndex:indexPath.row];
    [cell updateWithModel:albumModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWPhotoAlbumModel *albumModel = [self.dataArray objectAtIndex:indexPath.row];
    
    RWPhotoPickerViewController *controller = [[RWPhotoPickerViewController alloc] initWithSelectedImages:self.selectedImageList];
    controller.imageMaxCount = self.imageMaxCount;
    controller.resultBlock = self.resultBlock;
    controller.assetGroup = albumModel.group;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
