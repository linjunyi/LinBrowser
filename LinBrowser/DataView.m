//
//  DataView.m
//  LinBrowser
//
//  Created by lin on 15-3-27.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DataView.h"

@implementation DataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.openSwitch];
        [self addSubview:self.loadView];
        [self addSubview:self.superLoadView];
        [self addSubview:self.blackBg];
        [self addSubview:self.message];
        [self addSubview:self.coolShow];
    }
    return self;
}

- (void)clickSwitch {
    [self.openSwitch switchClick];
    if([self.openSwitch isOn]){
        self.messageText.text = @"启动页面加速";
    }else{
        self.messageText.text = @"关闭页面加速";
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(bgDisapper) userInfo:nil repeats:NO];
    self.message.hidden = NO;
    self.blackBg.hidden = NO;
}

- (void)bgDisapper {
    self.message.hidden = YES;
    self.blackBg.hidden = YES;
}

- (UILabel *)copyLabel:(UILabel *)originLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:originLabel.frame];
    label.font     = originLabel.font;
    label.text     = originLabel.text;
    return  label;
}


#pragma mark --UICollectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UIBaseCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[self.coolImages objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark --property

- (UIBaseSwitch *)openSwitch {
    if(!_openSwitch){
        _openSwitch = [[UIBaseSwitch alloc] initWithFrame:CGRectMake(50, 100, 50, 40)];
        [_openSwitch.switchButton addTarget:self action:@selector(clickSwitch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openSwitch;
}

- (UIImageView *)message {
    if(!_message){
        _message = [[UIImageView alloc] initWithFrame:CGRectMake(self.boundsWidth/2-120, self.boundsHeight/2-30, 240, 60)];
        _message.image = [UIImage imageNamed:@"messageBg.png"];
        _message.alpha = 1.0f;
        [_message addSubview:self.messageText];
        _message.hidden = YES;
    }
    return _message;
}

- (UILabel *)messageText {
    if(!_messageText){
        _messageText = [[UILabel alloc] initWithFrame:CGRectMake(self.message.boundsWidth/2-90, 0, 180, 50)];
        _messageText.text = @"启动页面加速";
        _messageText.textAlignment = NSTextAlignmentCenter;
        _messageText.font = [UIFont systemFontOfSize:15.0f];
    }
    return _messageText;
}

- (UIView *)blackBg {
    if(!_blackBg){
        CGRect frame = [UIScreen mainScreen].bounds;
        _blackBg = [[UIView alloc] initWithFrame:frame];
        _blackBg.backgroundColor = [UIColor blackColor];
        _blackBg.alpha = 0.3f;
        _blackBg.hidden = YES;
    }
    return _blackBg;
}

- (UICollectionView *)coolShow {
    if(!_coolShow){
        UICollectionViewFlowLayout *layout =  [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.boundsWidth/2-25, 120);
        layout.minimumLineSpacing      = 20; //同一section中，同行cell间距
        layout.minimumInteritemSpacing = 20; //同一section中，同列cell间距
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 0, 0);  //不同section
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _coolShow = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.boundsHeight-180, self.boundsWidth, 150) collectionViewLayout:layout];
        _coolShow.delegate = self;
        _coolShow.dataSource = self;
        _coolShow.backgroundColor = RGBA(165, 155, 114, 0.2);
        [_coolShow registerClass:[UIBaseCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    }
    return _coolShow;
}

- (NSMutableArray *)coolImages{
    if(!_coolImages){
        _coolImages = [NSMutableArray arrayWithObjects:@"小鸟游_2.jpeg", @"麦高.jpg", @"骷髅.jpg", @"黑猫.jpg", @"小鸟游_1.gif", @"气球.jpg", @"小孩.jpg", @"com.jpg", @"isDan.jpg", @"shu.jpg", nil];
    }
    return _coolImages;
}

- (UIView *)loadView {
    if(!_loadView){
        _loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, self.boundsWidth, 80)];
        [_loadView addSubview:self.loadViewLabel];
        [_loadView addSubview:self.loadCount];
        [_loadView addSubview:self.loadCountData];
        [_loadView addSubview:self.averageLoadTime];
        [_loadView addSubview:self.averageLoadTimeData];
    }
    return _loadView;
}

- (UILabel *)loadViewLabel {
    if(!_loadViewLabel){
        _loadViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 50, 20)];
        _loadViewLabel.text = @"未加速";
        _loadViewLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _loadViewLabel;
}

- (UILabel *)loadCount {
    if(!_loadCount){
        _loadCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, 80, 20)];
        _loadCount.text = @"页面加载次数";
        _loadCount.font = [UIFont systemFontOfSize:11.0f];
    }
    return _loadCount;
}

- (UILabel *)loadCountData {
    if(!_loadCountData){
        _loadCountData = [[UILabel alloc] initWithFrame:CGRectMake(93, 28, 80, 20)];
        _loadCountData.text = @"1";
        _loadCountData.font = [UIFont systemFontOfSize:11.0f];
    }
    return _loadCountData;
}

- (UILabel *)averageLoadTime {
    if(!_averageLoadTime){
        _averageLoadTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 80, 20)];
        _averageLoadTime.text = @"平均加载时间";
        _averageLoadTime.font = [UIFont systemFontOfSize:11.0f];
    }
    return _averageLoadTime;
}

- (UILabel *)averageLoadTimeData {
    if(!_averageLoadTimeData){
        _averageLoadTimeData = [[UILabel alloc] initWithFrame:CGRectMake(93, 50, 80, 20)];
        _averageLoadTimeData.text = @"0.01秒";
        _averageLoadTimeData.font = [UIFont systemFontOfSize:11.0f];
    }
    return _averageLoadTimeData;
}

- (UIView *)superLoadView {
    if(!_superLoadView){
        _superLoadView = [[UIView alloc] initWithFrame:CGRectMake(0, 233, self.boundsWidth, 80)];
        [_superLoadView addSubview:self.superLoadViewLabel];
        [_superLoadView addSubview:self.superLoadCount];
        [_superLoadView addSubview:self.superLoadCountData];
        [_superLoadView addSubview:self.superAverLoadTime];
        [_superLoadView addSubview:self.superAverLoadTimeData];
    }
    return _superLoadView;
}

- (UILabel *)superLoadViewLabel {
    if(!_superLoadViewLabel){
        _superLoadViewLabel = [self copyLabel:self.loadViewLabel];
        _superLoadViewLabel.text = @"加速后";
    }
    return _superLoadViewLabel;
}

- (UILabel *)superLoadCount {
    if(!_superLoadCount){
        _superLoadCount = [self copyLabel:self.loadCount];
    }
    return _superLoadCount;
}

- (UILabel *)superLoadCountData {
    if(!_superLoadCountData){
        _superLoadCountData = [self copyLabel:self.loadCountData];
    }
    return _superLoadCountData;
}

- (UILabel *)superAverLoadTime {
    if(!_superAverLoadTime){
        _superAverLoadTime  = [self copyLabel:self.averageLoadTime];
    }
    return _superAverLoadTime;
}

- (UILabel *)superAverLoadTimeData {
    if(!_superAverLoadTimeData){
        _superAverLoadTimeData = [self copyLabel:self.averageLoadTimeData];
    }
    return _superAverLoadTimeData;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
