//
//  LocalPhotoViewController.h
//  AlbumTest
//
//  Created by ejiang on 14-7-28.
//  Copyright (c) 2014年 daijier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LocalPhotoCell.h"
#import "LocalAlbumTableViewController.h"
#import "AssetHelper.h"
@class ViewController;
@protocol SelectPhotoDelegate<NSObject>
-(void)getSelectedPhoto:(NSMutableArray *)photos;
@end
@interface LocalPhotoViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,SelectAlbumDelegate>
@property (retain, nonatomic) IBOutlet UICollectionView *collection;
@property (retain, nonatomic) IBOutlet UILabel *lbAlert;
- (IBAction)btnConfirm:(id)sender;
@property (nonatomic,retain) id<SelectPhotoDelegate> selectPhotoDelegate;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) ALAssetsGroup *currentAlbum;
@property (nonatomic, strong) NSMutableArray *selectPhotos;
@end
