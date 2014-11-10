//
//  ImageEditingViewController.m
//  PicDecor
//
//  Created by Shanshan ZHAO on 03/11/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import "ImageEditingViewController.h"
#import "DecorationViewController.h"
#import "MovableImageView.h"

@interface ImageEditingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *editingImageView;
@property (nonatomic,strong) DecorationViewController * decorationVC;
@property (nonatomic) BOOL selectingImage;

@property (nonatomic, strong)MFMailComposeViewController * mailController;


@end

@implementation ImageEditingViewController

#pragma mark - view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.decorationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DecorationViewController"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.editImage)
    {
        [self.editingImageView setImage:self.editImage];
        [self.view sendSubviewToBack:self.editingImageView];
    }
    
    if (self.selectingImage) {
        MovableImageView * movableImageView = [[MovableImageView alloc] initWithImage:self.decorationVC.selectedImage];
        [movableImageView setUserInteractionEnabled:YES];
        [movableImageView setFrame:CGRectMake(0, 0, 100, 100)];
        [self.view addSubview:movableImageView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - user actions
-(IBAction)discardDecroation:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickDecroateButton:(id)sender
{
    self.selectingImage = YES;
    [self presentViewController:self.decorationVC animated:YES completion:nil];
}

-(IBAction)saveImageToAlbum:(id)sender
{
    UIImage * image = [self saveImage:self.view];
    
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
}

- (IBAction)clickEmailButton:(id)sender
{
    self.mailController = [MFMailComposeViewController new];
    self.mailController.mailComposeDelegate = self;
    
    for (UIView * view in [self.view subviews])
    {
        if ([view isKindOfClass:[UIToolbar class]]) {
            view.hidden = YES;
        }
    }
    
    UIImage * image = [self saveImage:self.view];

    
    for (UIView * view in [self.view subviews])
    {
        if ([view isKindOfClass:[UIToolbar class]]) {
            view.hidden = NO;
        }
    }
    
    NSData * imageAsData = UIImagePNGRepresentation(image);
    [self.mailController addAttachmentData:imageAsData mimeType:@"image/png" fileName:@"imageDecor.png"];
    [self.mailController setSubject:@"image From my picDecor"];
    
    [self presentViewController:self.mailController animated:YES completion:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

#pragma mark - mailing photo
-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage *)saveImage:(UIView *)view
{
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(mainRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];

    CGContextFillRect(context, mainRect);
    [view.layer renderInContext:context];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

/**
 * scale and compress the user's created image to allow for faster emailing
 **/

-(UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
