//
//  ViewController.m
//  OCRResult
//
//  Created by XingJie on 2017/7/4.
//  Copyright © 2017年 xingjie. All rights reserved.
//

#import "ViewController.h"
#import "G8RecognitionOperation.h"
#import "MAImagePickerController.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface ViewController ()<G8TesseractDelegate,MAImagePickerControllerDelegate>

@property (nonatomic, strong) NSOperationQueue *operationQueue;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.operationQueue = [[NSOperationQueue alloc]init];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}
-(void)recognizeImageWithTesseract:(UIImage *)image
{
    // Animate a progress activity indicator
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Create a new `G8RecognitionOperation` to perform the OCR asynchronously
    // It is assumed that there is a .traineddata file for the language pack
    // you want Tesseract to use in the "tessdata" folder in the root of the
    // project AND that the "tessdata" folder is a referenced folder and NOT
    // a symbolic group in your project
    
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"chi_sim"];
    
    // Use the original Tesseract engine mode in performing the recognition
    // (see G8Constants.h) for other engine mode options
    
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Let Tesseract automatically segment the page into blocks of text
    // based on its analysis (see G8Constants.h) for other page segmentation
    // mode options
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAuto;
    
    // Optionally limit the time Tesseract should spend performing the
    // recognition
    //operation.tesseract.maximumRecognitionTime = 1.0;
    
    // Set the delegate for the recognition to be this class
    // (see `progressImageRecognitionForTesseract` and
    // `shouldCancelImageRecognitionForTesseract` methods below)
    operation.delegate = self;
    
    // Optionally limit Tesseract's recognition to the following whitelist
    // and blacklist of characters
    //operation.tesseract.charWhitelist = @"01234";
    //operation.tesseract.charBlacklist = @"56789";
    
    // Set the image on which Tesseract should perform recognition
    operation.tesseract.image = image;
    
    
    // Optionally limit the region in the image on which Tesseract should
    // perform recognition to a rectangle
    //operation.tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Specify the function block that should be executed when Tesseract
    // finishes performing recognition on the image
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        // Fetch the recognized text
        NSString *recognizedText = tesseract.recognizedText;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSLog(@"%@", recognizedText);
        
        // Spawn an alert with the recognized text
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OCR Result"
                                                        message:recognizedText
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    };
    
    // Finally, add the recognition operation to the queue
    [self.operationQueue addOperation:operation];
}

- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;
}

- (IBAction)initButton:(id)sender
{
    MAImagePickerController *imagePicker = [[MAImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setSourceType:MAImagePickerControllerSourceTypeCamera];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePicker];
    [self presentViewController:navigationController animated:YES completion:nil];
}
#pragma mark - MAImagePickerControllerDelegate
- (void)imagePickerDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerDidChooseImageWithPath:(NSString *)path
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]){
        NSLog(@"File Found at %@", path);
        UIImage *needRecognizedImage = [UIImage imageWithContentsOfFile:path];
        [self recognizeImageWithTesseract:[self tranImageForrecognize:needRecognizedImage]];
    }else{
        NSLog(@"No File Found at %@", path);
    }
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}
#pragma mark - Private
- (UIImage *)tranImageForrecognize:(UIImage *)needRecognizedImage{
    
    UIImage *imageToDisplay =[UIImage imageWithCGImage:[needRecognizedImage CGImage]
                                                 scale:1.0
                                           orientation: UIImageOrientationRight];
    
    UIImage *newImage  = [UIImage imageWithCGImage:[imageToDisplay CGImage]
                                             scale:1.0
                                       orientation: UIImageOrientationDown];
    
    UIImage *newImage2 = [UIImage imageWithCGImage:[newImage CGImage]
                                             scale:1.0
                                       orientation: UIImageOrientationLeft];
    return newImage2;
}
@end
