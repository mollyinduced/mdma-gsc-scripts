/*Extincts Menu Base Features:
● Scroller Remembrance
● 3D Scrolling
● Menu Sliders
● Colour Toggles
● Text Toggles
● Description Text
● Shader Submenus
● Undefined Submenu Safety
● Verification System
● Access level Submenus
● Menu Customizations
● Overflow Fix
● Clean Menu Design
● User friendly Code

★ Credit(s) ★
● Extinct (Me) ~ Creating the base
● AgreedBog ~ Scrolling example 
● dtx12 - xTurntUpLobbies - Jwm614 ~ Overflow fix
● SeriousHD ~ Showing me how to make a menu base first (AIO Menu Base)
● Crysis ~ Initial design before the final design & support  

Change Log:
Date: 01/03/2017
     Initial Release.

Date: 06/03/2017
     Added Access level Submenus
     Added Menu Customizations
     Added Welcome Message

Date: 26/05/2017
	Added Menu Sliders  
	Updated Menu Structure
	Updated Menu GUI

Date: 10/07/2017
	Updated Access Level Submenus
	Added Example Sliders
	Add Menu Closing Animation
	
Bug Log:
Date: 01/03/2017
     No bugs were found in the initial release.

Date: 26/05/2017 
	No bugs were found in the v1.2 release.

Referances ~ 
	How to add submenus;
		To add submenus you need to do the following. Add a Option under the 'main' submenu. for example like this.
			self addOpt("<OPTION NAME>", "<OPTION DESCRIPTION>",::newMenu,"<SUBMENU NAME>");
				Once you have done that you would need to add a 'addMenu' then add options underneath that, here is an example.
					self addMenu("<SUBMENU NAME>", "<SUBMENU TITLE>");
						If you would like a access level set on a certain sub menu you simply do the following
							self addMenu("<SUBMENU NAME>", "<SUBMENU TITLE>", "<ACCESS LEVELS>");
								if you would like to do a shader menu you would do the following
									self addMenu("<SUBMENU NAME>", "<SUBMENU TITLE>", "<ACCESS LEVELS>", "<SHADER WIDTH;SHADER HEIGHT>");//NOTE you need a semicolon inbetween the width and height
	How to add options;
		To add options you need to do the following, under your 'self addMenu("<SUBMENU NAME>", "<SUBMENU TITLE>");'
			self addOpt("<OPTION NAME>", "OPTION DESCRIPTION",<::FUNCTION CALL>); //NOTE: YOU CAN USE 5 PARAMETERS AFTER THE FUNCTION CALL 
			
	If you still need further help feel free to contact me on skype: Extinctxo
		Enjoy using my menu base!   
*/









