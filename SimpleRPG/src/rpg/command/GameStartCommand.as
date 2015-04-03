package rpg.command
{
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	
	import mk.util.ObjUtil;
	
	import org.flexlite.domUI.components.Alert;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import rpg.DataBase;
	import rpg.WindowConst;
	import rpg.events.AppEvent;
	import rpg.events.SceneEvent;
	import rpg.model.Actor;
	import rpg.model.Party;
	import rpg.vo.EquipItem;
	
	public class GameStartCommand extends Command
	{
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		public function GameStartCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			setup();
			dispatcher.dispatchEvent(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_CITY));
			dispatcher.dispatchEvent(new AppEvent(AppEvent.SAVE));
		}
		
		public function setup():void{
			var party:Party=Party.getInstance();
			party.setup(1);
			party.recover_all();
			party.gold=100000;
			//	learnWindow.actors=new ArrayList(party.actors);
			//				battleScene.setupParty(party);
			//				battleScene.setup();
			/* party.bag.gainItemById(1,2);
			party.bag.gainItemById(2,5);
			var actor:rpg.model.Actor=party.actors[0];
			var weapon:EquipItem=db.getWeapon(1);
			for (var i:int=0;i<10;i++){
			weapon=db.getWeapon(1);
			party.bag.gainItem(weapon,1);
			}
			*/
			//actor.change_equip(0, weapon);
			//actor.gain_exp(50);
			
			
			party.bag.gainItemById(1,0);
			party.bag.gainItemById(3,5);
			party.bag.gainItemById(4,5);
			party.bag.gainItemById(5,5);
			party.bag.gainItemById(6,6);
	
			
			
			var hero:Actor=party.leader;
			hero.name="ABC123"
			var eq:EquipItem=DataBase.getInstance().getWeapon(1);
			if(hero.equippable(eq)){
				var slot:uint=hero.empty_slot(eq.etype_id);
				if (slot>=0){
					hero.change_equip(slot,eq);
					
				}
			}else{
				Alert.show("不能装备"+eq);
			}
			
			var eq:EquipItem=DataBase.getInstance().getWeapon(501);
			if(hero.equippable(eq)){
				var slot:uint=hero.empty_slot(eq.etype_id);
				if (slot>=0){
					hero.change_equip(slot,eq);
					
				}
			}else{
				Alert.show("不能装备"+eq);
			}
			
			
			
			
//			var hero2:Actor=ObjUtil.clone(hero) as Actor;
//			hero2.resetObjVar();
			//var hero2:Actor=ObjUtil.clone(hero,true) as Actor;
//			hero2.name=hero2.name+"CLONE"
//			party.actors[0]=hero2;
//			hero2.result
//			hero2.add_buff(1,2);
//			//	party=null;
//			party=ObjUtil.clone(party) as Party;
//			trace("clone:"+hero2 +"==="+hero2.name+hero2.mhp);
			
		
		}
		
		
		
	}
}