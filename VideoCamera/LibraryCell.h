//
//  LibraryCell.h
//  VideoCamera
//
//  Created by Aditya Narayan on 4/26/16.
//  Copyright © 2016 TURN TO TECH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LibraryCell : UICollectionViewCell

@property (nonatomic, retain) NSString *name;

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;


@end
