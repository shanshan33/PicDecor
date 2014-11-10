//
//  MovableImageView.m
//  PicDecor
//
//  Created by Shanshan ZHAO on 05/11/14.
//  Copyright (c) 2014 Shanshan ZHAO. All rights reserved.
//

#import "MovableImageView.h"

@implementation MovableImageView


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    // Double click to deselect decorate image
    if ([[touches  anyObject] tapCount] == 2) {
        [self removeFromSuperview];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    //configure movement
    float deltaX = [[touches anyObject] locationInView:self].x - [[touches anyObject] previousLocationInView:self].x;
    float deltaY = [[touches anyObject] locationInView:self].y - [[touches anyObject] previousLocationInView:self].y;
    
    self.transform = CGAffineTransformTranslate(self.transform, deltaX, deltaY);
}

@end
