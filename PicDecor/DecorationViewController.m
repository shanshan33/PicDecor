//
//  DecorationViewController.m
//  PicDecor
//
//  Created by Shanshan ZHAO on 03/11/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import "DecorationViewController.h"

@interface DecorationViewController ()


@end

@implementation DecorationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - user actions

- (IBAction)doImageButton:(id)sender
{
    self.selectedImage = [sender backgroundImageForState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doCancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.selectedImage = nil;
}


@end
