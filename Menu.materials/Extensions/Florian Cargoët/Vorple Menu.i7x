Vorple Menu by Florian Cargoët begins here.

Section - Menus

Include (-

[ LIST_OF_TY_Say_concat list no_items v i bk;
	if ((list==0) || (BlkValueWeakKind(list) ~= LIST_OF_TY)) return;
	no_items = BlkValueRead(list, LIST_LENGTH_F);
	bk = KindAtomic(BlkValueRead(list, LIST_ITEM_KOV_F));
	for (i=0:i<no_items:i++) {
		v = BlkValueRead(list, i+LIST_ITEM_BASE);
		if (bk == LIST_OF_TY) LIST_OF_TY_Say_concat(v);
		else PrintKindValuePair(bk, v);
	}
	prior_named_list = no_items; prior_named_list_gender = -1;
];

-)

To say (L - a list of values) concatenated:
	(- LIST_OF_TY_Say_concat({-by-reference:L}); -).

To iterate scope with (func - phrase thing -> nothing):
	(-scope_token=0; LoopOverScope({func}-->1); -);

Batched commands is a list of text that varies.

The menu rulebook is an object based rulebook.

A Vorple interface update rule:
	update the menu;

To update the menu:
	truncate batched commands to 0 entries;
	add "resetMenu();" to batched commands;
	[We don't want to interfere with substitution here.]
	now disabled tag wrapping is true;
	iterate scope with the menu item generator;
	execute javascript command "[batched commands concatenated]";
	now disabled tag wrapping is false;

[name only]
To add menu item (name - text) for (o - object):
	add menu item name with icon "" for o with command name;

[name & icon]
To add menu item (name - text) with icon (icon - text) for (o - object):
	add menu item name with icon icon for o with command name;

[name & command]
To add menu item (name - text) for (o - object) with command (cmd - text):
	add menu item name with icon "" for o with command name;

[name & command & icon]
To add menu item (name - text) with icon (icon - text) for (o - object) with command (cmd - text):
	add "addToMenu([id of o], '[cmd]', '[name]', '[icon]');" to batched commands;

To decide which number is the id of (o - an object):
	(- {o} -);

To generate the menu entry for (t - a thing) (this is the menu item generator):
	follow the menu rulebook for t;

Disabled tag wrapping is a truth state that varies.

To say menu for (o - an object) -- beginning say_menu:
	[Do not nest menu.]
	now disabled tag wrapping is true;
	open HTML tag "a" called "menu-link object-id-[id of o]";

To say /menu -- ending say_menu:
	close HTML tag;
	now disabled tag wrapping is false;

Before printing the name of something (called the target):
	if disabled tag wrapping is false:
		open HTML tag "a" called "menu-link object-id-[id of target]";

After printing the name of something:
	if disabled tag wrapping is false:
		close HTML tag;

Vorple Menu ends here.
