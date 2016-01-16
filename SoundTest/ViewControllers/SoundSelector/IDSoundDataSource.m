//
// Created by Ignacio Delgado on 16/01/2016.
// Copyright (c) 2016 Ignacio Delgado. All rights reserved.
//

#import "IDSoundDataSource.h"
#import "OALSimpleAudio.h"

@implementation IDSoundDataSource

static NSDictionary *sounds = nil;
+ (void)initialize {
    NSMutableDictionary *tmpSounds = [@{} mutableCopy];

    NSError *error = nil;
    NSArray *fileSounds = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Sounds"] error:&error];
    if (nil == error){
       for (int i = 0; i < fileSounds.count; i++){
           tmpSounds[@(i)] = [fileSounds[i] copy];
       }
    }
    
    sounds = [tmpSounds copy];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureAudio];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }

    return self;
}

- (void)playSoundAtIndexPath:(NSIndexPath *)indexPath {
    [[OALSimpleAudio sharedInstance] playEffect:[NSString stringWithFormat:@"Sounds/%@", sounds[@(indexPath.row)]]];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sounds.count;
}

static NSString *const kSoundCellIdentifier = @"soundCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSoundCellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSoundCellIdentifier];
    }
    cell.textLabel.text = sounds[@(indexPath.row)];
    return cell;
}

#pragma mark - Private methods

- (void)configureAudio {
    [OALSimpleAudio sharedInstance].allowIpod = NO;
    [OALSimpleAudio sharedInstance].honorSilentSwitch = YES;

    for (NSNumber *key in sounds.allKeys){
        [[OALSimpleAudio sharedInstance] preloadEffect:[NSString stringWithFormat:@"Sounds/%@", sounds[key]]];
    }
}

#pragma mark - Application notifications

- (void)applicationDidEnterBackground {
    [[OALSimpleAudio sharedInstance] setPaused:YES];
}

- (void)applicationDidBecomeActive {
    [[OALSimpleAudio sharedInstance] setPaused:NO];
}

@end