package rpg.model
{
	import com.adobe.utils.ArrayUtil;
	
	import rpg.DataBase;
	import rpg.vo.BaseItem;
	import rpg.vo.EquipItem;
	import rpg.vo.Feature;
	import rpg.vo.RpgState;

	public class BattlerBase
	{
		//# 属性抗性
		public static const FEATURE_ELEMENT_RATE  :uint = 11              
			//# 弱化抗性
		public static const FEATURE_DEBUFF_RATE   :uint = 12              
			//状态抗性
		public static const FEATURE_STATE_RATE    :uint = 13             
			//状态免疫
		public static const FEATURE_STATE_RESIST  :uint = 14              
			//普通能力
		public static const FEATURE_PARAM         :uint = 21              
			
		/**
		 * 附加加能力 必杀率
		 */
		public static const FEATURE_XPARAM        :uint = 22              
			//特殊能力
		public static const FEATURE_SPARAM        :uint = 23             
			
		public static const FEATURE_ATK_ELEMENT   :uint = 31              //攻击附带属性
		public static const FEATURE_ATK_STATE     :uint = 32              //攻击附带状态
		public static const FEATURE_ATK_SPEED     :uint = 33              //修正攻击速度
		public static const FEATURE_ATK_TIMES     :uint = 34              //添加攻击次数
		public static const FEATURE_STYPE_ADD     :uint = 41              //添加技能类型
		public static const FEATURE_STYPE_SEAL    :uint = 42              //禁用技能类型
		public static const FEATURE_SKILL_ADD     :uint = 43              //添加技能
		public static const FEATURE_SKILL_SEAL    :uint = 44              //禁用技能
		public static const FEATURE_EQUIP_WTYPE   :uint = 51              //可装备武器类型
		public static const FEATURE_EQUIP_ATYPE   :uint = 52              //可装备护甲类型
		public static const FEATURE_EQUIP_FIX     :uint = 53              //固定装备
		public static const FEATURE_EQUIP_SEAL    :uint = 54              //禁用装备
		public static const FEATURE_SLOT_TYPE     :uint = 55              //装备风格
		public static const FEATURE_ACTION_PLUS   :uint = 61              //添加行动次数
		public static const FEATURE_SPECIAL_FLAG  :uint = 62              //特殊标志
		public static const FEATURE_COLLAPSE_TYPE :uint = 63              //消失效果
		public static const FEATURE_PARTY_ABILITY :uint = 64              //队伍能力
			//-------------------------------------------------------------------------
			// ● 常量（特殊标志）
		//-------------------------------------------------------------------------
		public static const	FLAG_ID_AUTO_BATTLE:uint   = 0               // 自动战斗
		public static const FLAG_ID_GUARD :uint        = 1               // 擅长防御
		public static const FLAG_ID_SUBSTITUTE :uint   = 2               // 保护弱者
		public static const FLAG_ID_PRESERVE_TP:uint   = 3               // 特技专注 
		 	//--------------------------------------------------------------------------
			// ● 常量（能力强化／弱化图标的起始编号）
			//--------------------------------------------------------------------------
		public static const	ICON_BUFF_START:uint       = 64              // 强化（16 个）
		public static const	ICON_DEBUFF_START:uint     = 80              // 弱化（16 个）
			
			
		protected var _hp:int ;                      
		protected var _mp:int;    
		protected var _tp:int;    
		
		public var hidden :Boolean;
		// 不死身标志
		public var immortal:Boolean ;                
		
		
		//状态ID数组			
		public var stateIdArr:Array;  
		//已存在状态ID
		public var remainedStateId_arr:Array;  
		//新添加的状态ID
		public var addedStateId_arr:Array; 
		//移除的状态ID
		public var removedStateId_arr:Array
		protected var state_steps :Object = {}  
		protected var state_turns:Object = {}  
		protected var db:DataBase=DataBase.getInstance();
		protected var _param_plus:Array;
		/**
		 *对应各项属性 ，1表示加强 -1弱化 
		 */
		public var buffs:Array;
		protected var _hidden:Boolean;
		protected var buff_turns:Object;
		
		public function BattlerBase()
		{
			_hp=_mp=_tp=0;
			_hidden = false
			clear_param_plus();
			clear_states();
			clear_buffs();
		}

		/**
		# ● 各种能力值的简易访问方法
		 * 
		 */
		/**最大HP  */		
		public function get mhp():Number  {return param(0)}   
		/**最大MP    */		
		public function get mmp():Number  {return param(1)}  
		/**物理攻击  */		
		public function get atk():Number  {return param(2)  }      
		/**物理防御     */		
		public function get def():Number  {return param(3)}         
			/**魔法攻击    Magic ATtack power*/		
		public function get mat():Number  {return param(4)}          
		/**魔法防御  */		
		public function get mdf():Number  {return param(5)}            
			/**敏 捷 值  AGIlity */		
		public function get agi():Number  {return param(6)}           
		/**幸 运 值   LUcK*/		
		public function get luk():Number  { return param(7)}           
		/**成功几率 HIT rate*/		
		public function get hit():Number  { return xparam(0)}           
	/**闪避几率 EVAsion rate*/		
		public function get eva():Number  { return xparam(1)}           
/**必杀几率 CRItical rate*/		
		public function get cri():Number  { return xparam(2)}           
/**闪避必杀几率    Critical EVasion rate*/		
		public function get cev():Number  { return xparam(3)}     
/** 闪避魔法几率 Magic EVasion rate */		
		public function get mev():Number  { return xparam(4)}      
/**反射魔法几率  Magic ReFlection rate*/		
		public function get mrf():Number { return  xparam(5)}       
/**反击几率  CouNTer attack rate*/		
		public function get cnt():Number  { return xparam(6)}          
/**HP再生速度  Hp ReGeneration rate*/		
		public function get hrg():Number  { return xparam(7)}         
/**MP再生速度  Mp ReGeneration rate */		
		public function get mrg():Number  { return xparam(8)}        
/** TP再生速度 Tp ReGeneration rate*/		
		public function get trg():Number  { return xparam(9)}        
/**受到攻击的几率  TarGet Rate*/		
		public function get tgr():Number  { return sparam(0)}           
/** 防御效果比率  GuaRD effect rate*/		
		public function get grd():Number  { return sparam(1)}     
/**恢复效果比率  RECovery effect rate */		
		public function get rec():Number  { return sparam(2)}      
/**药理知识  PHArmacology*/		
		public function get pha():Number  { return sparam(3)}           
/**MP消费率  Mp Cost Rate */		
		public function get mcr():Number  { return sparam(4)}          
/** TP消耗率  Tp Charge Rate*/		
		public function get tcr():Number  { return sparam(5)}          
/**物理伤害加成  */		
		public function get pdr():Number  { return sparam(6)}  
/**魔法伤害加成    */		
		public function get mdr():Number  { return sparam(7)}  
/**地形伤害加成 */		
		public function get fdr():Number  { return sparam(8)}  
/**经验获得加成 */		
		public function get exr():Number  { return sparam(9)}  
		
		
		
		private function param_min(param_id:uint):int
		{//# MMP
			if (param_id == 1)				return 0;
			return 1;
		}
		
		private function param_max(param_id:uint):int
		{
			if (param_id == 0)				return 9999;
			if (param_id == 1)				return 999;
			return 999;
		}
		
		
		/**
		 * 获取普通能力的变化率
		 * @param param_id
		 * @return 
		 * 
		 */		
		private function param_rate(param_id:uint):Number
		{
			
			return features_pi(FEATURE_PARAM, param_id);
		}
		/**
		 *获取普通能力的强化／弱化变化率 
		 * @param param_id
		 * @return 
		 * 
		 */		
		private function param_buff_rate(param_id:uint):Number
		{
			return buffs[param_id] * 0.25 + 1.0;
		}
		
		public  function param_plus(param_id:uint):int
		{
			return _param_plus[param_id];
		}
		
		public function param_base(param_id:uint):int
		{
			return 0;
		}
		
		public function param(param_id:uint):Number{
			var value:int = param_base(param_id) + param_plus(param_id)
			value *= param_rate(param_id) * param_buff_rate(param_id)
			value=Math.min(value,param_max(param_id));
			value=Math.max(value,param_min(param_id));
			return value;
		}
		
		/**
		 * 
		# ● 获取添加能力
		 */
			public function  xparam(xparam_id:uint):Number{
				return 	features_sum(FEATURE_XPARAM, xparam_id); 

			}
		/**
		 * 
		# ● 获取特殊能力
		 */
			public function sparam(sparam_id:uint):Number{
				return features_pi(FEATURE_SPARAM, sparam_id)
				
			}
			
			/**清除能力的增加值			 */		
			public function clear_param_plus():void{
				_param_plus = [0,0,0,0,0,0,0,0];
			}
		
		
		/**
			 * 
		# ● 清除状态信息
			 * 
			 */			
			public function clear_states():void{
				stateIdArr = []
				state_turns = {}
				state_steps = {}
			}

		/**
			 * 
			# ● 消除状态
			 * @param state_id
			 * @return 
			 * 
			 */			
			public function erase_state(state_id:int):void{
			//	delete states[state_id];
				ArrayUtil.removeValueFromArray(stateIdArr,state_id);
				delete state_turns[state_id];
				delete state_steps[state_id];
				
			}

		
		/**
			# ● 清除能力强化信息
			 * 
			 */			
			public function clear_buffs():void{
//			@buffs = Array.new(8) { 0 }
//			@buff_turns = {}
				buffs = [0,0,0,0,0,0,0,0];
				buff_turns = {}
					
			}
			
			
			//是否已含有该状态
			public function hasState(state_id:int):Boolean{
				if (stateIdArr.indexOf(state_id)!=-1){
					return true;
				}
				return false;
			}
		
			/**
			 * 
			# ● 检査是否含有无法战斗状态
			 * @return 
			 * 
			 */			
			public function hasDeathState():Boolean{
				return hasState(death_state_id)
			}
			/**
			 * 
			# ● 获取无法战斗的状态ID
			 * 
			 */			
			public function get death_state_id():int{
				return 1
				
			}
			/**
			 * 
			# ● 获取当前状态的实例数组
			 * 
			 */			
			//------------------------获取状态列表数组------------------------------------	
			// 获得状态数组
			public function get states():Array{
				var  result:Array = [];
				for each(var id:int in stateIdArr){
					result.push(db.getState(id));
				}
				
				return result;
			}
		
		
		
		
		/**
		 * 
		# ● 获取所有 拥有特性的实例BaseItem的数组 
		 * 子类包含 自身  武器 物品等
		 */
			public function get feature_objects():Array{
				return states
				
			}

			/**
			 * 
		# ● 获取所有特性实例的数组
			 * @return 
			 * 
			 */			
			public function get all_features():Array{
//				feature_objects.inject([]) {|r, obj| r + obj.features }
				var result:Array=[];
				for each(var obj:BaseItem in feature_objects){
					result=result.concat(obj.features);
				}
				
				return result;
			}

			/**
			 * 
			# ● 获取特性实例的数组（限定特性代码）
			 * @param code
			 * 
			 */			
			public function features(code:int):Array{
			//	all_features.select {|ft| ft.code == code }
				var arr:Array=[];
				for each(var obj:Feature in all_features){
					if (obj.code==code)
					arr.push(obj);
				}
				
				return arr
			}

			/**
		 * 
			# ● 获取特性实例的数组（限定特性代码和数据ID）
		 * @param code
		 * @param id
		 * 
		 */			
		public function features_with_id(code:int, id:int):Array{
				//all_features.select {|ft| ft.code == code && ft.data_id == id }
				var arr:Array=[];
				for each(var ft:Feature in all_features){
					if (ft.code==code&&ft.data_id==id)
						arr.push(ft);
				}
				
				return arr
			}

		/**
			 * 
			# ● 计算特性值的乘积
			 * @param code
			 * @param id
			 * 
			 */			
			public function features_pi(code:int, id:int):Number{
		///	features_with_id(code, id).inject(1.0) {|r, ft| r *= ft.value }
				var arr:Array=features_with_id(code, id)
				var r:Number=1;
				for each(var ft:Feature in arr){
						r*= ft.value ;
				}
				return r;
			}

			/**
		 * 
			# ● 计算特性值的总和（指定数据ID）
		 * @param code
		 * @param id
		 * 
		 */		
		public function features_sum(code:int, id:int):Number{
			//	features_with_id(code, id).inject(0.0) {|r, ft| r += ft.value }
			var arr:Array=features_with_id(code, id)
				var r:Number=0;
				for each(var ft:Feature in arr){
					r+= ft.value ;
				}
				return r;
			}

		/**
		 * 
			# ● 计算特性值的总和（不限定数据ID）
		 * @param code
		 * @return 
		 * 
		 */			
		public function features_sum_all(code:int):Number{
			//	features(code).inject(0.0) {|r, ft| r += ft.value }
				var arr:Array=features(code)
				var r:Number=0;
				for each(var ft:Feature in arr){
					r+= ft.value ;
				}
				return r;
			}

		
		/**
			 * 
			# ● 该类别下 特性ID的集合和计算
			 * @param code 特性类别
			 * 
			 */		
			public function features_set(code:int):Array{
		//		features(code).inject([]) {|r, ft| r |= [ft.data_id] }
				var ft_arr:Array=features(code);
				var set:Array=[]
				for each(var ft:Feature in ft_arr){
					if (set.indexOf(ft.data_id)==-1){
						set.push(ft.data_id);
					}
					
				}
				return set;
			}
		
		
			/**
			# ● 获取属性抗性
			 * 
			 */
				public function element_rate(element_id:uint):Number{
					return features_pi(FEATURE_ELEMENT_RATE, element_id);
				}
				
				
			/**
			 * 
			# ● 获取弱化抗性
			 */
				public function debuff_rate(param_id:uint):Number{
					return features_pi(FEATURE_DEBUFF_RATE, param_id);
					
				}
				/**
				 * 
				# ● 获取状态抗性
				 * @param state_id
				 * @return 
				 * 
				 */
				public function state_rate(state_id:uint):Number{
					return features_pi(FEATURE_STATE_RATE, state_id)
					
				}

				/**
			 * 
			# ● 获取免疫状态数组
			 * @return 
			 * 
			 */
			public function get state_resist_set():Array{
				return features_set(FEATURE_STATE_RESIST);
				
			}

			/**
			# ● 判定状态是否免疫
			 * 
			 */
				public function isStateResist(state_id:uint):Boolean{
					if (state_resist_set.indexOf(state_id)>-1){
						return true;
					}
					return false;
				}
			
		
		
		public function  get atk_elements():Array{
			return features_set(FEATURE_ATK_ELEMENT)
		}
		
		
			/**
			 * ● 获取攻击附加状态
			 */	
		public function get atk_states():Array{
			return features_set(FEATURE_ATK_STATE)
			
		}
		/**
		 * ● 获取攻击附加状态的发动几率 
		 * @param state_id
		 * 
		 */
		public function  atk_states_rate(state_id:int):Number{
			return features_sum(FEATURE_ATK_STATE, state_id)
		}

		/**
		 * 
		# ● 获取修正攻击速度
		 * @return 
		 * 
		 */
		public function atk_speed():Number{
			return features_sum_all(FEATURE_ATK_SPEED)
		}
		/**
		 * ● 获取添加攻击次数
		 * @return 
		 * 
		 */
		public function get atk_times_add():int{
			return Math.max(features_sum_all(FEATURE_ATK_TIMES), 0);
		}
			/**
			 * 
			# ● 获取添加技能类型
			 * @return 
			 * 
			 */
			public function added_skill_types():Array{
				return features_set(FEATURE_STYPE_ADD)
			}


				/**
		 * ● 添加能力
		 * @param param_id
		 * @param value
		 * @return 
		 * 
		 */
		public function add_param(param_id:uint, value:uint):void{
			_param_plus[param_id]+= value
				refresh();
		}
		
		
		
		
		
		public function get hp():Number{
			return _hp
		}
		
		
		public function get mp():Number{
			return _mp
		}
		/**
		 * 更改HP，如果为0,附加上死亡状态
		 * 
		 */
		public function set hp(newhp:Number):void{
			_hp=newhp;
			refresh();
		}
		
		public function set mp(newmp:Number):void{
			_mp=newmp;
			refresh();
		}
		public function set tp(newtp:int):void{
			_tp=Math.max(Math.min(newtp,max_tp),0);
		}
		
		public function get tp():int{
			return _tp;
		}
		
		public function get max_tp():uint{
				return 100;
		}
		
		public function refresh():void{
			for each (var state_id:uint in state_resist_set){
				erase_state(state_id)
			}
				_hp = Math.max(Math.min(_hp,mhp),0)
				
				_mp = Math.max(Math.min(_mp,mmp),0) 
			
		}
		
		/**
		 *  ● 复活并 完全恢复
		 * 
		 */
		public function recover_all():void{
			clear_states();
			_hp = mhp;
			_mp = mmp;
			
		}

		/**
				 * ● 获取 HP 的比率
				 * @return 
				 * 
				 */
				public function get hp_rate():Number{
					return _hp/ mhp
				}
				
			/**
			 * ● 获取 MP 的比率
			 * @return 
			 * 
			 */
			public function get mp_rate():Number{
				return mmp > 0 ? _mp / mmp : 0
			}
			/**
			 *  ● 获取 TP 的比率
			 * @return 
			 * 
			 */
			public function get tp_rate():Number{
				return _tp / 100;
			}

			//-----------------------------------------------------------------------------------------------
		public function hide():void{
			hidden=true;
		}
		
		public function appear():void{
			hidden=false;
		}
		
		//判定是否死亡
		public function get isDead():Boolean{
			return  isExist && hasDeathState();
		}
		
		//存在判定
		public function get isExist():Boolean{
			return !hidden 
		}

		//判定是否存活
		public function get isAlive():Boolean{
			return isExist && !hasDeathState();
		}
		/**
		 * ● 判定是否正常
		 */
		public function get isNormal():Boolean{
			return isExist &&  restriction == 0
		}
		
		
		
			/**
			 * 
			# ● 判定是否可以输入指令
			 * @return 
			 * 
			 */
			public function get inputable():Boolean{
				return isNormal && !isAutoBattle;
			}
				
			/**● 判定是否可以行	 */
			public function get movable():Boolean{
				return isExist && restriction < 4
			}
						
			/**
			 * 
			# ● 判定是否处于混乱
			 * @return 
			 * 
			 */
			public function get isConfusion():Boolean{
				return isExist && restriction >= 1 && restriction <= 3;
			}
			/**
			 * 
			# ● 获取混乱等级
			 * @return 
			 * 
			 */
			public function get confusion_level():int{
				return isConfusion? restriction:0;
			}

		/**
		//判断是否为玩家操控的角色	
		 * ● 判定是否队友
		 * @return 
		 * 
		 */
		public function get isActor():Boolean{
			return false;
		}
		
		/**
		 *● 判定是否敌人 
		 * @return 
		 * 
		 */
		public function get isEnemy():Boolean{
			return false;
		}
		
		
		
		
		
		//----------------------状态判定-------------------------------------------	
		/**
		 # ● 判定技能类型是否被禁用
		 * 
		 * @return 
		 * 
		 */
		public function isSkillTypeSealed(stype_id:uint):Boolean{
			var arr:Array=features_set(FEATURE_STYPE_SEAL)
			if (arr.indexOf(stype_id)>-1){return true}
			return false;
		}
		
		/**
		 * 
		 # ● 获取添加的技能
		 * @return 
		 * 
		 */
		public function added_skills():Array{
			return features_set(FEATURE_SKILL_ADD);
		}
		
		/**
		 # ● 判定技能是否被禁用
		 * 
		 * @return 
		 * 
		 */
		public function isSkillSealed(skill_id:uint):Boolean{
			var arr:Array=features_set(FEATURE_SKILL_SEAL)
			if (arr.indexOf(skill_id)>-1){return true}
			return false;
		}
					/**
					 * 
					# ● 判定武器是否可以装备
					 * @param wtype_id
					 * @return 
					 * 
					 */
					public function equip_wtype_ok(wtype_id:uint):Boolean{
						var arr:Array=features_set(FEATURE_EQUIP_WTYPE)
						if (arr.indexOf(wtype_id)>-1)
							return true
						return false;
						
					}
					/**
					 * ● 判定护甲是否可以装备
					 * @return 
					 * 
					 */
					public function equip_atype_ok(atype_id:int):Boolean{
						var arr:Array=features_set(FEATURE_EQUIP_ATYPE)
						if (arr.indexOf(atype_id)>-1)
							return true
						return false;
					}
					/**
					 * 
					# ● 判定是否固定武器
					 * @param etype_id
					 * @return 
					 * 
					 */
					public function equip_type_fixed(etype_id):Boolean{
						var arr:Array=features_set(FEATURE_EQUIP_FIX)
						if (arr.indexOf(etype_id)>-1)
							return true
						return false;
					}
					/**
					 * 
					# ● 判定装备是否被禁用
					 * @return 
					 * 
					 */
					public function equip_type_sealed(etype_id):Boolean{
						var arr:Array=features_set(FEATURE_EQUIP_SEAL)
						if (arr.indexOf(etype_id)>-1)
							return true
						return false;
					}
		//		#--------------------------------------------------------------------------
		//			# ● 获取装备风格
		//			#--------------------------------------------------------------------------
		//			public function slot_type
		//		features_set(FEATURE_SLOT_TYPE).max || 0
		//		end
		//		#--------------------------------------------------------------------------
		//			# ● 判定是否双持武器
		//			#--------------------------------------------------------------------------
		//			public function dual_wield?
		//				slot_type == 1
		//		end
		//		#--------------------------------------------------------------------------
		//			# ● 获取添加行动次数几率的数组
		//			#--------------------------------------------------------------------------
		//			public function action_plus_set
		//		features(FEATURE_ACTION_PLUS).collect {|ft| ft.value }
		//		end
		
		/**
		 * 
		 # ● 判定特殊标志
		 * @param flag_id
		 * @return 
		 * 
		 */
		public function special_flag(flag_id:uint):Boolean{
			var arr:Array=features(FEATURE_SPECIAL_FLAG)
			return arr.some(hasFt);
			function hasFt(element:*, index:int, arr:Array):Boolean {
				return (element.data_id == flag_id);
			}
		}
		//			#--------------------------------------------------------------------------
		//			# ● 获取消失效果
		//			#--------------------------------------------------------------------------
		//			def collapse_type
		//		features_set(FEATURE_COLLAPSE_TYPE).max || 0
		//		end
		//		#--------------------------------------------------------------------------
		//			# ● 判定队伍能力
		//			#--------------------------------------------------------------------------
		//			def party_ability(ability_id)
		//		features(FEATURE_PARTY_ABILITY).any? {|ft| ft.data_id == ability_id }
		//			end
		/**
		 # ● 判定是否自动战 * */
		public function get isAutoBattle():Boolean{
			return special_flag(FLAG_ID_AUTO_BATTLE)
		}
		//		#--------------------------------------------------------------------------
		//			# ● 判定是否擅长防御
		//			#--------------------------------------------------------------------------
		public function get isGuard():Boolean{
			return special_flag(FLAG_ID_GUARD) && movable;
		}
		
		//防御中判定
		public function get isGuarding():Boolean{
			return false
			//return usable(db.getSkill(guard_skill_id));
		}
		/**
		 # ● 判定是否保护弱者
		 * 
		 * @return 
		 * 
		 */
		public function isSubstitute():Boolean{
			return special_flag(FLAG_ID_SUBSTITUTE) && movable;
		}
		
		/**
		 * 
		 # ● 判定是否特技专注
		 * @return 
		 * 
		 */
		public function isPreserveTp():Boolean{
			return special_flag(FLAG_ID_PRESERVE_TP)
		}

		
		//回避可能判定
		public function get parriable():Boolean{
			return (!hidden && restriction < 5);
		}
		
		//沈默状态判断
		public function get isSilent():Boolean{
			return (!hidden && restriction == 1);
		}
		
		//暴走状态判定
		public function get isBerserker():Boolean{
			return (!hidden && restriction == 2);
		}
		
		
	
		
		
		
		/**
		 * 状态排序
  #    依照优先度排列数组 @states，高优先度显示的状态排在前面。
		 * 
		 */		
		public function sort_states():void{
		//	_states = _states.sort_by {|id| [-$data_states[id].priority, id] }
			
		}
		
		/**
		 *获取限    从当前附加的状态中获取最大的限制
		 * 限制行动（0：无、1：不能使用魔法、2：普通攻击敌人、3：普通攻击同伴、4：不能行动、5：无法行动或回避。） 
		 * 
		 * @return 
		 */		
		public function get restriction():int{
			var restriction_max:int = 0
			for each (var state:RpgState in states){
				if (state.restriction >= restriction_max)
					restriction_max = state.restriction
			}
			
			return restriction_max
		}
		/*#--------------------------------------------------------------------------
			# ● 获取最重要的状态信息
			#--------------------------------------------------------------------------
			def most_important_state_text
		states.each {|state| return state.message3 unless state.message3.empty? }
		return ""
		end*/
		
		
		/*#--------------------------------------------------------------------------
		# ● 检查技能的使用条件
		#--------------------------------------------------------------------------
			def skill_conditions_met?(skill)
		usable_item_conditions_met?(skill) &&
			skill_wtype_ok?(skill) && skill_cost_payable?(skill) &&
			!skill_sealed?(skill.id) && !skill_type_sealed?(skill.stype_id)
		end
		#--------------------------------------------------------------------------
			# ● 检查物品的使用条件
			#--------------------------------------------------------------------------
			def item_conditions_met?(item)
		usable_item_conditions_met?(item) && $game_party.has_item?(item)
		end
		#--------------------------------------------------------------------------
			# ● 判定技能／使用物品是否可用
			#--------------------------------------------------------------------------
			def usable?(item)
		return skill_conditions_met?(item) if item.is_a?(RPG::Skill)
		return item_conditions_met?(item)  if item.is_a?(RPG::Item)
		return false
		end*/
		/**
		 * 
			# ● 判定物品是否可以装备
		 * @param item
		 * @return 
		 * 
		 */
		public function  equippable(item:EquipItem):Boolean{
			if (false==(item is EquipItem)) return false;
			if (equip_type_sealed(item.etype_id)) return false;
			if (item.isWeapon){
				return equip_wtype_ok(item.wtype_id);
			}else if (item.isArmor){
				return equip_atype_ok(item.atype_id);
			}
			return false;
		}
		
		
	}
}