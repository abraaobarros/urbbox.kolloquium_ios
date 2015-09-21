//
//  KQGalleryCollectionViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 16.09.15.
//  Copyright (c) 2015 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KQCache.h"
static NSString * const BHPhotoAlbumLayoutPhotoCellKind = @"PhotoCell";

@interface KQGalleryCollectionViewController : UICollectionViewController{
    NSArray *dataSource;
    KQCache *cache;
    NSArray *collectionImages;
    

}

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) NSArray *images;
@property (nonatomic, strong) NSDictionary *layoutInfo;
@end
