//
//  VideoLibraryCollectionView.m
//  VideoCamera
//
//  Created by Aditya Narayan on 4/27/16.
//  Copyright © 2016 TURN TO TECH. All rights reserved.
//

#import "VideoLibraryCollectionView.h"

@interface VideoLibraryCollectionView ()

@end

@implementation VideoLibraryCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.delegate = self;
    
    // Register cell classes
    [self.collectionView registerClass:[LibraryCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.dataSource = self;
    
    // Do any additional setup after loading the view.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    NSString *folderPath = [filePath stringByAppendingPathComponent:@"/MovieFolder"];
    self.videos = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:folderPath error:&error];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:toolbar];
    
    self.slomo = NO;
    
    self.slomoBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Start Slomo" style:UIBarButtonItemStylePlain target:self action:@selector(slomoToggle)];
    
    toolbar.items = @[self.slomoBarButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)slomoToggle{
    if(self.slomo){
        self.slomo = NO;
        self.slomoBarButton.title = @"Start Slomo";
        self.slomoBarButton.tintColor = [UIColor greenColor];
    }
    else{
        self.slomo = YES;
        self.slomoBarButton.title = @"End Slomo";
        self.slomoBarButton.tintColor = [UIColor redColor];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.videos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LibraryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    cell.name = [self.videos objectAtIndex:[indexPath row]];
    cell.thumbnail.image = [[VideoManager sharedManager] generateThumbnailwithPath:cell.name];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name =[ self.videos objectAtIndex:[indexPath row]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    filePath = [filePath stringByAppendingString:[NSString stringWithFormat:@"/MovieFolder/%@",name]];
    
    NSURL *videoURL = [NSURL fileURLWithPath:filePath];
    self.playerController = [[AVPlayerViewController alloc]init];
    self.playerItem  = [[AVPlayerItem alloc]initWithURL:videoURL];
    self.playerController.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    if(self.slomo){
        self.playerController.player.rate = .5;
    }
    else{
        self.playerController.player.rate = 1;
    }
    [self.navigationController pushViewController:self.playerController animated:YES];
    
}



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
