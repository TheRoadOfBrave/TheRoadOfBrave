package mk
{
	import flash.events.IEventDispatcher;
	import flash.net.getClassByAlias;
	import flash.net.ObjUtil.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mk.util.ObjUtil;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.collections.ICollection;
	
	import rpg.model.Actor;
	import rpg.model.BattleAction;
	import rpg.model.Battler;
	import rpg.model.Effector;
	import rpg.model.ItemBag;
	import rpg.model.Party;
	import rpg.script.BattleScript;
	import rpg.script.InnScript;
	import rpg.script.RpgScript;
	import rpg.vo.ActionResult;
	import rpg.vo.ActorVo;
	import rpg.vo.Damage;
	import rpg.vo.Effect;
	import rpg.vo.EquipItem;
	import rpg.vo.Feature;
	import rpg.vo.GameClass;
	import rpg.vo.IPackItem;
	import rpg.vo.Item;
	import rpg.vo.Learning;
	import rpg.vo.Skill;
	import rpg.vo.Talent;
	
	public final class SLFile
	{
		public function SLFile()
		{
			
		}
		
			public static function registerDataClass():void
			{
				ObjUtil.registerClass(Party);
				ObjUtil.registerClass(Array);
				ObjUtil.registerClass(Actor);
				ObjUtil.registerClass(EquipItem);
				ObjUtil.registerClass(IEventDispatcher);
				ObjUtil.registerClass(IPackItem);
				ObjUtil.registerClass(Skill);
				ObjUtil.registerClass(Feature);
				ObjUtil.registerClass(Effect);
				ObjUtil.registerClass(Damage);
				ObjUtil.registerClass(ActorVo);
				ObjUtil.registerClass(XML);
				ObjUtil.registerClass(GameClass);
				ObjUtil.registerClass(BattleAction);
				ObjUtil.registerClass(ActionResult);
				ObjUtil.registerClass(Learning);
				ObjUtil.registerClass(Talent);
				ObjUtil.registerClass(Effector);
				ObjUtil.registerClass(ItemBag);
				ObjUtil.registerClass(ArrayCollection);
				ObjUtil.registerClass(ICollection);
				ObjUtil.registerClass(Item);
				
				
				ObjUtil.registerClass(RpgScript);
				ObjUtil.registerClass(InnScript);
				ObjUtil.registerClass(BattleScript);
				
			}
		
		public static function toBytes(original:Object):ByteArray
		{
			var bytes:ByteArray=new ByteArray();
			bytes.writeObject(original);
			return bytes;
		}
		
		public static function toBagData(bag:ItemBag):Object{
			var arr:Array=bag.items.source;
			for (var i:int = 0; i < arr.length; i++) 
			{
				var item:Item=arr[i];
			}
			
			return arr;
		}
		
		public static function copyBagData(bag:ItemBag,data:Array):ItemBag{
			for (var i:int = 0; i < data.length; i++) 
			{
				var itemObj:Object=data[i];
				bag.gainItemById(itemObj.id,itemObj.num);
				
			}
			return bag;
		}
		
		public static function copyBattlerData(hero:Actor,data:Actor):Battler{
			hero.result=new ActionResult(hero);
			hero.action= new BattleAction(hero);
			for (var i:int = hero.equips.length; i <5; i++) 
			{
				hero.equips[i]=null;
			}
			
			return hero;
		}
		
		
	
		
		
		
	}
}