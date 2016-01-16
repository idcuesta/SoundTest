//
// Created by Ignacio Delgado on 16/01/2016.
// Copyright (c) 2016 Ignacio Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDSoundDataSource : NSObject <UITableViewDataSource>
- (void)playSoundAtIndexPath:(NSIndexPath *)indexPath;
@end