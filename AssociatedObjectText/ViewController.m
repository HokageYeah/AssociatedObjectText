//
//  ViewController.m
//  AssociatedObjectText
//
//  Created by 余晔 on 2017/4/1.
//  Copyright © 2017年 余晔. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "UIColor+Util.h"
#import "SecondViewController.h"
static const void *kUITableViewIndexKey = @"kUITableViewIndexKey";

#define kSystemVersion  [[UIDevice currentDevice] systemVersion]

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) UITableView *tableViews;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f9" alpha:1.0];
    [self.view addSubview:self.tableViews];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableViews]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableViews)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableViews]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableViews)]];
}



#pragma mark - UITabelViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hhaha"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hhaha"];
        cell.backgroundColor = [UIColor redColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
        lab.text = @"哈哈哈哈";
        [cell.contentView addSubview:lab];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"dasd");
    NSInteger shu = 0;
    
    if(shu==0)
    {
    
        if ([kSystemVersion floatValue] >= 8.0)
        {
            UIAlertController *alertcont = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancal = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消了");
            }];
            [alertcont addAction:cancal];
            UIAlertAction *commnt = [UIAlertAction actionWithTitle:@"15864587950" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了");
            }];
            [alertcont addAction:commnt];
            [self presentViewController:alertcont animated:YES completion:nil];
        }else{
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:nil
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:@"15815487859"
                                          otherButtonTitles:nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
            [actionSheet showInView:self.view];
            actionSheet = nil;
            
        }

    }
    else
    {
        UIAlertController *alertcont = [UIAlertController alertControllerWithTitle:@"提示" message:@"所有的提示信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancal = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertcont addAction:cancal];
        UIAlertAction *queding = [UIAlertAction actionWithTitle:@"我来点击领" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSIndexPath *indexpaths = objc_getAssociatedObject(alertcont, kUITableViewIndexKey);
            NSLog(@"获取数值:%ld",(long)indexpaths.row);
            SecondViewController *second = [[SecondViewController alloc] init];
            [self.navigationController pushViewController:second animated:YES];
        }];
        [alertcont addAction:queding];
        [self presentViewController:alertcont animated:YES completion:^{
            NSLog(@"执行完毕");

         }];
        //设定关联，把indexpath关联到alert上面
        objc_setAssociatedObject(alertcont, kUITableViewIndexKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - 拨打和取消
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            // 取消
            NSLog(@"<8.0取消了");
            return;
            
        case 0:{
            // 电话
            NSLog(@"<8.0点击领");
            
        }
            break;
            
    }
}




//懒加载
- (UITableView *)tableViews{
    if(_tableViews==nil){
        _tableViews = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableViews.dataSource = self;
        _tableViews.delegate = self;
        _tableViews.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViews.translatesAutoresizingMaskIntoConstraints = NO;
        _tableViews.showsVerticalScrollIndicator = NO;
        _tableViews.backgroundColor = [UIColor clearColor];
    }
    return _tableViews;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
