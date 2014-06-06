//
//  DetailViewController.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

//@synthesize taskId;
-(void)setTaskId:(NSString *)taskId {
    NSLog(@"here");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    
    //if the taskId doesn't exist yet in controller (not passed in from main)
    if (self.taskId == 0) {  //if new task
        PFObject *newTask = [PFObject objectWithClassName:@"tasks"];
//       TODO figure this out newTask[@"username"] =
        
        newTask[@"taskTitle"] = @"No Task Name";
        newTask[@"progress"] = 0;
        [newTask saveInBackground];

        NSLog(@"Task ID is: %@", [newTask objectForKey:@"objectId"] );
        //TODO get and save tasks objectId
        
    } else {    //if accessing a saved task
        PFQuery *query = [PFQuery queryWithClassName:@"tasks"];
        [query whereKey:@"objectId" equalTo:self.taskId];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if ([objects count] > 0) { //has a complete list
                NSLog(@"found task");
            } else {
                NSLog(@"saved task is not in db for some reason");
            }
        }];

    }
    
   
}


//SAVE task instead of outsource
- (IBAction)saveTaskBtn:(id)sender {
    NSLog(@"clicked save");
    
    //TODO save to DB here. dep on the information availablable
    
    
    //check if taskID is in DB (called objectId in db)
    
    //else
        //check if title
            //save title
            //save username
    
    
        //else
            //give title "Task name?"
}



-(void)hideKeyBoard {
    [taskTitleTextField resignFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSString * const kDicoNumber = @"6263846965";

- (IBAction)callDico:(UIButton*)sender {
    NSLog(@"callling");
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@", kDicoNumber]];
    
    [[UIApplication sharedApplication] openURL:phoneUrl];
}

//
////CAMERA
//
- (IBAction)handleUploadPhotoTouch:(id)sender {
    
    mediaPicker = [[UIImagePickerController alloc] init];
    mediaPicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:(id)self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take photo", @"Choose Existing", nil];
        [actionSheet showInView:self.view];
    } else {
        mediaPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:mediaPicker animated:YES completion:nil];

    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        mediaPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if (buttonIndex == 1) {
        mediaPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:mediaPicker animated:YES completion:nil];

//    [actionSheet release];
}

//- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
//                                   usingDelegate: (id <UIImagePickerControllerDelegate,
//                                                   UINavigationControllerDelegate>) delegate {
//    
//    if (([UIImagePickerController isSourceTypeAvailable:
//          UIImagePickerControllerSourceTypeCamera] == NO)
//        || (delegate == nil)
//        || (controller == nil))
//        return NO;
//    
//    
//    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
//    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    // Displays a control that allows the user to choose picture or
//    // movie capture, if both are available:
//    cameraUI.mediaTypes =
//    [UIImagePickerController availableMediaTypesForSourceType:
//     UIImagePickerControllerSourceTypeCamera];
//    
//    // Hides the controls for moving & scaling pictures, or for
//    // trimming movies. To instead show the controls, use YES.
//    cameraUI.allowsEditing = NO;
//    
//    cameraUI.delegate = delegate;
//    
//    [controller presentModalViewController: cameraUI animated: YES];
//    return YES;
//}
//
//- (IBAction) showCameraUI {
//    [self startCameraControllerFromViewController: self
//                                    usingDelegate: self];
//}



- (IBAction)goToDetailViewController :(UIStoryboardSegue*)segue {
    
}
@end
