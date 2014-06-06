//
//  DetailViewController.h
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface DetailViewController : UIViewController {
    UIImagePickerController *mediaPicker;
    __weak IBOutlet UITextField *taskTitleTextField;

}

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIButton *callDicoButton;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, strong) NSString *taskId;



- (IBAction)callDico:(UIButton*)sender;



@end
