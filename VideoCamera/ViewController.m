//
//  ViewController.m
//  VideoCamera
//
//  Created by Aditya Narayan on 4/21/16.
//  Copyright © 2016 TURN TO TECH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipe];
    self.view.frame = [[UIScreen mainScreen]bounds];
    [[VideoManager sharedManager]setUpSessionInView:self.view];
    self.recordButton.backgroundColor = [UIColor colorWithRed:246/255.0 green:50/255.0 blue:50/255.0 alpha:.3];
    [self.view addSubview:self.recordButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRegularCamera:(id)sender {
    [[VideoManager sharedManager] startUpCaptureSession];
    if([[VideoManager sharedManager]isOn]){
        self.recordButton.backgroundColor = [UIColor colorWithRed:246/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    }
    else{
        self.recordButton.backgroundColor = [UIColor colorWithRed:246/255.0 green:50/255.0 blue:50/255.0 alpha:.3];
    }
}


-(void)leftSwipe{
    VideoLibraryCollectionView *videoLibrary = [[VideoLibraryCollectionView alloc]initWithNibName:@"VideoLibraryCollectionView" bundle:nil];

    [self.navigationController pushViewController:videoLibrary animated:YES];
}
@end
