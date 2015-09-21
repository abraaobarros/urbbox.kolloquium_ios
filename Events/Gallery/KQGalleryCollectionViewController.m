//
//  KQGalleryCollectionViewController.m
//  Events
//
//  Created by Abraao Barros Lacerda on 16.09.15.
//  Copyright (c) 2015 Teknowledge Software. All rights reserved.
//

#import "KQGalleryCollectionViewController.h"
#import "KQGalleryCollectionViewCell.h"
#import "KQGalleryPhotoViewController.h"
#import "KQEventAPI.h"
#import "Util.h"


@implementation KQGalleryCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cache = [KQCache sharedManager];
    
    NSDictionary *data = [cache getDataFromHash:@"http://kolloquium.herokuapp.com/rest/event/1"];
    
    dataSource = [data objectForKey:@"albums"];
    
    collectionImages = [NSArray arrayWithObjects:@"start.png",@"bg_restaurant.png",@"bg_restaurant.png",@"bg_restaurant.png",@"bg_restaurant.png",@"bg_restaurant.png",@"start.png",@"start.png",@"start.png",@"start.png",@"start.png",@"start.png",@"start.png",@"start.png",@"start.png",@"start.png",@"start.png", nil];
    
    [Util setupNavigationBar:self withTitle:@"Fotos"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[dataSource objectAtIndex:section] objectForKey:@"photos"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    CGRect frame = cell.frame;
    frame.size.height = 100;
    frame.size.width  = 78;
    cell.frame = frame;
    UIImageView *collectionImageView = (UIImageView *)[cell viewWithTag:100];
    [KQEventAPI getImageFromUrl:[self getImageUrlFromIndex:indexPath] finishHandler:^(NSData* data){
        
        
        collectionImageView.image = [UIImage imageWithData:data];
   
    } startHandler:^{
        
    } errorHandler:^{
        
    }];
    
    return cell;
}


-(NSDictionary *) getImageData:(NSIndexPath *)indexPath{
    return [[[dataSource objectAtIndex:indexPath.section]
              objectForKey:@"photos"]
             objectAtIndex:indexPath.row];
}

-(NSString *) getImageUrlFromIndex:(NSIndexPath *)indexPath{
    
    
    return [[self getImageData:indexPath]
            objectForKey:@"image"];

}


NSIndexPath *selectedIndex;

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    selectedIndex = indexPath;
    [self performSegueWithIdentifier:@"GalleryPhotoViewController" sender:self];
    
    NSLog(@"%ld",(long)indexPath.row);
    NSLog(@"%ld",(long)indexPath.section);
}

-(NSUInteger)countOfNumberOfColumns{

    return 4;
    
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize = CGSizeMake(125.0f, 125.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([[segue identifier] isEqualToString:@"GalleryPhotoViewController"]) {
        
        KQGalleryPhotoViewController *vc = (KQGalleryPhotoViewController *)[segue destinationViewController];
        vc.data = [self getImageData:selectedIndex];
        
    }

}




-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableview = headerView;
        UILabel *albumTitle =(UILabel *) [reusableview viewWithTag:1];
        UILabel *albumLegendTitle =(UILabel *) [reusableview viewWithTag:2];
        
        albumTitle.text = [[dataSource objectAtIndex:indexPath.section] objectForKey:@"name"];
        albumLegendTitle.text = [[dataSource objectAtIndex:indexPath.section] objectForKey:@"legend"];
        
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
    

}
@end
