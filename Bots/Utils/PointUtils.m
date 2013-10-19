//
//  PointUtils.m
//  Bots
//
//  Created by Jeremy Weeks on 10/16/13.
//  Copyright (c) 2013 Jeremy Weeks. All rights reserved.
//

#import "PointUtils.h"

@implementation PointUtils

+(CGFloat)getDistanceFromPoint:(CGPoint)point1 toPoint:(CGPoint)point2 {
    CGFloat xDist = (point2.x - point1.x);
    CGFloat yDist = (point2.y - point1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    
    return distance;
}

@end
