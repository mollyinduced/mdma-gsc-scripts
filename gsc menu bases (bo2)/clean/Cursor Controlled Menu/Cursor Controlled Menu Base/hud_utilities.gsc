/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : hud_utilities
*	 Description : Includes the createText and createRectangle functions
*	 Date : 2015/06/21 - 12:21:36	
*
*/	

createText(font, fontscale, align, relative, x, y, sort, alpha, color, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.sort = sort;
	textElem.color = color;
	textElem.alpha = alpha;
	textElem.hideWhenInMenu = true;

	level.result += 1;
	textElem setText(text);
	level notify("textset");
	
	return textElem;
}

createRectangle(align, relative, x, y, width, height, sort, color, alpha, shader)
{
	shaderElem = newClientHudElem(self);
	shaderElem.elemType = "bar";
	shaderElem.children = [];
	shaderElem.sort = sort;
	shaderElem.color = color;
	shaderElem.alpha = alpha;
	shaderElem setParent(level.uiParent);
	shaderElem setShader(shader, width, height);
	shaderElem.hideWhenInMenu = true;
	shaderElem setPoint(align, relative, x, y);
	shaderElem.type = "shader";
	
	return shaderElem;
}
