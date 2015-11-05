//
//  HomePageViewController.m
//  FengXingPlayer
//
//  Created by 古玉彬 on 15/11/4.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "HomePageViewController.h"
#import "DesignPicScrollView.h"
#import "ScroModel.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface HomePageViewController (){
    DesignPicScrollView *_scrollView; //滚动视图
    NSMutableArray *_scroModelsArray; //滚动视图数据模型
    UITextField *_searchField; //搜索框
    UIToolbar *_bottomBar; //底部栏
}

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData]; //初始化数据
    [self setLayout]; //设置布局
}


- (void)setData {
    if (!_scroModelsArray) {
        _scroModelsArray = [@[] mutableCopy];
    }
    for (int i = 0 ; i < 5; i++) {
        ScroModel * model = [[ScroModel alloc] init];
        model.imageName = [NSString stringWithFormat:@"img_0%d.png",i];
        [_scroModelsArray addObject:model];
    }
    
}

//布局
- (void)setLayout {
    _scrollView = [[DesignPicScrollView alloc] initWithFrame:CGRectMake(0, 20, MAX_WIDTH, MAX_HEIGHT / 3)];
    _scrollView.imageModelArray = _scroModelsArray; //设置数据
    _scrollView.AutoRun = YES;//自动滚动
    [self.view addSubview:_scrollView];
    
    
    //search Field
    UIImageView *bgSearchView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_scrollView.frame)+10, MAX_WIDTH-20, 40)];
    [bgSearchView setImage:[UIImage imageNamed:@"search_bar_bg"]];
    [bgSearchView setUserInteractionEnabled:YES];
    
    //放大镜
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    searchImageView.image = [UIImage imageNamed:@"searchicon.png"];
    [bgSearchView addSubview:searchImageView];
    
    //搜索文本框
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(35, 5, MAX_WIDTH-50, 35)];
    _searchField.placeholder = @"请输入片名、主演或导演";
    [bgSearchView addSubview:_searchField];
    [self.view addSubview:bgSearchView];
    
    
    //底部栏
    _bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, MAX_HEIGHT-49, MAX_WIDTH, 49)];
    //下载按钮
    UIBarButtonItem *downloadBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"homePage_bottomButton_downLoad"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *flaxableBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //history
    UIBarButtonItem *historyBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"homePage_bottomButton_history"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    //settting
        UIBarButtonItem *settingBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"homePage_bottomButton_setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    _bottomBar.items = @[flaxableBtn,downloadBtn,flaxableBtn,historyBtn,flaxableBtn,settingBtn,flaxableBtn];
    [self.view addSubview:_bottomBar];

//    UITabBar *t = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    UITabBarItem *ite = [[UITabBarItem alloc] init];
//    ite.badgeValue = @"he";
//    t.items = @[ite];
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 60, 60)];
//    [bg addSubview:t];
    [self.view addSubview:bg];
}


#pragma mark - 屏幕点击事件
//回收键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
