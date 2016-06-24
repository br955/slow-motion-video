//
//  VideoManager.h
//  VideoCamera
//
//  Created by Aditya Narayan on 4/25/16.
//  Copyright © 2016 TURN TO TECH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>


@interface VideoManager : NSObject <AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, retain) AVCaptureDevice *cameraDevice;
@property (nonatomic, retain) AVCaptureDevice *micDevice;
@property (nonatomic, retain) AVCaptureInput *input;
@property (nonatomic, retain) AVCaptureSession *session;
@property (nonatomic, retain) AVCaptureMovieFileOutput *output;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *previewLayer;

+(id) sharedManager;

-(void)startUpCaptureSession;

-(void)stopCaptureSession;

- (void)configureCameraForHighestFrameRate:(AVCaptureDevice *)device;

-(UIImage*)generateThumbnailwithPath: (NSString*)path;

-(BOOL)isOn;

-(void)setUpSessionInView: (UIView*)view;

@end
