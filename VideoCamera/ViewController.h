//
//  ViewController.h
//  VideoCamera
//
//  Created by Aditya Narayan on 4/21/16.
//  Copyright © 2016 TURN TO TECH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoManager.h"
#import "VideoLibraryCollectionView.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>

- (IBAction)startRegularCamera:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *recordButton;



@end

