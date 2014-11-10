//
//  ImageEditingViewController.h
//  PicDecor
//
//  Created by Shanshan ZHAO on 03/11/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ImageEditingViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (nonatomic,strong) UIImage * editImage;


@end
