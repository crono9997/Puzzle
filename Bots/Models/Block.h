//
//  Block.h
//  Bots
//
//  Created by Jeremy Weeks on 10/19/13.
//  Copyright (c) 2013 Jeremy Weeks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Block : SKSpriteNode

@property (nonatomic) NSInteger rank;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) CGSize size;
@property (strong, nonatomic) SKLabelNode *label;

@property (strong, nonatomic) NSMutableDictionary *blockData;

-(Block*)initWithSize:(CGSize)size;
-(void)removeBlock;


@end

