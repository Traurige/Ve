#import "VeSearchBarCell.h"

@implementation VeSearchBarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier { // style the cell

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];


	// search bar
	self.searchBar = specifier.properties[@"searchBar"];
	[[self searchBar] setPlaceholder:@"Search"];
    [[self searchBar] setBackgroundImage:[UIImage new]];
    [[self searchBar] setReturnKeyType:UIReturnKeyDone];
    [self addSubview:[self searchBar]];
    
    [[self searchBar] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.searchBar.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.searchBar.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.searchBar.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
    ]];


	return self;

}

@end