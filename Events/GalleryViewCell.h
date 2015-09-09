//
//  GalleryViewCell.h
//  Events
//
//  Created by Razu on 16/04/15.
//  Copyright (c) 2015 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *imageName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void)updateCell;

@end
