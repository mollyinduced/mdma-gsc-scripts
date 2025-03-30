Just passing it along since Diablo 4 is coming out soon. This isn't anyway the best menu base. It has issues and needs cleaning, but it does work and can be ported to any game title.

Hopefully I labeled everything correctly for the admins.

Features:

shaders

toggle
sub menu
color
resize hud
text

options <- duh
slider arrays <- strtok or array()
https://forum.plutonium.pw/assets/uploads/files/1684624314612-3.png
https://forum.plutonium.pw/assets/uploads/files/1684624314606-2.png
https://forum.plutonium.pw/assets/uploads/files/1684624314601-1.png

The feature elements classified as option_left and option_right.

issue
if self.menu.toggle ~ toggle shader
if self.menu.shader ~ color shader
if self.menu.function == new_menu ~ submenu shader
if self.menu.slider ~ slider option
does have support for infinity toggles but the why the scrolling is done it won't work.
could be some unknow issues also, report any and I'll fix it in the year 2038
this does work very well and I haven't had any issues with it but it isn't the best way to do it.

this can be improved by migrating from a store text system to a set menu text system.

XTUL latest overflow

have fun
Doesn't have client support

can be added but I didn't
How To Add Menus?
https://forum.plutonium.pw/assets/uploads/files/1684624963034-4.png
How Do I Add Menus In Menus?
https://forum.plutonium.pw/assets/uploads/files/1684625084615-5.png
you can also just do convert( a1 ) as the title

How Do I Add Option?

Option Types
https://forum.plutonium.pw/assets/uploads/files/1684625572818-6.png
Creating a toggle
<toggle> bool( self.toggle ), bool is just true and false
inside the function you need update_toggle( bool( self.toggle ) ) to update the toggle
Creating a shader
<shader> will be the shader, example "white", this could be anything.
<input_a> is the hud element - you can probably just undefined this
<input_b> is the color for the shader
<input_c> is the width of the shader
<input_d> is the height of the shader
Creating a slider
<array> this will be what the array gets placed in
this can be a strtok( "", ";" ) or array( "", "" )
you can also store an array in the init() level.testing = array( "a", "b", "c" );
and place level.testing the the <array> location in the self slider();
useful slider junk
self.menu.slider[ menu ][ "slider" ][ cursor ];
example: beans = self.menu.slider[ menu ][ "slider" ][ cursor ];
if( beans = <Text A> ) do text a
self.menu.slider_cursor[ menu + "_cursor" ][ cursor ];
same as before but you can use the cursor index to increment values
if you ever worked with the aio structure the code will be very similar except one was bullied by me. I haven't seen a menu base that uses toggle shaders that is publicly available so do enjoy. If you make any improvements, please share and don't look at the update_scroller().

If you're just using it for mods, the explanation on how to add menus and option types is good enough for you.

If you're editing, self.menu.cursor[ self.menu.current_menu ] or cursor = get_cursor() will be your friend same as menu = get_menu();

file needs to go here > c:\users\ <YOU> \appdata\local\plutonium\storage\t6\scripts\zm
https://www.mediafire.com/file/20vpd6hgjc8dxw2/aio_pluto_t6.gsc/file

Credits <- these the goons that originally worked with the aio, hopefully didn't miss anyone
extinct
xtul
mikey
shark
loz
xepixtvx
sygnus
youviolateme

PPS the menu isn't good 😄 the curse is now yours

have a cute snake picture from my collection