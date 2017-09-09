//
//  MyLocationViewController.m
//  Artisan
//
//  Created by cguo on 2017/6/21.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "MyLocationViewController.h"
#import "Masonry.h"
#import "CityViewCell.h"

#import "LocationCityTool.h"
#import "CityCellHeaderView.h"
#import "HeaderModel.h"
#import "UIView+Extension.h"
#import "Header.h"
#import "MBProgressHUD+TVAssistant.h"

@interface MyLocationViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CityHeaderDelegate>
@property(nonatomic,strong)NSArray *indexArr;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *LoactHeaderView;

@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UILabel *cityLabel;
@property(nonatomic,strong)CLLocationManager *locationManager;//定位对象
@property(nonatomic,strong)NSArray *hotcityArr;
@property(nonatomic,strong)UIView *pictView;
@property(nonatomic,assign)CGFloat IndexViewClickY;//字母view的手势移动的垂直距离
@property(nonatomic,assign)NSInteger selectTag;
@property(nonatomic,strong)LocationCityTool *locationTool;
@property(nonatomic,strong)NSDictionary *CityArrDic;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)HeaderModel *headermodel;//用于保存显示或者隐藏cell
@property(nonatomic,strong)NSMutableArray *modelArr;
@end
static NSString *CellID=@"indexCellId";
@implementation MyLocationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=BgColor;
    
    self.navigationItem.title=@"我的位置";
    
    [self addLoactHeaderView];
    //
    [self SetTableView];
    
    
    [self addLetterIndexView];
    
    if (self.city==nil ||self.city.length==0) {
        //开始定位服务
        self.locationManager=[[CLLocationManager alloc]init];
        __block typeof(self)weakSelf=self;
        self.locationTool=[LocationCityTool LocationDelegateWithManager:self.locationManager LocationBlock:^(NSString *city,CLLocationCoordinate2D location) {
            
            weakSelf.cityLabel.text=city;
        }];
        self.locationManager.delegate=self.locationTool;
    }
    
    
    
}



-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    for (UIView *v in searchBar.subviews)
    {
        if ([v isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)v;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:0];
        }
    }
    
    
    return  YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",self.searchBar.text);
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}
#pragma mark--添加头部视图
-(void)addLoactHeaderView
{
    self.LoactHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 66, ScreenWidth, 85)];
    self.LoactHeaderView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.LoactHeaderView];
    __weak typeof(self)weakself=self;
    
    
    self.searchBar=[[UISearchBar alloc]init];
    self.searchBar.delegate=self;
    self.searchBar.placeholder=@"搜素城市";
    
    [self.view addSubview:self.searchBar];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.LoactHeaderView.mas_top).with.mas_offset(5);
        make.left.equalTo(weakself.LoactHeaderView.mas_left);
        make.right.equalTo(weakself.LoactHeaderView.mas_right);
        make.height.equalTo(@(35));
    }];
    
    UIView *searchBarBackView =[[UIView alloc]init];
    searchBarBackView.backgroundColor =[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.searchBar insertSubview:searchBarBackView atIndex:1];
    
    [searchBarBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.searchBar.mas_top);
        make.left.equalTo(weakself.searchBar.mas_left);
        make.right.equalTo(weakself.searchBar.mas_right);
        make.bottom.equalTo(weakself.searchBar.mas_bottom);
        
    }];
    
    
    
    UIView *linkView=[[UIView alloc]init];
    linkView.backgroundColor=LinkColor;
    [self.LoactHeaderView addSubview:linkView];
    [linkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.searchBar.mas_bottom).with.mas_offset(5);
        make.left.equalTo(weakself.LoactHeaderView.mas_left);
        make.size.mas_offset(CGSizeMake(ScreenWidth, 1));
    }];
    
    
    self.cityLabel=[[UILabel alloc]init];
    self.cityLabel.text=[NSString stringWithFormat:@"当前城市为:%@",self.city==nil ?@"":self.city];
    self.cityLabel.textColor=[UIColor blackColor];
    self.cityLabel.font=[UIFont systemFontOfSize:16];
    self.cityLabel.textAlignment=NSTextAlignmentLeft;
    
    [self.LoactHeaderView addSubview:self.cityLabel];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linkView.mas_bottom).with.mas_offset(2);
        make.left.equalTo(weakself.LoactHeaderView.mas_left).with.mas_offset(20);
        make.right.equalTo(weakself.LoactHeaderView.mas_right).with.mas_offset(20);
        make.bottom.equalTo(weakself.LoactHeaderView.mas_bottom).with.mas_offset(-2);
    }];
    
    
}





