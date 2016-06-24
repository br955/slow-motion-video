//
//  LibraryCell.m
//  VideoCamera
//
//  Created by Aditya Narayan on 4/26/16.
//  Copyright © 2016 TURN TO TECH. All rights reserved.
//

#import "LibraryCell.h"

@implementation LibraryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"LibraryCell" owner:self options:nil];
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0 ];
    }
    return self;
}

@end
