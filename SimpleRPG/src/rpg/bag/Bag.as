package rpg.bag
{
	import flash.events.Event;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.List;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	import rpg.events.ItemEvent;
	import rpg.model.Actor;
	import rpg.model.BattleFormula;
	import rpg.model.Party;
	import rpg.view.irender.BagItemRender;
	import rpg.vo.IPackItem;
	import rpg.vo.Item;
	
	import skins.EqListSkin;
	
	public class Bag extends Group
	{
		private var party:Party
		private var itemList:List;
		private var itemArrc:ArrayCollection;
		private var item:Item;
		public function Bag()
		{
			init();
		}
		
		private function init():void
		{
			party=Party.getInstance();
			itemList=new List;
			itemList.width=450;
			itemList.height=60;
			itemList.skinName=EqListSkin;
			itemList.itemRenderer=BagItemRender;
			var layout:HorizontalLayout = new HorizontalLayout;
			layout.gap = 24;
			layout.horizontalAlign = HorizontalAlign.CONTENT_JUSTIFY;
			itemList.layout = layout;
			itemList.addEventListener(ItemEvent.USE,useItemHandler);
			addElement(itemList);
			
		}
		
		protected function useItemHandler(event:ItemEvent):void
		{
			
			item=event.item as Item;
			if (usable(item)){
				use_item(item);
			}else{
				item=null;
			}
		}
		
		public function setBag(items:ArrayCollection):void{
			itemArrc=items;
			itemList.dataProvider=itemArrc;
		}
		
		
		public function get user():Actor{
			var actor:Actor=Party.getInstance().actors[0];
			
			return actor;
		}
		
		/**
		 * 
		# ● 确定物品
		 * @param item
		 * 
		 */
		public function  determine_item(item:Item):void{
			if (item.isForFriend){
//				show_sub_window(@actor_window)
//				@actor_window.select_for_item(item)
			}else{
				use_item(item);
				//activate_item_window
			}
		}
		
		private function use_item(item:Item):void
		{
			play_se_for_item();
		//	user.use_item(item)
			use_item_to_actors(item);
//			check_common_event
//			check_gameover
			updateItem(item);
		}		
		
		
		/**
		 * 
			# ● 判定物品是否可以使用
		 * @return 
		 * 
		 */
		public function  usable(item:Item):Boolean{
			return user.usable(item) && item_effects_valid(item);
		}
			
		/**
		 *  ● 判定物品的效果是否有效
		 * @param item
		 * @return 
		 * 
		 */
		public function  item_effects_valid(item:Item):Boolean{
			//任何一个条件为真 返回
			for each (var target:Actor in item_target_actors) 
			{
				if (BattleFormula.getInstance().item_test(user,target,item))
					return true;
			}
			
			return false;
		}
		
		
		/**
		 * 
			# ● 对角色使用物品
		 * @param item
		 * 
		 */
		public function use_item_to_actors(item:Item):void{
			for each (var target:Actor in item_target_actors) 
			{
				BattleFormula.getInstance().item_apply(user,target,item);
			}
			
		}
		
		public function get item_target_actors():Array{
			if (!item.isForFriend){
				return [];
			}else if (item.isForAll){
				return party.members;
			}else{
				return [user];
			}
				
			
		}
		
	/*	#--------------------------------------------------------------------------
			# ● 技能／使用物品
		#    对使用目标使用完毕后，应用对于使用目标以外的效果。
		#--------------------------------------------------------------------------
			def use_item(item)
		pay_skill_cost(item) if item.is_a?(RPG::Skill)
		consume_item(item)   if item.is_a?(RPG::Item)
		item.effects.each {|effect| item_global_effect_apply(effect) }
		end*/
		/**
		 * 
			# ● 消耗物品
		 */
		public function  consume_item(item:Item):void{
			party.consume_item(item);
		}
		//			#--------------------------------------------------------------------------
		//				# ● 应用对于使用目标以外的效果
		//			#--------------------------------------------------------------------------
		//				def item_global_effect_apply(effect)
		//			if effect.code == EFFECT_COMMON_EVENT
		//			$game_temp.reserve_common_event(effect.data_id)
		//			end
		//			end
		
		
		
		
		
		
		private function updateItem(item:Item):void
		{
			itemArrc.itemUpdated(item);
		}
		
		private function play_se_for_item():void
		{
			// TODO Auto Generated method stub
			
		}		
		
		
	}
}