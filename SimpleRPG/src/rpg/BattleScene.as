package rpg
{
	import com.greensock.TweenLite;
	
	import flash.display.Scene;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.events.CloseEvent;
	import mx.events.DynamicEvent;
	
	import org.flexlite.domUI.components.Button;
	
	import rpg.battle.control.ActionMediator;
	import rpg.battle.control.ActionPlayControler;
	import rpg.battle.control.ActorCommandMediator;
	import rpg.battle.control.BattleStageMediator;
	import rpg.battle.event.BattleEvent;
	import rpg.battle.event.ScriptCmdEvent;
	import rpg.battle.view.ActorWindowBox;
	import rpg.battle.view.BattleStage;
	import rpg.battle.view.BattleView;
	import rpg.battle.view.SkillWindow;
	import rpg.events.SceneEvent;
	import rpg.model.Actor;
	import rpg.model.BattleModel;
	import rpg.model.Battler;
	import rpg.model.GameInterpreter;
	import rpg.model.MonsterTroop;
	import rpg.model.Party;
	import rpg.view.WinWindow;
	import rpg.vo.IPackItem;
	import rpg.vo.PackVo;
	import rpg.vo.Skill;
	
	
	/**
	 *管理整个战斗相关的场景 
	 * 
	 */
	public class BattleScene 
	{
		
		
		private var model:BattleModel
		public var view:BattleView;
		private var cmdMediator:ActorCommandMediator;
		//private var battleStageMediator:BattleStageMediator;
		private var actDisplayer:ActionMediator;
		
		//private var winWindow:WinWindow;
		
		public var interpreter:GameInterpreter;
		public var scripts:Array;
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		public function BattleScene()
		{
			init();
		}
		
		
		
		private function init():void{
			initModel()
			initView();
			
			initControler();
			view.addEventListener(Event.ENTER_FRAME,update);
			
		}
		
		
		
		private function initModel():void{
			model=BattleModel.getInstance();
			interpreter=new GameInterpreter();
		}
		
		
		private function initView():void{
			view=new BattleView();
			//view.msgWindow.visible=false;
//			view.init();
//			winWindow=view.winWindow;
//			view.msgWindow.addEventListener(MouseEvent.CLICK,clickMsg)
//			winWindow.addEventListener(MouseEvent.CLICK,clickWindow);
//			
		
		}
		
		private function initControler():void{
			model.addEventListener(BattleModel.START_PARTY_COMMAND,startPartyCmd);
			model.addEventListener(BattleModel.START_ACTOR_COMMAND_SELECTION,next_command);
			
			
			cmdMediator=new ActorCommandMediator(view,model);
			//			cmdMediator.addEventListener(ActorCommandMediator.START_SELECT_SKILL,showSkillWindow);
			actDisplayer=new ActionMediator(view,model);
			
			model.addEventListener(BattleModel.SELECT_ENEMY,selectEnemy);
			model.addEventListener(BattleModel.SELECT_ACTOR,selectActor);
			
			model.addEventListener(BattleModel.TURN_STAR,startMainHandler);
			model.addEventListener(BattleModel.TURN_STAR,process_event);
			model.addEventListener(BattleModel.END_ACTION,process_battle_event);
			model.addEventListener(BattleModel.TURN_END,process_event);
			model.addEventListener(BattleModel.WIN,win);
			model.addEventListener(BattleModel.GAME_OVER,gameOver);
			
			//			view.resultbox.addEventListener(Event.CLOSE,closeResult);
			//			view.partyCmdWnd.addEventListener(MouseEvent.CLICK,doPartyHandler);
			//			view.zoneCmdWnd.addEventListener(MouseEvent.CLICK,doHandler);
			//			
			interpreter.addEventListener(ScriptCmdEvent.EXE_COMMAND,exeScriptCommand);
			interpreter.addEventListener(ScriptCmdEvent.END_COMMAND,endScriptCommand);
			
		}
		
		public function dispatch(event:Event):void{
			dispatcher.dispatchEvent(event);
		}
		
		/**
		 *进入战斗前，给其他模块调用 
		 * 
		 */		
		public function setup():void{
			//battleStage.bg.source=Cache.getBackground(5);
			if (model.party==null){
				
				model.setupParty(Party.getInstance());
				
			}
			
			//	actorWindows.setActors(model.party.members);
			if (model.cpuTroop){
				scripts=DataBase.getTroopEvents(model.cpuTroop.troopId);
				battleStage.createFriends(model.party);
				battleStage.createEnemies(model.cpuTroop);
				//				view.actorWindows2.setActors(model.cpuTroop.members);
				//				view.partyCmdWnd.visible=true;
				//				view.zoneCmdWnd.visible=false;
				battle_start();
				
				next_command();
			}else{
				//				view.zoneCmdWnd.visible=true;
				//				view.partyCmdWnd.visible=false;
				//				view.zoneCmdWnd.setCmdBtns(["前  进","回  城"]);
			}
			
		}
		
		public function reset():void{
			view.reset();
		}
		
		public function setupParty(party:Party):void{
			model.setupParty(party);
		}
		
		public function setupTroop(troop:MonsterTroop):void{
			model.setupEnemyTroop(troop);
		}
		
		
		
		private function get battleStage():BattleStage{
			return view.battleStage;
		}
		
		
		
		
		
		private function sendEvent(eventName:String,obj:Object=null):void{
//			var event:Event;
//			if (obj){
//				var dyEvent:DynamicEvent=new DynamicEvent(eventName);
//				
//				dyEvent.obj=obj;
//				event=dyEvent;
//			}else{
//				event=new Event(eventName);
//			}
//			
//			//dispatchEvent(event);
//			dispatch(event);
		}
		
		public function battle_start():void{
			model.battle_start();
		//	process_event
			
			//不主动调用 通知启动
			
		}
		
		protected function clickWindow(event:MouseEvent):void
		{
//			if (event.target==winWindow.learn_btn){
//				//sendEvent(FINISH_BATTLE);
//			}else if (event.target==winWindow.exit_btn){
//				
//				//view.closeWinWindow();
//				model.reset();
//				view.reset();
//				//sendEvent("next");
//			}
			
		}
		
		protected function clickMsg(event:MouseEvent):void
		{
			if (model.in_battle==false){
				//view.showWinWindow();
			}
			
		}
		
		
		
		protected function doHandler(event:MouseEvent):void
		{
			
			var btn:Button=event.target as Button;
			if (null==btn)return;
			
			var evt:SceneEvent=new SceneEvent(SceneEvent.ACTION,WindowConst.SCENE_ZONE);
			
			switch(btn.id){
				case "btn1":
					//battleStage.playChangeStage();
					evt.action=1;
					
					break;
				case "btn2":
					evt.action=2;
					
					break;
				case "btn3":
					evt.action=3;
					
					break;
				
			}
			
			//dispatch(evt);
		}		
		
		protected function doPartyHandler(event:MouseEvent):void
		{
			var btn:Button=event.target as Button;
			if (null==btn)return;
			//partyCmd(btn.id);
		}
		
		private function partyCmd(id:String):void{
			
			switch(id){
				case "btn1":
					//battleStage.playChangeStage();
					if (model.in_battle){
						//view.partyCmdWnd.visible=false;
						next_command();
						return ;
					}
				case "btn2":
					var success:Boolean=model.process_escape();
					if (false==success){
						turn_start();
					}else{
						model.party.on_battle_end();
						model.cpuTroop=null;
						//dispatch(new SceneEvent(SceneEvent.GOTO,WindowConst.SCENE_ZONE));
						
					}
					break;
				
			}
			
		}
		
		protected function endScriptCommand(event:Event):void
		{
			if (resume != null)
				resume();
		}
		
		protected function exeScriptCommand(event:Event):void
		{
			dispatch(event);
		}
		
		private function process_battle_event(event:Event=null):void{
			if (interpreter.running){
				interpreter.next();
			}else{
				dispatch(new BattleEvent(BattleEvent.PROCESS_EVENT));
				
			}
		}
		
		private function process_event(event:Event=null):void{
			resume=next_command;
			dispatch(new BattleEvent(BattleEvent.PROCESS_EVENT));
		}
		public var resume:Function;
		private function startPartyCmd(evt:Event=null):void{
			//process_event();
//			view.msgWindow.visible=false;
//		
//			view.msgWindow.clear();
//			
			if (model.turn==0){
				//可以选择战斗 或 逃跑
			//	view.partyCmdWnd.visible=true;
			}else{
			//事件执行完回调	
				next_command();
			}
			//默认选择了 队伍命令 战斗
			
		}
		
		/**
		 *事件执行完 根据model 状态阶段 执行下一步流程 
		 * @param evt
		 * 
		 */
		private function next_command(evt:Event=null):void{
//			if (model.phase==4){
//				model.process_battle()
//			}else	if (model.isTurnEnd){
//				model.start_party_command_selection();
//				view.msgWindow.visible=false;
//				view.msgWindow.clear();
//				model.phase=1;
//				if (true||model.turn==0){
//					//可以选择战斗 或 逃跑
//					view.partyCmdWnd.visible=true;
//				}else if (model.nextActor()){
//					//	start_actor_command_selection 开始选择角色命令
//					
//					view.showCommandWindow(model.actorIndex);
//				//	model.activeBattler.action.setAttack()
//					//事件执行完回调	next_command()
//					//view.showCommandWindow(model.actorIndex);
//				}
			if (model.phase==4){
				//战斗进行中
				model.process_battle()
			}else if(model.isTurnEnd){
				//一个回合结束
				model.start_party_command_selection();
			}else if (model.nextActor()){
			//	start_actor_command_selection 开始选择角色命令
				
				view.showCommandWindow();
				var skills:Array=model.activeBattler.skills.concat();
				var arr:Array=[]
				var atk:Skill=DataBase.getInstance().getSkill(1);
				var g:Skill=DataBase.getInstance().getSkill(2);
				skills=skills.concat(atk,g);
				view.cmdWindow.showCmdBtns(skills);
			//	model.activeBattler.action.setAttack()
			}else{
				
				turn_start();
			}
		}
		
		private function turn_start():void{
//			@party_command_window.close
//				@actor_command_window.close
//				@status_window.unselect
//				@subject =  nil
				model.turn_start();
		//		force_action(1,1,1,1);
//				@log_window.wait
//				@log_window.clear
		}
		
		
		private function startMainHandler(evt:Event):void{
			view.hideCommandWindow();
		}
		
		
		private function win(evt:Event):void{
//			view.msgWindow.visible=true;
//			view.msgWindow.clear();
//			view.msgWindow.showMsg("打倒了敌人，玩家胜利！\nclick...")
//			showWinResult();
			
		}
		
		private function gameOver(evt:Event):void{
//			view.msgWindow.visible=true;
//			view.msgWindow.clear();
//			view.msgWindow.showMsg("团队全灭，游戏结束！")
//			
		}
		
		
		private function selectEnemy(evt:Event):void{
		//	view.battleStage.canSelectEnemys(true);
			
		}
		
		private function selectActor(evt:Event):void{
		//	view.actorWindows.canSelect(true);
			
		}
		
		
		
		
		
		
		
		
		public function showWinResult():void{
			var troop:MonsterTroop=model.cpuTroop;
			var gold:uint=troop.gold_total();
			var exp:uint=troop.exp_total();
			var items:Array=troop.make_drop_items();
			var party:Party=model.party;
			party.members.forEach(gainExp);
			function gainExp(actor:rpg.model.Actor, index :int, arr :Array):void{
				actor.gain_exp(exp);
			}
			//view.msgWindow.showMsg("掉落金钱："+gold);
			//view.msgWindow.showMsg("获得经验："+exp);
			TweenLite.delayedCall(2,showDrops,[gold,items]);
	
		}
		
		private function showDrops(gold:uint,items:Array):void{
			view.showResultBox(items);
		}
		
		/**
		 *关闭战斗结束 掉落的窗口 
		 * @param event
		 * 
		 */
		protected function closeResult(event:Event):void
		{
			view.hideResultBox();
//			var items:Array=view.resultbox.arrList.source;
//			var gold:uint=0;
//			items.forEach(
//				function (obj:Object, index :int, arr :Array):void{
//						var item:IPackItem=obj.item;
//					if (!obj.sell){
//						model.party.gain_item(item,item.num);
//					}else{
//						gold+=item.price;
//					}
//				}
//			)
//			model.party.gold+=gold;
//			
//			
//			model.reset();
//			view.reset();
//			dispatch(new BattleEvent(BattleEvent.FINISH));
			//model.party.gain_item();
		}
		
		private function update(event:Event):void{
		//	battleStage.update();
		//	actDisplayer.update();
		}
		
		/**
		 *强制执行 技能 
		 * @param param0 0 则敌人、1 则角色
		 * @param param1 敌人的索引 或 角色的 ID
		 * @param param2 技能ID
		 * @param param3 技能目标
		 * 
		 */
		public function force_action(param0:int, param1:int, skill:int, index:int):void
		{
			var battler:Battler;
			if (param0==0){
				battler=model.party.members[param1];
			}else{
				 battler=model.cpuTroop.members[param1];
			}
			if (battler==null){
				trace("找不到强制行动者 无法执行强制行动！");
				return;
			}
			battler.isAddAction=true;
			battler.force_action(skill,index);
			model.force_action(battler);
			model.process_forced_action();
		}
		
		public function dispose():void{
			view.dispose();
		}
		
	}
}