#pragma mark ---添加字母索引view
-(void)addLetterIndexView
{
    UIView *Indexview=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-20, self.tableView.y, 20, self.tableView.height)];
    
    
    Indexview.backgroundColor=[UIColor whiteColor];
    UIPanGestureRecognizer *swipegest=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(CityIndexClick:)];
    [Indexview addGestureRecognizer:swipegest];
    
    CGFloat  buttonViewHeight=Indexview.height-80*HeigheScale;
    for (int i=0; i<self.indexArr.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.frame=CGRectMake(0, buttonViewHeight/self.indexArr.count*i+40*HeigheScale, 20, buttonViewHeight/self.indexArr.count);
        btn.tag=i;
        [btn setTitleColor:MainColor forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:13];
        [btn setTitle:self.indexArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(IndexClick:) forControlEvents:UIControlEventTouchDown];
        [Indexview addSubview:btn];
    }
    [self.view addSubview:Indexview];
    
    
    
    
    
}
//拖动字母条滚动tableview
-(void)CityIndexClick:(UIPanGestureRecognizer*)panGest
{
    
    CGPoint point=[panGest locationInView:self.view];
    
    if (panGest.state==UIGestureRecognizerStateChanged)
    {
        NSLog(@"Frist point--%f--%f",point.x,point.y);
        //      self.IndexViewClickY=point.y;
        //
        /*
         num为选中的字母index
         self.tableView.y+80*HeigheScale为第一个字母的位置
         (self.tableView.height/self.indexArr.count)为单个字母的高度
         */
        
    }
    if (panGest.state==UIGestureRecognizerStateChanged)
    {
        
        NSLog(@"point--%f--%f",point.x,point.y);
        CGFloat heightY= self.selectTag*((self.tableView.height-80*HeigheScale)/self.indexArr.count)+(self.tableView.y+40*HeigheScale);
        
        /*
         num移动的index
         point.y-self.IndexViewClickY为移动的位置垂直距离
         self.tableView.height/self.indexArr.count为单个字母的高度
         */
        int num= (point.y-heightY)/((self.tableView.height-80*HeigheScale)/self.indexArr.count);
        
        
        
        
        if (self.selectTag+num>=self.indexArr.count || self.selectTag+num<0) {
            return;//避免数组越界
        }
        //self.selectTag+num
        HeaderModel *model=self.modelArr[self.selectTag+num];
        if (model.isOpend==NO) {
            model.opend=YES;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:self.selectTag+num];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.selectTag+num] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
       [MBProgressHUD showToastToView:self.view withText:self.indexArr[self.selectTag+num]];
        
    }
    
    if (panGest.state==UIGestureRecognizerStateChanged)
    {
        
    }
    
}

-(void)IndexClick:(UIButton*)btn
{
    //在windoe中间添加弹出视图显示
    self.selectTag=btn.tag;
    
    HeaderModel *model=self.modelArr[btn.tag];
    if (model.isOpend==NO) {
        model.opend=YES;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:btn.tag];
        
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:btn.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
   [MBProgressHUD showToastToView:self.view withText:self.indexArr[self.selectTag]];
}
#pragma mark ---添加TableView
-(void)SetTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.LoactHeaderView.height+64 , ScreenWidth-20, ScreenHeight-self.LoactHeaderView.height-64)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.backgroundColor=BgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.showsVerticalScrollIndicator=NO;
    
    [self.tableView registerClass:[CityViewCell class] forCellReuseIdentifier:CellID];
    
    
    [self.view addSubview:self.tableView];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0&&indexPath.section==0) {
        CityViewCell *cell=[[CityViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.backgroundColor=BgColor;
        cell.cityArr=self.hotcityArr;
        return cell;
    }else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        ;
        //        NSString *key=self.CityArrDic.allKeys[indexPath.section-1];
        NSString *key=self.indexArr[indexPath.section];
        NSArray *arr=self.CityArrDic[key];
        cell.textLabel.text=arr[indexPath.row];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"点击了");
    NSString *city=self.CityArrDic[self.indexArr[indexPath.section]][indexPath.row];
    [MBProgressHUD showToastToView:self.view  withText:city];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 &&indexPath.section==0) {
        return 160;
    }
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    
    
    //    NSString *key=self.CityArrDic.allKeys[section-1];
    NSString *key=self.indexArr[section];
    NSArray *rowArr=self.CityArrDic[key];
    
    HeaderModel *model=self.modelArr[section];
    return (model.isOpend ? rowArr.count : 0);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }
    return 25;
}

-(void)HeaderClick:(NSInteger)section
{
    //section的头部视图点击时显示或隐藏cell
    
    HeaderModel *model=self.modelArr[section];
    if (model.isOpend) {
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
        
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }else
    {
        
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
        
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CityCellHeaderView *headerView=[[CityCellHeaderView alloc]GetHeaderWithArr:self.indexArr Withsection:section];
    headerView.delegate=self;
    headerView.model=self.modelArr[section];
    return headerView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSArray *)indexArr
{
    if (_indexArr==nil) {
        _indexArr=@[@"#",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"N",@"M",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
        //        _indexArr=self.CityArrDic.allKeys;
    }
    return _indexArr;
}


-(NSDictionary*)CityArrDic
{
    if (_CityArrDic==nil) {
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
        
        _CityArrDic = [NSDictionary  dictionaryWithContentsOfFile:plistPath];
    }
    return _CityArrDic;
}

-(NSArray *)hotcityArr
{
    if (_hotcityArr==nil) {
        
        NSString *hotcitypath=[[NSBundle mainBundle]pathForResource:@"hotCities" ofType:@"plist"];
        
        _hotcityArr =[NSArray  arrayWithContentsOfFile:hotcitypath];
    }
    return _hotcityArr;
}
-(NSMutableArray *)modelArr
{
    
    if (_modelArr==nil) {
        _modelArr=[NSMutableArray array];
        for (int i=0; i<self.indexArr.count; i++) {
            HeaderModel *model=[[HeaderModel alloc]init];
            model.opend=YES;
            [_modelArr addObject:model];
        }
    }
    return _modelArr;
}

@end
