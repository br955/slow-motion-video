//
//  VideoLibraryCollectionView.h
//  VideoCamera
//
//  Created by Aditya Narayan on 4/27/16.
//  Copyright © 2016 TURN TO TECH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibraryCell.h"
#import "VideoManager.h"
#import <AVKit/AVKit.h>

@interface VideoLibraryCollectionView : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) NSArray *videos;

@property (nonatomic, retain) AVPlayerViewController *playerController;

@property (nonatomic, retain) AVPlayerItem *playerItem;

@property (nonatomic, retain) UIBarButtonItem *slomoBarButton;

@property BOOL slomo;


@end
