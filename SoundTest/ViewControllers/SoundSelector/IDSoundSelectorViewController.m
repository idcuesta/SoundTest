//
// Created by Ignacio Delgado on 16/01/2016.
// Copyright (c) 2016 Ignacio Delgado. All rights reserved.
//

#import "IDSoundSelectorViewController.h"
#import "IDSoundDataSource.h"


@interface IDSoundSelectorViewController ()
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) IDSoundDataSource *dataSource;
@end

@implementation IDSoundSelectorViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Select sound", nil);
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - Private methods

- (void)createTableView {
    self.tableView = [UITableView new];
    self.dataSource = [IDSoundDataSource new];
    _tableView.dataSource = _dataSource;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_dataSource playSoundAtIndexPath:indexPath];
}


@end