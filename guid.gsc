// NOTE: THIS REQUIRES A PLUGIN CALLED 't6-gsc-utils'. IT CAN BE FOUND ON GITHUB.

// this is a script that grabs and stores a players guid into a text document as its called flatfile storage
// we do some conversion by converting decimal to hex, idk why i do it but its a pasted function from menus (might remove in update)

// this is not finished.

//todo:
//  doesn't check for dupe lines so recreates and adds already added users
//  see if name changing works, and add it storing the old guids in a txt file called "old_guids.txt"
//  make a getter for this function so you can retrieve them when a player is offline/online
//  integrate into server/gsc functions

init()
{
    level thread on_player_connect();
}

on_player_connect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread log_guid();
    }
}

log_guid() {
    if (isEntityABot()) {
        return;
    }

    guid = self getGuid();
    name = self.name;

    data = [];
    path = "guids.txt";
    old_path = "old_guids.txt";
    line = "name: " + name + " | guid: " + guid;

    if (fileExists(path)) {
        file = fopen(path, "r");

        if (file != 0) {
            data = fread(file);
            fclose(file);
        }
    }
    
    isupdated = false;

    for (i = 0; i < data.size; i++) {
        updated = data[i];
    }

    isdupe = false;
    for (i = 0; i < data.size; i++) {
        dupe = data[i];
        if (dupe == line) {
            // print("duplicate found! not printing");
            // print(dupe);
            isdupe = true;
            break;
        }
    }
            

    // append data to line
    data[data.size] = line;

    // remove duplicates from data
    data = remove_duplicates(data);

    // write data to file

    if (!isdupe) {
    write_guids = fopen(path, "a");
        if (write_guids != 0)
        {
            fwrite(write_guids, line + "\n"); 
            fclose(write_guids);
        }
    }
}



remove_duplicates(stream) {
    unique = [];

    for (i = 0; i < stream.size; i++) {
        line = stream[i];

        if (!array_contains(unique, line)) {
            unique[unique.size] = line;
        }
    }

    return unique;
}

array_contains(array, value) {
    for (i = 0; i < array.size; i++) {
        if (array[i] == value) {
            return true;
        }
    }

    return false;
}

// entity check, honestly just import your fucking player utility nimrod
isEntityABot()
{
    return (isDefined(self.pers["isBot"]) && self.pers["isBot"]);
}

// check if 'search' is contained in 'string', duplication check
str_contains(string, search)
{
    return (strTok(string, search).size > 1);
}
