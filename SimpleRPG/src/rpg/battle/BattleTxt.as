package rpg.battle
{
	public final class BattleTxt
	{
		 
		//# 战斗基本信息
		public static const Emerge   :String= "{0}出现了！"
		public static const Preemptive      :String= "{0}先发制人！"
		public static const Surprise        :String= "{0}被偷袭了！"
		public static const EscapeStart     :String= "{0}准备撤退！"
		public static const EscapeFailure   :String= "但是被包围了……"
		
		//# 战斗结束信息
		public static const Victory         :String= "{0}胜利了！"
		public static const Defeat          :String= "{0}全灭了……"
		public static const ObtainExp       :String= "获得了{0}点经验值！"
		public static const ObtainGold      :String= "获得了{0}\\G！"
		public static const ObtainItem      :String= "获得了{0}！"
		public static const LevelUp         :String= "{0}已经{0}{0}了！"
		public static const ObtainSkill     :String= "领悟了{0}！"
		
		//# 物品使用
		public static const UseItem         :String= "{0}使用了{0}！"
		
		//# 关键一击
		public static const Critical :String= "会心一击！"
		//public static const CriticalToEnemy :String= "关键一击！"
		//public static const CriticalToActor :String= "痛恨一击！"
		
		//# 角色对象的行动结果
		public static const ActorDamage     :String= "{0}受到了{0}点的伤害！"
		public static const ActorRecovery   :String= "{0}的{0}恢复了{0}点！"
		public static const ActorGain       :String= "{0}的{0}恢复了{0}点！"
		public static const ActorLoss       :String= "{0}的{0}失去了{0}点！"
		public static const ActorDrain      :String= "{0}的{0}被夺走了{0}点！"
		public static const ActorNoDamage   :String= "{0}没有受到伤害！"
		public static const ActorNoHit      :String= "失误！{0}毫发无伤！"
		
		//# 敌人对象的行动结果
		public static const EnemyDamage     :String= "{0}受到了{0}点的伤害！"
		public static const EnemyRecovery   :String= "{0}的{0}恢复了{0}点！"
		public static const EnemyGain       :String= "{0}的{0}恢复了{0}点！"
		public static const EnemyLoss       :String= "{0}的{0}失去了{0}点！"
		public static const EnemyDrain      :String= "{0}的{0}被夺走了{0}点！"
		public static const EnemyNoDamage   :String= "{0}没有受到伤害！"
		public static const EnemyNoHit      :String= "失误！{0}毫发无伤！"
		
		//# 回避／反射
		public static const Evasion         :String= "{0}躲开了攻击！"
		public static const MagicEvasion    :String= "{0}抵消了魔法效果！"
		public static const MagicReflection :String= "{0}反射了魔法效果！"
		public static const CounterAttack   :String= "{0}进行反击！"
		public static const Substitute      :String= "{0}代替{0}承受了攻击！"
		
		//# 能力强化／弱化
		public static const BuffAdd         :String= "{0}的{0}上升了！"
		public static const DebuffAdd       :String= "{0}的{0}下降了！"
		public static const BuffRemove      :String= "{0}的{0}恢复了！"
		
		//# 技能或物品的使用无效时
		public static const ActionFailure   :String= "对{0}无效！"
	}
}