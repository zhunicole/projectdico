//
//  DetailViewController.h
//  ProjectDico
//
//  Created by Nicole Zhu on 5/24/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIButton *callDicoButton;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;


- (IBAction)callDico:(UIButton*)sender;



@end
