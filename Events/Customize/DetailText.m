//
//  DetailText.m
//  Events
//
//  Created by Abraao Barros Lacerda on 22.09.15.
//  Copyright © 2015 Teknowledge Software. All rights reserved.
//

#import "DetailText.h"

@implementation DetailText

@dynamic text;
#pragma mark - Initialization

- (instancetype)init {
self = [super init];
if (self) {
    [self _customInit];
}
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _customInit];
    }
    return self;
}

- (void)_customInit {
    self.exclusiveTouch = YES;
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}

#pragma mark - Properties


@end
