//
//  VideoManager.m
//  VideoCamera
//
//  Created by Aditya Narayan on 4/25/16.
//  Copyright © 2016 TURN TO TECH. All rights reserved.
//

#import "VideoManager.h"

@implementation VideoManager

+(instancetype) sharedManager {
    static VideoManager *theManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theManager = [[self alloc] init];
    });
    return theManager;
}

-(void)setUpSessionInView: (UIView*)view{
    //NSError *error;
    //create capture session

        NSError *error;
        self.session = [[AVCaptureSession alloc]init];
    
        for (AVCaptureDevice *device in [AVCaptureDevice devices]) {
            if(device.position == AVCaptureDevicePositionBack){
                self.cameraDevice = device;
            }
        }
        BOOL locked =[self.cameraDevice lockForConfiguration:&error];
        if(locked==YES){
            [self configureCameraForHighestFrameRate:self.cameraDevice];
        }
        self.micDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        AVCaptureDeviceInput *cameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.cameraDevice error:&error];
        AVCaptureDeviceInput *micDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.micDevice error:&error];
        self.output = [[AVCaptureMovieFileOutput alloc]init];
        if ([self.session canAddInput:micDeviceInput]) {
            [self.session addInput:micDeviceInput];
        }
        if ([self.session canAddInput:cameraDeviceInput]) {
            [self.session addInput:cameraDeviceInput];
        }
        if ([self.session canAddOutput:self.output]) {
            [self.session addOutput:self.output];
        }
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session]; //display recording data to user
        self.previewLayer.frame = view.bounds;
        [view.layer addSublayer:self.previewLayer];
        [self.session startRunning];
}

-(void)startUpCaptureSession{
    NSError *error = nil;
    if(self.output.isRecording){
        [self stopCaptureSession];
    }
    else{
        //path to documents
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [paths objectAtIndex:0];
    
        // creates moive directory if necessary
        if(![[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent: @"/MovieFolder"]]){
            [[NSFileManager defaultManager] createDirectoryAtPath: [filePath stringByAppendingPathComponent: @"/MovieFolder"]withIntermediateDirectories:NO attributes:nil error:&error];
        }
    
        //creates filepath in movie directory for fileoutput
        NSString *time = [NSString stringWithFormat: @"/MovieFolder/%f.mov", [[NSDate date]timeIntervalSince1970]];
        filePath = [filePath stringByAppendingPathComponent:time];
        NSURL *fileDestination = [NSURL fileURLWithPath:filePath];

        //start recording to file
        dispatch_queue_t onceToken;
        const char *label = "label";
        onceToken = dispatch_queue_create(label, NULL) ;
        
        dispatch_async(onceToken, ^(void){

        [self.output startRecordingToOutputFileURL:fileDestination recordingDelegate:self];
        NSLog(@"recording");
        });
    }
}


-(void)stopCaptureSession{
    [self.output stopRecording];
    NSLog(@"done recording");
}

-(BOOL)isOn{
    if(self.output.isRecording){ //this seems to be returning the opposite value I would expect
        return NO;
    }
    else{
        return YES;
    }
}

-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    NSLog(@"recording started");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    NSLog(@"recording captured");
}

-(UIImage*)generateThumbnailwithPath: (NSString*)path{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    filePath = [filePath stringByAppendingString:[NSString stringWithFormat:@"/MovieFolder/%@",path]];
    
    NSURL *videoURL = [NSURL fileURLWithPath:filePath];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL: videoURL options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *err = NULL;
    CMTime requestedTime = CMTimeMake(1, 60);     // To create thumbnail image
    CGImageRef imgRef = [generator copyCGImageAtTime:requestedTime actualTime:NULL error:&err];
    
    UIImage *thumbnail = [[UIImage alloc] initWithCGImage:imgRef];
    CGImageRelease(imgRef);    // MUST release explicitly to avoid memory leak???
    
    return thumbnail;
}

- (void)configureCameraForHighestFrameRate:(AVCaptureDevice *)device{
    AVCaptureDeviceFormat *bestFormat = nil;
    AVFrameRateRange *bestFrameRateRange = nil;
    for ( AVCaptureDeviceFormat *format in [device formats] ) {
        for ( AVFrameRateRange *range in format.videoSupportedFrameRateRanges ) {
            if ( range.maxFrameRate > bestFrameRateRange.maxFrameRate ) {
                bestFormat = format;
                bestFrameRateRange = range;
            }
        }
    }
    if ( bestFormat ) {
        if ( [device lockForConfiguration:NULL] == YES ) {
            device.activeFormat = bestFormat;
            device.activeVideoMinFrameDuration = bestFrameRateRange.minFrameDuration;
            device.activeVideoMaxFrameDuration = bestFrameRateRange.minFrameDuration;
            [device unlockForConfiguration];
        }
    }
}




@end
