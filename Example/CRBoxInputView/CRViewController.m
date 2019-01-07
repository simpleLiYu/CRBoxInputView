//
//  CRViewController.m
//  CRBoxInputView
//
//  Created by BearRan on 01/03/2019.
//  Copyright (c) 2019 BearRan. All rights reserved.
//

#import "CRViewController.h"
#import "CRDetailViewController.h"

#import "CRBoxInputView.h"
#import "CRBoxInputView_CustomSecurity.h"
#import "CRBoxInputModel.h"

@interface CRViewController () <UITableViewDelegate, UITableViewDataSource>
{
    CRBoxInputView *_boxInputView;
    UITableView *_mainTableView;
    NSMutableArray *_dataArr;
}
@end

@implementation CRViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self generateDataArr];
    [self createUI];
}

- (void)generateDataArr
{
    _dataArr = [NSMutableArray new];
    CRBoxInputModel *model;
    
    model = [CRBoxInputModel new];
    model.name = @"Normal";
    model.imageName = @"";
    model.type = CRBoxInputModelNormalType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Line";
    model.imageName = @"";
    model.type = CRBoxInputModelLineType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Secret Symbol";
    model.imageName = @"";
    model.type = CRBoxInputModelSecretSymbolType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Secret Image";
    model.imageName = @"";
    model.type = CRBoxInputModelSecretImageType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Secret View";
    model.imageName = @"";
    model.type = CRBoxInputModelSecretViewType;
    [_dataArr addObject:model];
}

- (void)createUI
{
    _mainTableView = [UITableView new];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 157;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputModel *model = _dataArr[indexPath.row];
    CRDetailViewController *destinationVC = [CRDetailViewController new];
    [self.navigationController pushViewController:destinationVC animated:YES];
}

- (void)createUI1
{
    CGFloat offX = 30;
    
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellBgColor = [UIColor clearColor];
    cellProperty.cellBorderColorSelected = CRBOX_UIColorFromHEX(0x979797);
    cellProperty.cellCursorColor = CRBOX_UIColorFromHEX(0x979797);
    cellProperty.cornerRadius = 7;
    cellProperty.securityType = CRBoxSecurityType_CustomView;
    
    _boxInputView = [CRBoxInputView_CustomSecurity new];
    [self.view addSubview:_boxInputView];
    _boxInputView.codeLength = 6;
    _boxInputView.ifNeedCursor = YES;
    _boxInputView.keyBoardType = UIKeyboardTypeNumberPad;
    _boxInputView.ifNeedSecurity = YES;
    _boxInputView.customCellProperty = cellProperty;
    _boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        if (isFinished) {
            NSLog(@"--text:%@", text);
        }
    };
    [_boxInputView loadAndPrepareView];
    [_boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        make.centerY.offset(0);
        make.height.mas_equalTo(47);
    }];
    
    UIButton *clearBtn = [UIButton new];
    [clearBtn addTarget:self action:@selector(clearBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.width.height.mas_equalTo(100);
        make.centerX.offset(0);
    }];
}

- (void)clearBtnEvent
{
    [_boxInputView clearAll];
}

@end
