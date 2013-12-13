//
//  HelloWorldLayer.m
//  Mia
//
//  Created by Alioune Badara Ndoye on 14/07/13.
//  Copyright Xtreme Design and Engineering 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    
    // always call “super” init
    
    // Apple recommends to re-assign “self” with the “super” return value
    
    if( (self=[super init] )) {
        
        //add the frames and coordinates to the cache
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"mamanmia.plist"];
        
        //load the sprite sheet into a CCSpriteBatchNode object. If you’re adding a new sprite
        
        //to your scene, and the image exists in this sprite sheet you should add the sprite
        
        //as a child of the same CCSpriteBatchNode object otherwise you could get an error.
        
        CCSpriteBatchNode *parrotSheet = [CCSpriteBatchNode batchNodeWithFile:@"mamanmia.png"];
        
        
        
        //add the CCSpriteBatchNode to your scene
        
        [self addChild:parrotSheet];
        
        //load each frame included in the sprite sheet into an array for use with the CCAnimation object below
        
        NSMutableArray *flyAnimFrames = [NSMutableArray array];
        
        for(int i = 1; i <= 2; ++i) {
            
            [flyAnimFrames addObject:
             
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              
              [NSString stringWithFormat:@"mamanmia%d.png", i]]];
            
        }
        
        //Create the animation from the frame flyAnimFrames array
        
        CCAnimation *flyAnim = [CCAnimation animationWithFrames:flyAnimFrames delay:0.1f];
        
        //create a sprite and set it to be the first image in the sprite sheet
        
        CCSprite *theParrot = [CCSprite spriteWithSpriteFrameName:@"mamanmia.png"];
        
        //set its position to be dead center, i.e. screen width and height divided by 2
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        theParrot.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        //create a looping action using the animation created above. This just continuosly
        
        //loops through each frame in the CCAnimation object
        
        CCAction *flyAction = [CCRepeatForever actionWithAction:
                               
                               [CCAnimate actionWithAnimation:flyAnim restoreOriginalFrame:NO]];
        
        //start the action
        
        [theParrot runAction:flyAction];
        
        //add the sprite to the CCSpriteBatchNode object
        
        [parrotSheet addChild:theParrot];
        
    }
    
    return self;
    
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
