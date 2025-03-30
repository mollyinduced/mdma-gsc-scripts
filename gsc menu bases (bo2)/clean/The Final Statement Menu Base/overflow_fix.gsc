initOverFlowFix()
{
        self.stringTable = [];
        self.stringTableEntryCount = 0;
        self.textTable = [];
        self.textTableEntryCount = 0;
       
        if(isDefined(level.anchorText) == false)
        {
                level.anchorText = createServerFontString("default",1.5);
                level.anchorText setText("anchor");
                level.anchorText.alpha = 0;
               
                level.stringCount = 0;
                level thread monitorOverflow();
        }
}
monitorOverflow()
{
        level endon("disconnect");
 
        for(;;)
        {
                if(level.stringCount >= 60)
                {
                        level.anchorText clearAllTextAfterHudElem();
                        level.stringCount = 0;
                       
                        foreach(player in level.players)
                        {
                                player purgeTextTable();
                                player purgeStringTable();
                                player recreateText();
                        }
                }
               
                wait 0.05;
        }
}
 
setSafeText(player, text)
{
        stringId = player getStringId(text);
       
        if(stringId == -1)
        {
                player addStringTableEntry(text);
                stringId = player getStringId(text);
        }
       
        player editTextTableEntry(self.textTableIndex, stringId);
 
        self setText(text);
}
 
recreateText()
{
        foreach(entry in self.textTable)
                entry.element setSafeText(self, lookUpStringById(entry.stringId));
}
 
addStringTableEntry(string)
{
        entry = spawnStruct();
        entry.id = self.stringTableEntryCount;
        entry.string = string;
        self.stringTable[self.stringTable.size] = entry; 
        self.stringTableEntryCount++;
        level.stringCount++;
}
 
lookUpStringById(id)
{
        string = "";
 
        foreach(entry in self.stringTable)
        {
                if(entry.id == id)
                {
                        string = entry.string;
                        break;
                }
        }
 
        return string;
}
 
getStringId(string)
{
        id = -1;
       
        foreach(entry in self.stringTable)
        {
                if(entry.string == string)
                {
                        id = entry.id;
                        break;
                }
        }
 
        return id;
}
 
getStringTableEntry(id)
{
        stringTableEntry = -1;
       
        foreach(entry in self.stringTable)
        {
                if(entry.id == id)
                {
                        stringTableEntry = entry;
                        break;
                }
        }
 
        return stringTableEntry;
}
 
purgeStringTable()
{
        stringTable = [];
 
        foreach(entry in self.textTable)
                stringTable[stringTable.size] = getStringTableEntry(entry.stringId);
 
        self.stringTable = stringTable; 
}
 
purgeTextTable()
{
        textTable = [];
       
        foreach(entry in self.textTable)
        {
                if(entry.id != -1)
                        textTable[textTable.size] = entry;
        }
 
        self.textTable = textTable;
}
 
addTextTableEntry(element, stringId)
{
        entry = spawnStruct();
        entry.id = self.textTableEntryCount;
        entry.element = element;
        entry.stringId = stringId;
       
        element.textTableIndex = entry.id;
 
        self.textTable[self.textTable.size] = entry;
        self.textTableEntryCount++;
}
 
editTextTableEntry(id, stringId)
{
        foreach(entry in self.textTable)
        {
                if(entry.id == id)
                {
                        entry.stringId = stringId;
                        break;
                }
        }
}
 
deleteTextTableEntry(id)
{
        foreach(entry in self.textTable)
        {
                if(entry.id == id)
                {
                        entry.id = -1;
                        entry.stringId = -1;
                }
        }
}
 
clear(player)
{
        if(self.type == "text")
                player deleteTextTableEntry(self.textTableIndex);
               
        self destroy();
}






