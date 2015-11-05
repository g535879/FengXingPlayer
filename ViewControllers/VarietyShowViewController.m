//
//  VarietyShowViewController.m
//  FengXingPlayer
//
//  Created by 古玉彬 on 15/11/5.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "VarietyShowViewController.h"
#import "CustomViewCell.h"
#import "VarietyShowModel.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

#define VIEW_SPACE 10
#define VIEW_WIDTH (MAX_WIDTH -  VIEW_SPACE ) / 2
#define VIEW_HEIGHT  VIEW_WIDTH
@interface VarietyShowViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_picCollectionView; //滚动视图
    NSMutableArray *_searchdataArray; //最近检索数据
    NSMutableArray *_welcomeDataArray; //最受欢迎数据
    NSString  *_currentPage; //当前第几页
    BOOL _isClick; //是否点击最近检索按钮
}

@end

@implementation VarietyShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNavigation];
    [self setData]; //设置数据
    [self connectRequestWithCurrentPage:_currentPage]; //按页面获取数据
    [self createHeaderButton]; //顶部button
    [self createCollectionView]; //创建collectionView
}

- (void)settingNavigation {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //自定制titleView
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"综艺" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn addTarget:self
                 action:@selector(titleBtnClick)
       forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

#pragma mark - titleBtnClick 
- (void)titleBtnClick {
    
}
- (void)setData {
    _currentPage = @"1";
    if (!_searchdataArray) {
        _searchdataArray = [@[] mutableCopy];
    }
    if (!_welcomeDataArray) {
        _welcomeDataArray = [@[] mutableCopy];
    }
}
//顶部最受欢迎和最近检索按钮
- (void)createHeaderButton {
    NSArray * imageArray = @[@"channelList_topLeftbutton",@"channelList_topRightbutton"];
    
    NSArray * titleArray = @[@"最近检索",@"最受欢迎"];
    
    [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.tag = 10+idx;
        [btn setTitle:titleArray[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(MAX_WIDTH/2*idx, 0, MAX_WIDTH/2, 40);
        [btn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        //设置文字和图片的位置
        if (!idx) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        }else{
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -60, 0, 0);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0);

        }
        
    }];
}

#pragma mark - title btn click 
- (void)headBtnClick:(UIButton *)btn {
    if (btn.tag-10) {  //最受欢迎
        _currentPage = @"1";
        _isClick = NO;
        //清空以前数据
        [_welcomeDataArray removeAllObjects];

    }else{
        _currentPage = @"2";
        _isClick = YES;
        [_searchdataArray removeAllObjects];
    }
    //获取数据
    [self connectRequestWithCurrentPage:_currentPage];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 10;
    
    _picCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40+VIEW_SPACE, MAX_WIDTH, MAX_HEIGHT-114) collectionViewLayout:flowLayout];
    [_picCollectionView setBackgroundColor:[UIColor whiteColor]];
    _picCollectionView.delegate = self;
    _picCollectionView.dataSource = self;
    
    //注册cell
    [_picCollectionView registerNib:[UINib nibWithNibName:@"CustomViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.view addSubview:_picCollectionView];
}


#pragma mark - collceiton delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_isClick) {
        return _searchdataArray.count;
    }
    else{
        return _welcomeDataArray.count;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"cellIdentifier";
    CustomViewCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    VarietyShowModel * model;
    if (_isClick) {
        model = _searchdataArray[indexPath.row];
    }
    else {
        model = _welcomeDataArray[indexPath.row];
    }
    [cell.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    cell.videoGrade.text = model.tinf;
    cell.videoTimer.text = model.vinf;
    cell.videoTitle.text = model.name;
    return cell;
}


#pragma mark - connectWeb
- (void)connectRequestWithCurrentPage:(NSString *)currentPage {
    if (!currentPage) {
        currentPage = @"1";
    }
    NSString *urlStr = [NSString stringWithFormat:@"http://jsonfe.funshion.com/?pagesize=10&cli=iphone&page=%@&src=phonemedia&ta=0&ver=1.2.8.2&jk=0",currentPage];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //建模
        
        for (NSDictionary * dic in obj[@"data"][@"list"]) {
            VarietyShowModel * model = [[VarietyShowModel alloc] initWithDictionary:dic
                                                                              error:nil];
            if (!_isClick) {
                [_welcomeDataArray addObject:model];
            }else{
                [_searchdataArray addObject:model];
            }
            
        }
        
        [_picCollectionView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
