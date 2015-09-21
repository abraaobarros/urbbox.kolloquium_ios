//
//  KQGalleryPhotoViewController.h
//  Events
//
//  Created by Abraao Barros Lacerda on 17.09.15.
//  Copyright (c) 2015 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface KQGalleryPhotoViewController : UIViewController<UIGestureRecognizerDelegate>{
    
    CGFloat _lastScale;
    CGFloat _lastRotation;
    CGFloat _firstX;
    CGFloat _firstY;
    
    UIImageView *photoImage;
    UIView *canvas;
    
    CAShapeLayer *_marque;
    
}

@property (nonatomic, retain) IBOutlet UIView *canvas;
@property (nonatomic, retain) IBOutlet UIImageView *photoImage;


@property (weak, nonatomic) IBOutlet UINavigationItem *name;
@property (strong, nonatomic)IBOutlet UIImageView *image;
@property (strong, nonatomic) NSDictionary *data;

@end
