//
//  ViewController.m
//  滑动
//
//  Created by cxy on 17/3/6.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import "ViewController.h"
#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenheight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *cxyTable;
@property(nonatomic,assign)int cxyTag;
@property(nonatomic,assign)BOOL isStart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _cxyTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kscreenWidth, kscreenheight-64) style:UITableViewStylePlain];
    _cxyTable.dataSource=self;
    _cxyTable.delegate=self;
    [self.view addSubview:_cxyTable];
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"cxyCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cxyCell"];
    }
    if (indexPath.row%2) {
        cell.backgroundColor=[UIColor whiteColor];

    }else{
        
        cell.backgroundColor=[UIColor colorWithRed:arc4random()%225/225.0 green:arc4random()%225/255.0 blue:arc4random()%225/255.0 alpha:1];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        cell.tag=100+indexPath.row;
        [cell addGestureRecognizer:tap];
    }
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (!_isStart) {
        if (indexPath.row%2) {
            return 10;
        }else{
            return 150;
        }
//    }else{
//      
//        
   // }
    
}
-(void)click:(UIGestureRecognizer*)tap{
    UIView *view=tap.view;
    _cxyTag=(int)view.tag;
    _isStart=YES;
    NSLog(@"%ld",(long)view.tag);
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat height = _cxyTable.frame.size.height;
    CGFloat distanceFromButton =  _cxyTable.contentOffset.y;
    NSLog(@"....%.2f",distanceFromButton);
//    if (distanceFromButton == height)
//    {
//        NSLog(@"=====滑动到底了");
//    }
//    
//    if (_varietyTableView.contentOffset.y == 0)
//    {
//        NSLog(@"=====滑动到顶了");
//    }
    
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"%f",velocity.x);
    NSLog(@"当滚动视图将要结束滑动,第二个参数是加速度,第三个参数是预测停留的点");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //我手指松开的时间点
    NSLog(@"手指已经结束滑动,将要开始减速,参数是是否进行减速");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"将要开始减速");
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSLog(@"结束减速");
//    //当结束减速,会到原点,带动画
//    [scrollView setContentOffset:CGPointZero animated:YES];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
