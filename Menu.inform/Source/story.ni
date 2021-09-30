"The menu".

Release along with the "Vorple" interpreter.

Include Vorple by Juhana Leinonen.
Include Vorple Hyperlinks by Juhana Leinonen.

[ This is the extension. ]
Include Vorple Menu by Florian Cargoët.

[ We need to include some scripts and stylesheets in the generated website. ]
[ This one doesn't use "with Javascript" since jQuery is not yet loaded. It will be loaded later by menu.js. ]
Release along with file "jquery.contextMenu.min.js".
[ These are included by Inform in the HTML. ]
Release along with style sheet "jquery.contextMenu.min.css".
Release along with Javascript "menu.js".
Release along with style sheet "menu.css".

Section - Menu rules

[ By default, nothing has a menu. To create a menu for an object, you have to call "add menu item" in a "menu rule". ]

A first menu rule for a portable thing (called t) which is not a person:
	if the player has t:
		[ This creates a "drop the (name of the thing)" menu item. ]
		add menu item "drop [the t]" for t;
	else:
		[ You can add Font Awesome icons. ]
		add menu item "take [the t]" with icon "fas fa-hand-paper" for t;

A first menu rule for a thing (called t):
	if the description of t is not "":
		add menu item "examine [the t]" with icon "fas fa-search" for t;

A menu rule for an edible thing (called food):
	add menu item "eat [the food]" with icon "fas fa-utensils" for food;

A menu rule for a wearable thing (called clothes):
	if the player wears the clothes:
		add menu item "take off [the clothes]" with icon "fas fa-tshirt" for clothes;
	else:
		add menu item "wear [the clothes]" with icon "fas fa-tshirt" for clothes;

A menu rule for a person (called p):
	add menu item "talk to [the p]" for p;

A menu rule for a device (called d):
	if d is switched on:
		add menu item "switch off [the d]" for d;
	else:
		add menu item "switch on [the d]" for d;

A menu rule for an openable thing (called t):
	if t is open:
		add menu item "close [the t]" for t;
	else:
		add menu item "open [the t]" for t;

A menu rule for a door (called d):
	[ This rule is more specific so it's evaluated after the "openable" one. The menu items will overwrite the previous ones. ]
	if d is open:
		add menu item "close [the d]" with icon "fas fa-door-closed" for d;
	else:
		add menu item "open [the d]" with icon "fas fa-door-open" for d;
	let dir be the direction of d from the location;
	add menu item "go [dir]" for d;

A menu rule for an enterable thing (called t):
	add menu item "enter [the t]" for t;

A menu rule for the water gun when the player carries the water gun:
	repeat with person running through people in the location:
		[ You can create sub-menus with the > symbol. ]
		add menu item "shoot [the water gun] at > [person or myself]" for the water gun;

To say (p - someone) or myself:
	if p is the player:
		say "myself";
	else:
		say p;

A menu rule for the deep menu:
	add menu item "sub 1 > sub 2 > sub 3 > so deep" for the deep menu with command "think";

Section - Story

[

Now, there are two ways to display a clickable object (a link which will open a menu when clicked):
	- The simplest one is to say "blah blah [a thing] blah blah"
	- If you want the link to have a different text, you can use the second form: say "blah [menu for thing]your text[/menu] blah"
]


#inform channel is a room. "The chat room where coders like to pretend they are writers. [menu for hlabrande]The boss, [hlabrande][/menu], is here, holding [a sign] which reads 'Can someone write me some Javascript?' He wears [a red hat].".

hlabrande is a man in the #inform channel.
He carries a sign. The description of the sign is "It reads 'Can someone write me some Javascript?'".
hlabrande wears a red hat.

Understand "talk to [someone]" as talking to.
Understand "talk to [something]" as talking to. Talking to is an action applying to one visible thing.

Instead of talking to hlabrande:
	say "You realize that he will probably ask you about this Java thing and you know nothing about it. Better ignore him.".

A banana is in #inform channel. The description is "A banana, around one reddit banana tall.".
It is edible.

Instead of eating the banana:
	if hlabrande is in the location:
		say "[hlabrande] shouts at you: 'Hey that's my banana!'[line break]You say: 'I'm keeping it safe for you' and you pocket it.";
		now the player carries the banana;
	else:
		say "You try to peel it but you realize it's a plastic banana.";

A water gun is in #inform.

Shooting it at is an action applying to two things.
Understand "shoot [something preferably held] at [someone]" as shooting it at.
Report shooting it at:
	if the second noun is the player:
		say "Are you thirsty?";
	else:
		say "Pew! Pew! I mean, Splash!";

The deep menu is in #inform.

The steel door is a door.
#inform channel is south of the steel door.

#twine is a room. "Nothing to see here, it's a just a demo[if the chest is in the location]. OK, here's [a chest][end if].".
It is north of the steel door.

A chest is an openable closed container in #twine.

After opening the chest: say "There's nothing in here, how disappointing.".

