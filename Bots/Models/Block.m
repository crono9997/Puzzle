//
//  Block.m
//  Bots
//
//  Created by Jeremy Weeks on 10/19/13.
//  Copyright (c) 2013 Jeremy Weeks. All rights reserved.
//

#import "Block.h"
#import "MyScene.h"

@implementation Block

static NSArray *uiColors;

+ (void)initialize {
    uiColors = @[UIColor.redColor, UIColor.blueColor, UIColor.greenColor, UIColor.yellowColor, UIColor.purpleColor];
}

-(Block*)init {
    Block *block = [[self superclass] init];
    
    block.rank = arc4random() % uiColors.count;
    
    return block;
}

-(Block*)initWithSize:(CGSize)size {
    
    int rank = arc4random() % uiColors.count;
    
    Block *block = [Block spriteNodeWithColor:uiColors[rank] size:size];
    
//    Block *block = [[self superclass] init];
    
    block.rank = rank;
    block.size = size;
    
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    myLabel.text = @"J";
    myLabel.fontSize = 30;
    myLabel.position = CGPointMake(0,-10);
    
    block.label = myLabel;

//    [block addChild:myLabel];
    
    return block;
}

-(void)draw {
    
}

-(void)tryToRemoveBlock:(Block*)block{
    if([[block blockData][@"active"]  isEqual: @YES] && block.rank == self.rank){
        [block removeBlock];
    }
}

-(void)removeBlock {
    int row = [self.blockData[@"row"] integerValue];
    int col = [self.blockData[@"col"] integerValue];
    
    self.blockData[@"active"] = @NO;
    
    if(row > 0){
        [self tryToRemoveBlock:[MyScene blockIndexes][col][row-1][@"block"]];
    }
    
    if(row < [[MyScene blockIndexes][0] count]-1){
        [self tryToRemoveBlock:[MyScene blockIndexes][col][row+1][@"block"]];
    }
    
    if(col > 0){
        [self tryToRemoveBlock:[MyScene blockIndexes][col-1][row][@"block"]];
    }
    
    if(col < [MyScene blockIndexes].count-1){
        [self tryToRemoveBlock:[MyScene blockIndexes][col+1][row][@"block"]];
    }
    
//    [[MyScene blockIndexes][col-1][row][@"block"] removeFromParent];
    
    int count = [[MyScene blockIndexes][col] count];
//    NSLog(@"123");
    
    [self removeFromParent];
}

-(UIColor*)color {
    UIColor *uiColor = uiColors[self.rank];
    
    return uiColor;
}

-(void)sizeByFloat:(CGFloat)size {
    self.size = CGSizeMake(size, size);
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"jhadsgjhkfadsgkjadsfg");
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        [self removeFromParent];
//        return;
//    }
//}

@end
