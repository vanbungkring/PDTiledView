//
//  PDViewController.m
//  PDTiledView
//
//  Created by Parker Wightman on 12/12/12.
//  Copyright (c) 2012 Parker Wightman Inc. All rights reserved.
//

#import "PDViewController.h"
#import "PDTiledView.h"
#import <QuartzCore/QuartzCore.h>

@interface PDViewController ()
@property (strong, nonatomic) IBOutlet PDTiledView *tiledView;

@end

@implementation PDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Required
	
	_tiledView.numberOfSectionsBlock = ^NSInteger{ return 4; };
	
	_tiledView.numberOfTilesInSectionBlock = ^NSInteger (NSInteger section) { return 20; };
	
	_tiledView.controlForSectionBlock = ^UIControl *(NSInteger section) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.backgroundColor = [UIColor whiteColor];
		button.layer.borderColor = [[UIColor blackColor] CGColor];
		button.layer.borderWidth = 1;
		return button;
	};
	
	_tiledView.willDisplaySectionBlock = ^(UIControl *sectionControl, NSInteger section) {
		UILabel *label = [[UILabel alloc] initWithFrame:sectionControl.bounds];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		label.text = [NSString stringWithFormat:@"%@", @(section)];
		[sectionControl addSubview:label];
		
	};
	
	_tiledView.controlForIndexPathBlock = ^UIControl *(PDIndexPath indexPath) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.backgroundColor = [self randomColor];
		button.layer.borderColor = [[UIColor blackColor] CGColor];
		button.layer.borderWidth = 1;
		button.titleLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.tile)];
		return button;
	};
	
	_tiledView.willDisplayTileAtIndexPathBlock = ^(UIControl *tile, PDIndexPath indexPath) {
		UILabel *label = [[UILabel alloc] initWithFrame:tile.bounds];
		label.backgroundColor = [UIColor clearColor];
		label.text = [NSString stringWithFormat:@"%@", @(indexPath.tile)];
		label.textAlignment = NSTextAlignmentCenter;
		[tile addSubview:label];
	};
	
	// Optional
	
	_tiledView.heightForSectionControlBlock = ^CGFloat { return 50; };
	
	_tiledView.heightForTilesInSectionBlock = ^CGFloat(NSInteger section) { return 60; };
	
	_tiledView.didSelectSectionBlock = ^(UIControl *sectionControl, NSInteger section) {
		NSLog(@"Section selected %d", section);
	};
	
	_tiledView.didSelectTileAtIndexPathBlock = ^(UIControl *tile, PDIndexPath indexPath) {
		NSLog(@"IndexPath selected: %d, %d", indexPath.section, indexPath.tile);
	};
	
	[_tiledView reloadData];
	[_tiledView selectSection:0 animated:NO];
}

- (UIColor *)randomColor {
	
	return [UIColor colorWithRed:(arc4random() % ((unsigned)RAND_MAX + 1)) / (CGFloat)RAND_MAX
						   green:(arc4random() % ((unsigned)RAND_MAX + 1)) / (CGFloat)RAND_MAX
							blue:(arc4random() % ((unsigned)RAND_MAX + 1)) / (CGFloat)RAND_MAX
						   alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end