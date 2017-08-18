//
//  SecondViewController.m
//  AssociatedObjectText
//
//  Created by 余晔 on 2017/4/1.
//  Copyright © 2017年 余晔. All rights reserved.
//

#import "SecondViewController.h"
#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SecondViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIView *firstview;
@property (nonatomic,strong) UIWebView *secondview;
@property (nonatomic,strong) UIScrollView *allscrollview;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.allscrollview];
    [self.allscrollview addSubview:self.firstview];
    [self.allscrollview addSubview:self.secondview];
    
    NSString *url = @"http://m.youjuke.com/redemption/index?platform=app&userId=51731";
    [_secondview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

}

- (UIView *)firstview{
    if(_firstview == nil)
    {
        _firstview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 300)];
        _firstview.backgroundColor = [UIColor redColor];
    }
    return _firstview;
}


- (UIScrollView *)allscrollview
{
    if(_allscrollview == nil)
    {
        _allscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
        _allscrollview.backgroundColor = [UIColor grayColor];
    }
    return _allscrollview;
}

- (UIWebView *)secondview
{
    if(_secondview == nil)
    {
        _secondview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 310, MAIN_SCREEN_WIDTH, 300)];
        _secondview.delegate = self;
        _secondview.scrollView.bounces = NO;
    }
    return _secondview;
}


/** 判断webView是否完全加载完数据 */
- (BOOL)isFinishLoading{ //http://www.cocoachina.com/ios/20170314/18881.html
    NSString *readyState = [self.secondview stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL complete = [readyState isEqualToString:@"interactive"];
    if (complete && !self.secondview.isLoading) {
        return YES;
    }else{
        return NO;
    }
}


#pragma mark --UIWebViewDelegate

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    
//    return YES;
//}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    if([self isFinishLoading]){

        CGRect frame = self.secondview.frame;
        frame.size.height = self.secondview.scrollView.contentSize.height;
        
        self.secondview.frame = frame;
        self.allscrollview.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH, self.secondview.frame.origin.y+self.secondview.frame.size.height);
    
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    NSLog(@"%@",error);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
