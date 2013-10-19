//
//  MyScene.m
//  Bots
//
//  Created by Jeremy Weeks on 10/11/13.
//  Copyright (c) 2013 Jeremy Weeks. All rights reserved.
//

#import "MyScene.h"
#import "PointUtils.h"
#import "Block.h"

@interface MyScene ()

@property SKSpriteNode *fire;
@property SKSpriteNode *board;
@property NSMutableArray *fires;

@property int rowCount;
@property int colCount;
@property int tileSize;
@property float fallSpeed;
@property CGPoint startPoint;


//@property NSMutableArray *blocks;




@end

static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t monsterCategory        =  0x1 << 1;

static NSMutableArray *blocks;

static NSMutableArray *blockIndexes;

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        
//        myLabel.text = @"Hello, World!";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//        
//        [self addChild:myLabel];
    }
    
//    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
//    self.fire = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
//    //self.fire.position = CGPointMake(screenWidth/2, 15);
//    [self addChild:self.fire];
    
    blocks = [@[] mutableCopy];
    blockIndexes = [@[] mutableCopy];
    
    self.board = [[SKSpriteNode alloc] init];
    [self.board setPosition:CGPointMake(20, 20)];
    [self addChild:self.board];
    
    self.fire = [SKSpriteNode spriteNodeWithImageNamed:@"spark"];
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    
    self.fire.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.fire.size.width/4]; // 1
    self.fire.physicsBody.dynamic = YES; // 2
    self.fire.physicsBody.categoryBitMask = monsterCategory; // 3
    self.fire.physicsBody.contactTestBitMask = projectileCategory; // 4
    self.fire.physicsBody.collisionBitMask = 0; // 5

    UIImage *image = [UIImage imageWithContentsOfFile:@"spark"];
    CGImageRef imageRef = [image CGImage];
    
    
    SKEffectNode *lightingNode = [[SKEffectNode alloc] init];
//    [lightingNode addChild:self.fire];
//    self.fire.blendMode = SKBlendModeAdd;
    
    self.blendMode = SKBlendModeAdd;
    
    SKSpriteNode *topWithText = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(300, 300)];
    topWithText.position = CGPointMake(200, 200);
//    [self addChild:topWithText];
    
    SKCropNode *cropNode = [[SKCropNode alloc] init];
    cropNode.position = CGPointMake(0,0);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
//    CGContextFillRect((__bridge CGContextRef)(context), CGRectMake(0,0,500,500));
    
    [context drawImage:[image CIImage] inRect:CGRectMake(0, 0, 100, 100) fromRect:CGRectMake(0, 0, 100, 100)];
    
//    context
    
//    self.fire
    
//    SKTexture *s = [SKTexture textureWithImage:  ]
//    SKSpriteNode *ss = [[SKSpriteNode alloc] initWithImageNamed:@"Spaceship"];
//    cropNode.maskNode = ss;
//    [cropNode.maskNode setPosition:CGPointMake(200,200)];
////    [cropNode.maskNode add]
//    [cropNode addChild: topWithText];
//    [self addChild:cropNode];
    
//    int rows = 9;
//    int cols = 15;
//    int tileSize = 40;
//    
//    CGPoint start = CGPointMake(0, 0);
//    
//    for(int j = 0; j< cols; j++){
//        for(int i = 0; i< rows; i++){
//            SKSpriteNode *n = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(tileSize-2, tileSize-2)];
//            [n setPosition:CGPointMake(i*tileSize+start.x, j*tileSize+start.y)];
//            [self addChild:n];
//            
//            n.name = @"block";
//            
//            n.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:n.size ];
//            n.physicsBody.dynamic = YES;
//            n.physicsBody.categoryBitMask = projectileCategory;
//            n.physicsBody.contactTestBitMask = monsterCategory;
//            n.physicsBody.collisionBitMask = 0;
////            n.physicsBody.usesPreciseCollisionDetection = YES;
//        }
//    }

    self.rowCount = 14;
    self.colCount = 8;
    self.tileSize = 40;
    self.fallSpeed = 0.1;
    
    int rows = self.rowCount;
    int cols = self.colCount;
    int tileSize = self.tileSize;
    
    CGPoint start = CGPointMake(0, 0);

    for(int i = 0; i< cols; i++){
        NSMutableArray *rowArray = [@[] mutableCopy];
        [blockIndexes addObject:rowArray];
        for(int j = 0; j< rows; j++){
            [self addBlockAtColumn:i andRow:j+1];
        }
    }

    
    
//    for(int i = 0; i< cols; i++){
//        NSMutableArray *rowArray = [@[] mutableCopy];
//        [blockIndexes addObject:rowArray];
//        for(int j = 0; j< rows; j++){
//            Block *block = [[Block alloc] initWithSize:CGSizeMake(tileSize-2, tileSize-2)];
//
//            [block setPosition:CGPointMake(i*tileSize+start.x, j*tileSize+start.y)];
//            [self addChild:block];
//            
//            NSMutableDictionary *blockData = [@{
//                @"block": block,
//                @"active": @YES,
//                @"col": [NSNumber numberWithInt:i],
//                @"row": [NSNumber numberWithInt:j]
//            } mutableCopy];
//            
//            block.blockData = blockData;
//            [blocks addObject:blockData];
//            [rowArray addObject:blockData];
//            
//            block.name = @"block";
//            
//            block.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:block.size ];
//            block.physicsBody.dynamic = YES;
//            block.physicsBody.categoryBitMask = projectileCategory;
//            block.physicsBody.contactTestBitMask = monsterCategory;
//            block.physicsBody.collisionBitMask = 0;
//        }
//    }

    
    [self addChild: self.fire];
    
    
    
