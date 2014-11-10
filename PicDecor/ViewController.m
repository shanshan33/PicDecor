//
//  ViewController.m
//  PicDecor
//
//  Created by Shanshan ZHAO on 03/11/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import "ViewController.h"
#import "ImageEditingViewController.h"

@interface ViewController ()

@property (nonatomic,strong) ImageEditingViewController * imageEditingVC;
@property (nonatomic) BOOL startedUp;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
 //   self.imageEditingVC = [ImageEditingViewController  new];
 //   Have to init like this, otherwise it will has black screen after presentViewController
    
    self.imageEditingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageEditingViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Directly go to albums if no camera detected
    if (!self.startedUp)
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self clickedAlbumButton:nil];
        }
    }
    self.startedUp = YES;
}

#pragma mark - user actions
- (IBAction)clickedCameraButton:(id)sender
{
    NSLog(@"Simulator can't launch camera");
    UIImagePickerController * ipController = [[UIImagePickerController alloc] init];
    if ([[[UIDevice currentDevice] model] rangeOfString:@"Sim"].location == NSNotFound)
    {
        [ipController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [ipController setDelegate:self];
        [self presentViewController:ipController animated:YES
                         completion: nil];
    }
}

- (IBAction)clickedAlbumButton:(id)sender
{
    
    UIImagePickerController * ipController = [UIImagePickerController new];
    [ipController setDelegate:self];
    [self presentViewController:ipController animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:NO completion:nil];
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageEditingVC.editImage = image;
   [self presentViewController:self.imageEditingVC animated:YES completion:nil];
}



@end
