//
//  ComposeViewController.m
//  微博
//
//  Created by llairen on 15/11/25.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "ComposeViewController.h"
#import "WBAccountTool.h"
#import "ComposTextView.h"
#import "ComposeToolBar.h"
#import "AFNetworking.h"
#import "ComposScrollPhotosView.h"
#import "ComposeKeyboardView.h"
#import "EmojiModel.h"
#import "EmojiTextView.h"
#import "HttpTool.h"

@interface ComposeViewController ()<UITextViewDelegate ,ComposeToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic ,weak)EmojiTextView * composeView;
@property (nonatomic, weak)ComposeToolBar *toolBar;

/**键盘*/
@property (nonatomic, strong) ComposeKeyboardView*composeKeyBoard;
/** 图片相册*/
@property (nonatomic, weak)ComposScrollPhotosView *scrollPhotosView;
@end

@implementation ComposeViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.composeView becomeFirstResponder];
}
#pragma mark -懒加载
-(ComposeKeyboardView *)composeKeyBoard
{
    if (_composeKeyBoard==nil)
    {
        self.composeKeyBoard=[[ComposeKeyboardView alloc]init];
        self.composeKeyBoard.width=self.view.width;
        self.composeKeyBoard.height=216;
    }
    return _composeKeyBoard;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //导航按钮
    [self setNavButton];
    //添加textView
    [self setTextView];
    
    //添加 toolBar
    [self setToolBar];
    
    //添加发送图片的相岫
    [self composePhotos];
}

#pragma mark --初始化界面
/** 添加发微博相册*/
-(void)composePhotos
{
    ComposScrollPhotosView * scrollPhotosView=[[ComposScrollPhotosView alloc]init];
    scrollPhotosView.x=0;
    scrollPhotosView.y=100;
    scrollPhotosView.height=80;
    scrollPhotosView.width=self.view.width;
    [self.composeView addSubview:scrollPhotosView];
    self.scrollPhotosView=scrollPhotosView;

}

//添加 toolBar
-(void)setToolBar
{
    ComposeToolBar * toolBar=[[ComposeToolBar alloc]init];
    toolBar.height=44;
    toolBar.delegate=self;
    toolBar.width=self.composeView.size.width;
    toolBar.x=0;
    toolBar.y=self.view.height-toolBar.height;
    [self.view addSubview:toolBar];
    self.toolBar=toolBar;
}

/**添加textView*/
-(void)setTextView
{
    EmojiTextView * compostTextView=[[EmojiTextView alloc]init];
    [self.view addSubview:compostTextView];
    compostTextView.alwaysBounceVertical=YES;
    compostTextView.delegate=self;
    compostTextView.frame=self.view.bounds;
    compostTextView.placehoderStr=@"分享新鲜事...";
    compostTextView.font=[UIFont systemFontOfSize:17];
    compostTextView.phaceColor=[UIColor grayColor];
    self.composeView=compostTextView;

    //输入框发生变化的时候
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textWillChange) name:UITextViewTextDidChangeNotification object:nil];
    
    //键盘发生变化的时候
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //输入表情发生的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectBtnEmotion:) name:EmotionDidSelectNotification object:nil];
    
    //删除表情按钮
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteClick) name:EmotionDeletedBtnClick object:nil];
}
//导航按钮
-(void)setNavButton
{
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(canleTap)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendTap)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
//    NSLog(@"%@",self.navigationItem.rightBarButtonItem);
    NSString * prefix=@"发微博";
    //取出用户昵称
    NSString *name=[WBAccountTool account].name;
    //导航中间的内容
    if (name)
    {
        NSString * Str=[NSString stringWithFormat:@"%@\n%@",prefix,name];
        
        NSMutableAttributedString *attr=[[NSMutableAttributedString alloc]initWithString:Str];
        
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[Str rangeOfString:prefix]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[Str rangeOfString:name]];
        //创建一个label
        
        UILabel *navLabel=[[UILabel alloc]init];
        navLabel.textAlignment=NSTextAlignmentCenter;
        //        navLabel.backgroundColor=[UIColor blueColor];
        navLabel.numberOfLines=0;
        navLabel.width=200;
        navLabel.height=40;
        navLabel.y=10;
        navLabel.attributedText=attr;
        self.navigationItem.titleView=navLabel;
    }
    else
    {
        self.navigationItem.title=prefix;
    }
    
}

