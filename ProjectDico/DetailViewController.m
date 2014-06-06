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

//-(void)setTaskId:(NSString *)taskId {
//    
//    if (!_taskId) {
//        _taskId = taskId;
//    }
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
   
}

//initializes task in DB
-(void) createTask {
    if ([self.taskId isEqualToString:@"0"]) {  //if new task
        PFObject *newTask = [PFObject objectWithClassName:@"tasks"];
        //       TODO figure this out newTask[@"username"] =
        newTask[@"progress"] = @0;
        
        NSString *title = [taskTitleTextField text];
        NSLog(@"title: %@", title);
        if([title length]>0) {
            newTask[@"taskTitle"] = title;
        } else {
            newTask[@"taskTitle"] = @"No Task Name";
        }

        [newTask save];
        self.taskId = [newTask objectId];
        NSLog(@"Task ID is: %@", [newTask objectId] );
    }

}

//SAVE/CREATES tasks
- (IBAction)saveTaskBtn:(id)sender {
    if ([self.taskId isEqualToString:@"0"]) {
        [self createTask];
        
    } else {// save updates only (for when taskId exists)
        PFQuery *query = [PFQuery queryWithClassName:@"tasks"];
        [query whereKey:@"objectId" equalTo:self.taskId];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *task, NSError *error){
            if (!error) { //has a complete list
                NSString *title = [taskTitleTextField text];
                NSLog(@"title: %@", title);
                if(title && [title length] > 0) {
                    task[@"taskTitle"] = title;
                } else {
                    task[@"taskTitle"] = @"No Task Name";
                }
            } else {
                NSLog(@"saved task is not in db for some reason");
            }
        }];
    }
    NSLog(@"clicked save");
    
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

}

- (IBAction)goToDetailViewController :(UIStoryboardSegue*)segue {
    
}
@end
