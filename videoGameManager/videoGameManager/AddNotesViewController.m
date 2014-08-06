//
//  AddNotesViewController.m
//  videogameBacklogManager
//
//  Created by Deepkanwal Plaha on 11/9/2013.
//  Copyright (c) 2013 Deepkanwal Plaha. All rights reserved.
//

#import "AddNotesViewController.h"
#import "AddedGame.h"
#import "UIView+Additions.h"
#import "UIHelper.h"

@interface AddNotesViewController ()
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@property (strong, nonatomic) AddedGame *addedGame;
@end

@implementation AddNotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([self.detailItem isKindOfClass:[AddedGame class]]) {
        self.addedGame = self.detailItem;
    }
    
    [self.view setBackgroundColor:kUI_COLOR_DEFAULT_BACKGROUNG_GRAY];
    [self.notesTextView applyBorder];
    [self.notesTextView applyRoundedCorners:5.0f];
    [self.notesTextView setTintColor:kUI_COLOR_DEFAULT_TINT];
    
    if (self.addedGame.notes.length > 0) {
        [self.notesTextView setText:self.addedGame.notes];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [self.notesTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat height = CGRectGetHeight(self.notesTextView.bounds) - CGRectGetHeight(frame) - kUI_PADDING_5;
    [self.notesTextView resizeHeight:height];
}

#pragma mark - IBActions

- (IBAction)actionDoneButtonPressed:(id)sender {
    [self.addedGame setNotes:self.notesTextView.text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextField Deletage methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
}

@end
