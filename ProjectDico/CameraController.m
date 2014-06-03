////
////  CameraController.m
////  ProjectDico
////
////  Created by Nicole Zhu on 6/3/14.
////  Copyright (c) 2014 ProjectDico. All rights reserved.
////
//
//#import "CameraController.h"
//#import <MobileCoreServices/UTCoreTypes.h>
//
//@implementation CameraController (CameraDelegateMethods)
//
//// For responding to the user tapping Cancel.
//- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
//    
////    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
//    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
////    [picker release];
//}
//
//// For responding to the user accepting a newly-captured picture or movie
//- (void) imagePickerController: (UIImagePickerController *) picker
// didFinishPickingMediaWithInfo: (NSDictionary *) info {
//    
//    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
//    UIImage *originalImage, *editedImage, *imageToSave;
//    
//    // Handle a still image capture
//    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
//        == kCFCompareEqualTo) {
//        
//        editedImage = (UIImage *) [info objectForKey:
//                                   UIImagePickerControllerEditedImage];
//        originalImage = (UIImage *) [info objectForKey:
//                                     UIImagePickerControllerOriginalImage];
//        
//        if (editedImage) {
//            imageToSave = editedImage;
//        } else {
//            imageToSave = originalImage;
//        }
//        
//        // Save the new image (original or edited) to the Camera Roll
//        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
//    }
//    
//    // Handle a movie capture
//    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
//        == kCFCompareEqualTo) {
//        
//        NSString *moviePath = [[info objectForKey:
//                                UIImagePickerControllerMediaURL] path];
//        
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
//            UISaveVideoAtPathToSavedPhotosAlbum (
//                                                 moviePath, nil, nil, nil);
//        }
//    }
//    
//    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
////    [picker release];
//}
//
//@end