#pragma mark --通知


-(void)deleteClick
{
    [self.composeView deleteBackward];
}
/**表情按钮发出的通知*/
-(void)didSelectBtnEmotion:(NSNotification *)notification
{
    EmojiModel * emojiModel=notification.userInfo[EmojiModelUerInfoKey];
    [self.composeView insertEmojiModel:emojiModel];
}
//textView发生变化时， 导航发送按钮发生改变
-(void)textWillChange
{
    self.navigationItem.rightBarButtonItem.enabled=self.composeView.hasText;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark --代理方法
/**
 composeToolBar 的代理方法
 */
-(void)composeToolBar:(ComposeToolBar *)toolBar didClickBtn:(ComposeToolBarButtonType)buttonType
{
    switch (buttonType) {
        case ComposeToolBarButtonCamera:
            [self openImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
            break;
        case ComposeToolBarButtonPicture:
            [self openImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case ComposeToolBarButtonMention:
            NSLog(@"这个是@");
            break;
        case ComposeToolBarButtonTrend:
            NSLog(@"这个是# ");
            break;
        case ComposeToolBarButtonEmotion:
            [self showKeyboard];
            break;
        }
}





/**弹出键盘*/
-(void)showKeyboard
{
    if (self.composeView.inputView==nil)
    {
        self.composeView.inputView=self.composeKeyBoard;
        self.toolBar.showKeyboardBtn=YES;
    }
    else
    {
        self.composeView.inputView=nil;
        self.toolBar.showKeyboardBtn=NO;

    }
    
    self.switchKeyBoard=YES;
    [self.composeView endEditing:YES];
    self.switchKeyBoard=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.composeView becomeFirstResponder];
    });
    
}


//打开imagePickerController控制器
-(void)openImagePickerWithSourceType:(UIImagePickerControllerSourceType )sourceType
{
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
        
    {
        return;
       
    }
    UIImagePickerController *pick=[[UIImagePickerController alloc]init];
    pick.sourceType=sourceType;
    pick.delegate=self;
    [self presentViewController:pick animated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    [self.scrollPhotosView addPhoto:image];
}
/**
 键盘frame发生改变
 
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
 */
-(void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.switchKeyBoard) return;
    NSDictionary * userInfo=notification.userInfo;
    double duration=[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF=[userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        if ((keyboardF.origin.y)>self.view.height)
        {
            self.toolBar.y=self.view.height-self.toolBar.height;
        }
        else{
            self.toolBar.y=keyboardF.origin.y-self.toolBar.height;
        }
    }];
}


//输入框的代理
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(void)canleTap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)sendTap
{
    if (self.scrollPhotosView.photosArray.count)
    {
        [self sendImageStatus];
    }
    else
    {
        [self sendStatus];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
#pragma mark --发微博
/**
 * 发布带有图片的微博
 */
- (void)sendImageStatus
{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    
    // 1.请求管理者
   
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"status"] = self.composeView.fullText;
    
    // 2.封装文件参数
    
    NSMutableArray * formDatas=[NSMutableArray array];
    WBFormData * formData=[[WBFormData alloc]init];
    UIImage *image = [self.scrollPhotosView.photosArray firstObject];
    
    formData.data=UIImageJPEGRepresentation(image, 1.0);
    formData.name=@"pic";
    formData.fileName=@"test.jpg";
    formData.mimeType=@"image/jpeg";
    
    [formDatas addObject:formData];

    // 3.发送请求
    [HttpTool postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json"  parmar:params formDataArray:formDatas success:^(id json) {
         [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
}


/**发布没有图片的微博*/
-(void)sendStatus
{
    WBAccount * accout=[WBAccountTool account];
    //https://api.weibo.com/2/statuses/update.json
    AFHTTPRequestOperationManager * man=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *par=[NSMutableDictionary dictionary];
    par[@"access_token"]=accout.access_token;
    par[@"status"]=self.composeView.fullText;
    [man POST:@"https://api.weibo.com/2/statuses/update.json" parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD showSuccess:@"发送成功！"];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发送失败！"];
    }];
}

@end
