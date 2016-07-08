//
//  AddViewController.m
//  contact
//
//  Created by 陶玉程 on 16/7/8.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import "AddViewController.h"
#import "IQKeyboardManager.h"
#import "People.h"
#import "ContactViewController.h"
#import <pop/POP.h>

typedef NS_ENUM(NSUInteger, ShopStyle) {
    ShopStyleNew = 0,
    ShopStyleOld = 1
};

@interface AddViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *nameBackView;
@property (weak, nonatomic) IBOutlet UIView *phoneBackView;
@property (weak, nonatomic) IBOutlet UIView *doubleButtonBackView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *buttonNew;
@property (weak, nonatomic) IBOutlet UIButton *buttonOld;
@property (weak, nonatomic) IBOutlet UIButton *buttonConfirm;
@property (weak, nonatomic) IBOutlet UIButton *buttonContact;
@property (nonatomic, assign) ShopStyle shopStyle;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70;
    [self setSubViews];
}

- (void)setSubViews {
    _nameBackView.layer.cornerRadius = 5.f;
    _phoneBackView.layer.cornerRadius = 5.f;
    _doubleButtonBackView.layer.cornerRadius = 5.f;
    _doubleButtonBackView.layer.masksToBounds = YES;
    _buttonConfirm.layer.cornerRadius = 5.f;
    _buttonConfirm.layer.masksToBounds = YES;
    
    _nameTextField.returnKeyType = UIReturnKeyNext;
    _nameTextField.delegate = self;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    _phoneTextField.delegate = self;
    
    [_buttonNew setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_buttonNew addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonOld setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_buttonOld addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonConfirm addTarget:self action:@selector(confirmButtonSelect) forControlEvents:UIControlEventTouchUpInside];
    [_buttonContact addTarget:self action:@selector(presentContactVC) forControlEvents:UIControlEventTouchUpInside];
    
    _shopStyle = ShopStyleNew;
    _buttonNew.selected = YES;
    _buttonNew.userInteractionEnabled = NO;
    _buttonNew.backgroundColor = BLUECOLOR;
}

- (void)buttonSelect:(UIButton *)button {
    if (button.selected) {
        return;
    }
    button.selected = YES;
    button.backgroundColor = BLUECOLOR;
    if ([button isEqual:_buttonNew]) {
        _buttonNew.userInteractionEnabled = NO;
        _buttonOld.userInteractionEnabled = YES;
        _buttonOld.selected = NO;
        _buttonOld.backgroundColor = [UIColor whiteColor];
        _shopStyle = ShopStyleNew;
        
    } else {
        _buttonOld.userInteractionEnabled = NO;
        _buttonNew.userInteractionEnabled = YES;
        _buttonNew.selected = NO;
        _buttonNew.backgroundColor = [UIColor whiteColor];
        _shopStyle = ShopStyleOld;
    }
}

- (BOOL)matchesPhoneRegEx {
    NSString *phoneRegEx = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    return [predicate evaluateWithObject:_phoneTextField.text];
}

- (void)addContact {
    People *people = [[People alloc] init];
    people.name = _nameTextField.text;
    people.phoneNumber = _phoneTextField.text;
    people.shopStyle = [NSString stringWithFormat:@"%lu", _shopStyle];
    
    NSArray *sandBox = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 1, YES);
    NSString *path = [sandBox firstObject];
    NSString *docPath = [path stringByAppendingPathComponent:@"people.plist"];
    
    //解档
    NSMutableArray *originArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:docPath]];
    //写入新的
    [originArray addObject:people];
    //归档
    [NSKeyedArchiver archiveRootObject:originArray toFile:docPath];
}

- (void)clear {
    _nameTextField.text = nil;
    _phoneTextField.text = nil;
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

//MARK:确认按钮点击方法
- (void)confirmButtonSelect {
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    animation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    animation.springBounciness = 18.0f;
    [_buttonConfirm pop_addAnimation:animation forKey:nil];
    
    if (!_nameTextField.text.length && !_phoneTextField.text.length) {
        [self showAlertWithTitle:@"添加失败" andMessage:@"姓名和电话号码不能为空"];
    } else if (!_nameTextField.text.length && _phoneTextField.text.length && ![self matchesPhoneRegEx]) {
        [self showAlertWithTitle:@"添加失败" andMessage:@"姓名不能为空，电话号码格式错误"];
    } else if (!_nameTextField.text.length && _phoneTextField.text.length && [self matchesPhoneRegEx]) {
        [self showAlertWithTitle:@"添加失败" andMessage:@"姓名不能为空"];
    } else if (_nameTextField.text.length && !_phoneTextField.text.length) {
        [self showAlertWithTitle:@"添加失败" andMessage:@"电话号码不能为空"];
    } else if (_nameTextField.text.length && _phoneTextField.text.length && ![self matchesPhoneRegEx]) {
        [self showAlertWithTitle:@"添加失败" andMessage:@"电话号码格式错误"];
    } else {
        [self showAlertWithTitle:@"提示" andMessage:@"添加成功"];
        [self addContact];
        [self clear];
    }
}


- (void)presentContactVC {
    //解档
    NSArray *sandBox = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 1, YES);
    NSString *path = [sandBox firstObject];
    NSString *docPath = [path stringByAppendingPathComponent:@"people.plist"];
    NSMutableArray *originArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:docPath]];
    //跳转
    ContactViewController *conVC = [[ContactViewController alloc] init];
    conVC.contactArray = originArray;
    [conVC setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self presentViewController:conVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_nameTextField isEqual:textField]) {
        [_phoneTextField becomeFirstResponder];
        [textField resignFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
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
