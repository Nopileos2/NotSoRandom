# NotSoRandom
This is a mod for [Clicker Heros 2](https://www.clickerheroes2.com) to make the "Buy Random Catalog Item" gem 
not so random anymore. It allows you to prioritize certain stats other others. Please note that it will only take the
first 3 catalog options into account. It does not use the *Random Stats* one which might be more optimal in rare cases.
    
This mod is the updated version of the previously released 
[Not So Random Mod](https://www.reddit.com/r/ClickerHeroes/comments/af5ffd/not_so_random_mod_081/).
Please note this is only for the Automator gem available for Cid, not for the Exchange Spell available for Cursor.

## Installation

For a general guide please refer to https://www.clickerheroes2.com/installing_mods.php on how to install mods.

1. Download the latest release from [here](https://github.com/Nopileos2/NotSoRandom/releases).
2. Extract the files from the zip, it should include a **NotSoRandom.swf** file and a default orders.txt
3. Before proceeding backup you save just in case. Saves can be found by typing `%appdata%\ClickerHeroes2\Local Store`
into the address bar. To backup just copy and paste the `saves` somewhere else.
4. Next put the **NotSoRandom.swf.swf** and the **orders.txt** into the `...\Clicker Heroes 2\mods\active`. 
For steam the `Clicker Heros 2` folder can be found at `..\Steam\steamapps\common\`. For standalone wherever 
your installation is.
5. Add **NotSoRandom.swf** to the **BOTTOM** of **mods.txt** (also found in `%appdata%\ClickerHeroes2\Local Store`)


## Changing the priority

The mod will give the stats a priority according to the order inside the **order.txt** file. To change the priority just
change the order inside the **order.txt**.  
**Be careful to only change the order and not the text itself.** If e.g. *Treasure Chest Gold* 
is changed to *Treasurechest Gold* it won't be recognized anymore and the stat *Treasure Chest Gold* 
will be assigned the lowest priority. **Also don't add any extra lines not at the beginning in between or at the end.**

As an example with the following content of the **order.txt** the mod will scan the first 3 catalog items and 
buys the one with the highest priority stat on it. So if there is a item with *Treasure Chest Gold* it will be bought, 
if there is none but one with *Crit Damage* it will be bought and so on.
```
Treasure Chest Gold 
Crit Damage  
Haste  
Gold Received  
Click Damage  
Monster Gold  
Autoattack Damage  
Clickable Gold  
Mana Regeneration  
Total Energy  
Total Mana
```

## Build it yourself

To build the mod yourself please refer to the [basic tutorial](https://www.clickerheroes2.com/creating_mods.php)
on how to develop mods for CH2. If there are problems with getting the SDK installed try to download it manually and set
the custom SDK path ot the FlashDevelop project to the downloaded SDK.



