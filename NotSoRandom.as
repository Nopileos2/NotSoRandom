package {
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import heroclickerlib.CH2;
   import models.Character;
   import models.Characters;
   import models.Item;
   import models.ItemStat;
   import models.Skill;	
   import IdleHeroConsole;

   public class NotSoRandom extends Sprite {
      public var MOD_INFO:Object;
      public var textFileLoaded:Boolean;
      public var order:Array;
      
      public function NotSoRandom() {
         this.MOD_INFO = {
            "name":"Not So Random",
            "description":"Prioritize which catalog items the Buy Random Catalog Item Gem buys.",
            "version":3,
            "author":"Naluni and Nopileos"
         };
         this.order = new Array();
		 this.textFileLoaded = false;
         super();
      }
      
      public function onStartup(game:IdleHeroMain) : void {
         this.textFileLoaded = false;
         this.readTextfile();
		 
		 var char : Character = Characters.startingDefaultInstances["Helpful Adventurer"];
		 var node : Object = null;
		 
		 // find the "Buy Random Catalog" gem
		 
		 for (var i : String in char.levelGraphNodeTypes) {
			if (char.levelGraphNodeTypes[i]["name"] == "Gem: Buy Random Catalog") {
				node = char.levelGraphNodeTypes[i];
				break;
			}
		 }
		 
		 if ( node != null ) {
			 node["setupFunction"] = function() : void {
				addBuyNotSoRandomCatalogItemGem();
			 };
		 }
      }
      
      public function onStaticDataLoaded(staticData:Object) : void {}
      
      public function onUserDataLoaded() : void {}
      
      public function onCharacterCreated(char:Character) : void {}
      
      private function addBuyNotSoRandomCatalogItemGem() : void {
		 var char : Character = CH2.currentCharacter;
			 
		 char.automator.addGem(char.name + "_4",
		 "Buy Best Catalog Item",
		 97,
		 "Buys the best catalog item according to the configured priority.",
		 this.onBuyRandomCatalogItemGemActivate,
		 this.canBuyRandomCatalogItem,
		 500);
		 
		 CH2.game.console.print(this.MOD_INFO["name"] + " successfully loaded!");
      }
      
      public function canBuyRandomCatalogItem() : Boolean {
         var catalog:Array = null;
         var randomItemIndex:int = 0;
         var randomItem:Item = null;
         var character:Character = CH2.currentCharacter;
         if (!character.didFinishWorld && character.catalogItemsForSale && character.catalogItemsForSale.length > 0) {
            catalog = character.catalogItemsForSale;
            randomItemIndex = CH2.roller.modRoller.integer(0,catalog.length - 1);
            randomItem = catalog[randomItemIndex];
            return !character.itemPurchasesLocked && character.gold.gte(randomItem.cost());
         }
         return false;
      }
      
      public function onBuyRandomCatalogItemGemActivate() : Boolean {
         var itemStat:ItemStat = null;
         var itemStatId:Number = NaN;
         var itemPriority:Number = NaN;
         var i:int = 0;
         var character:Character = CH2.currentCharacter;
         if (character.itemPurchasesLocked || character.didFinishWorld || !this.textFileLoaded) {
            return false;
         }
         var catalog:Array = character.catalogItemsForSale;
         var currentSelectedItem:Item = catalog[0];
         var currentSelectedItemIndex:Number = 0;
         var currentSelectedPrority:Number = 100;
         for(var j:int = 0; j < catalog.length; j++) {
            itemStat = catalog[j].newestItemStat;
            itemStatId = itemStat.id;
            itemPriority = 100;
            for (i = 0; i < this.order.length; i++) {
               if (itemStatId == this.order[i]) {
                  itemPriority = i;
                  break;
               }
            }
            if(itemPriority < currentSelectedPrority) {
               currentSelectedItem = catalog[j];
               currentSelectedItemIndex = j;
               currentSelectedPrority = itemPriority;
            }
         }
         var randomItemIndex:Number = currentSelectedItemIndex;
         var randomItem:Item = currentSelectedItem;
         if(character.gold.gte(randomItem.cost())) {
            character.purchaseCatalogItem(randomItemIndex);	
			
            return true;
         }
         return false;
      }
      
	private function readTextfile() : void {
         var loader:URLLoader = null;
         var loaderComplete:Function = null;
         loaderComplete = function(event:Event):void {
            loader.removeEventListener(Event.COMPLETE,loaderComplete);
            order = event.target.data.split("\n");
            for (var i:int = 0; i < order.length; i++) {
               if (String(order[i]).search("Crit Damage") != -1) {
                  order[i] = CH2.STAT_CRIT_DAMAGE;
               }
			   if (String(order[i]).search("Autoattack Damage") != -1) {
                  order[i] = CH2.STAT_AUTOATTACK_DAMAGE;
               }
               if (String(order[i]).search("Haste") != -1) {
                  order[i] = CH2.STAT_HASTE;
               }
               if (String(order[i]).search("Clickable Gold") != -1) {
                  order[i] = CH2.STAT_CLICKABLE_GOLD;
               }
               if (String(order[i]).search("Click Damage") != -1) {
                  order[i] = CH2.STAT_CLICK_DAMAGE;
               }
               if (String(order[i]).search("Monster Gold") != -1) {
                  order[i] = CH2.STAT_MONSTER_GOLD;
               }
               if (String(order[i]).search("Total Mana") != -1) {
                  order[i] = CH2.STAT_TOTAL_MANA;
               }
               if (String(order[i]).search("Mana Regeneration") != -1) {
                  order[i] = CH2.STAT_MANA_REGEN;
               }
               if (String(order[i]).search("Total Energy") != -1) {
                  order[i] = CH2.STAT_TOTAL_ENERGY;
               }
               if (String(order[i]).search("Treasure Chest Gold") != -1) {
                  order[i] = CH2.STAT_TREASURE_CHEST_GOLD;
               }
               if (String(order[i]).search("Gold Received") != -1) {
                  order[i] = CH2.STAT_GOLD;
               }
            }
            textFileLoaded = true;
         };
         var url:URLRequest = new URLRequest("order.txt");
         loader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,loaderComplete);
         loader.load(url);
      }
   }
}