//    cropNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ss.size ];
//    cropNode.physicsBody.dynamic = YES;
//    cropNode.physicsBody.categoryBitMask = projectileCategory;
//    cropNode.physicsBody.contactTestBitMask = monsterCategory;
//    cropNode.physicsBody.collisionBitMask = 0;
//    cropNode.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    
    
    
    
//    [self addChild:gameControlNodes];
    
//    [self addChild:self.fire];
    
    self.fires = [@[] mutableCopy];
    return self;
}

-(void)addBlockAtColumn:(int)column andRow:(int)rowAbove{
    Block *block = [[Block alloc] initWithSize:CGSizeMake(self.tileSize-2, self.tileSize-2)];
    //            SKSpriteNode *n = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(tileSize-2, tileSize-2)];
    
    if(!rowAbove)rowAbove = 0;
    
    int row = [blockIndexes[column] count];
    [block setPosition:CGPointMake(column * self.tileSize, (self.rowCount+rowAbove) * self.tileSize)];
//        [block setPosition:CGPointMake(column * self.tileSize, row * self.tileSize)];
    [self.board addChild:block];
    
    NSMutableDictionary *blockData = [@{
                                        @"block": block,
                                        @"active": @YES,
                                        @"col": [NSNumber numberWithInt:column],
                                        @"row": [NSNumber numberWithFloat:row]
                                        } mutableCopy];
    
    block.blockData = blockData;
    [blocks addObject:blockData];
    [blockIndexes[column] addObject:blockData];
    
    CGPoint point2 = CGPointMake(column*self.tileSize, row*self.tileSize);
    SKAction *action = [SKAction moveTo:point2 duration:self.fallSpeed * ((rowAbove + self.rowCount) - row) + (row * 0.02)];
    [block runAction:action];
    
    [block.label setText:[NSString stringWithFormat:@"%d", row]];
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    [self removeChildrenInArray:@[projectile]];
//    NSLog(@"Hit");
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    // 1
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // 2
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & monsterCategory) != 0)
    {
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
}

-(void)createFireAtPoint:(CGPoint)point {
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
    SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    [fire setPosition:point];
    [self addChild:fire];
    [self.fires addObject:fire];
}

-(void)removeFires{
    [self removeChildrenInArray:self.fires];
    self.fires = [@[] mutableCopy];
}

+(NSMutableArray*)blocks{
    return blocks;
}

+(NSMutableArray*)blockIndexes{
    return blockIndexes;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
//    [self removeFires];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self.board];
        
        for (NSDictionary *dict in blocks){
            Block *block = dict[@"block"];
            if([block containsPoint:location]){
                [block removeBlock];
            }
        }
        
        for(int i = 0; i< blockIndexes.count; i++){
            NSMutableArray *indexes = [@[] mutableCopy];
            int index = 0;
            for(int j = 0; j< [blockIndexes[i] count]; j++){
                if([blockIndexes[i][j][@"active"] isEqual:@NO]){
                    [indexes addObject:blockIndexes[i][j]];
                    NSLog(@"----------------------");
                    NSLog(@"%d", [blocks count]);
                    [blocks removeObject:blockIndexes[i][j]];
                    NSLog(@"%d", [blocks count]);
//                    NSLog(@"44444");
                }else{
                    CGPoint point2 = CGPointMake(i*self.tileSize, index*self.tileSize);
                    
                    Block *block = blockIndexes[i][j][@"block"];
                    
                    int curRow = [block.blockData[@"row"] integerValue];
                    
                    SKAction *action = [SKAction moveTo:point2 duration:self.fallSpeed * (curRow - index) + (index * 0.02)];
                    
                    
                    block.blockData[@"row"] = [NSNumber numberWithInt:index];
                    [block runAction:action];
                    [block.label setText:[NSString stringWithFormat:@"%d", index]];
                    index++;
                }
            }
            [blockIndexes[i] removeObjectsInArray:indexes];
            
            int rowAbove = 0;
            
            for(int j = [blockIndexes[i] count]; j < self.rowCount; j++){
                [self addBlockAtColumn:i andRow:rowAbove];
                rowAbove++;
            }
        }
        
//        blockIndexes rem
        
//        NSLog(@"1234");
        
//        [self createFireAtPoint:location];
//        PointUtils get
//        CGFloat distance = [PointUtils getDistanceFromPoint:[self.fire position] toPoint:location];
//        
//        NSTimeInterval time = (double)(distance / 100);
//
//        [self.fire removeAllActions];
//        SKAction *action = [SKAction moveTo:location duration:time];
//        [self.fire runAction:action];
//        
//        SKTexture *text = [self.fire texture];
////        NSLog(@"TEST");
//        CGRect r = [text textureRect];
//        CGFloat x = r.origin.x;
//        CGFloat y = r.origin.y;
//        CGFloat w = r.size.width;
//        CGFloat h = r.size.height;
        
        
        
        
//        text
//        self.fire
        
        
        
//        [self.fire setPosition:location];
        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self removeAllChildren];
//    int i = 0;
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        if(self.fires[i]){
//            [self.fires[i] setPosition:location];
//        }
//        
//        i++;
//        
////        [self createFireAtPoint:location];
//
//    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self removeAllChildren];
//    [self.fires removeAllObjects];
//    [self.fire setPosition:CGPointMake(-100, -100)];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
