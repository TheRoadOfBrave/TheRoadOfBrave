package mk
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	/**
	 * Object 工具类.
	 * @author Jack
	 * Email:  lovewqcm520@gmail.com
	 */
	public class ObjUtil0
	{
		private static var aliasList:Array = [];
		
		/**
		 * 复制一个对象
		 * @param sourceObj	要复制的源对象
		 * @param deep		是否对对象进行AMF序列化以后再深度复制
		 * @return 
		 */
		public static function clone(sourceObj:*, deep:Boolean=true):*
		{
			if(!sourceObj)
				return null;
			
			var lastTime:Number = getTimer();
			
			if(deep)
			{
				// 得到  sourceObj的类名
				var qualifiedClassName:String = getQualifiedClassName(sourceObj);
				if(aliasList.indexOf(qualifiedClassName) == -1)
				{
					// e.g  com.gdlib.test::RegisterClassAliasTest
					var packageName:String = qualifiedClassName.replace("::", ".");
					// 得到 sourceObj的类的类定义
					var classType:Class = getDefinitionByName(qualifiedClassName) as Class;
					// 注册此别名和类
					if(classType)
					{
						registerClassAlias(packageName, classType);
						aliasList.push(qualifiedClassName);
						trace("register class", packageName);
					}
					
					// 注册类公共属性(如果是复合类)
					registerVariables(sourceObj);
				}
			}
			
			// 复制此对象
			var b:ByteArray = new ByteArray();
			b.writeObject(sourceObj);
			b.position = 0;
			
			trace("Clone object takes", getTimer()-lastTime, "ms.\n");
			return b.readObject();
		}
		
		/**
		 * 注册某个类的公共属性(如果是复合类)所属的类的别名.
		 * @param sourceObj
		 */
		public static function registerVariables(sourceObj:*):void
		{
			// 注册类公共属性(如果是复合类)
			var xml:XML = describeType(sourceObj);
			var variable:XML;
			var variableType:String;
			var variablePackageName:String;
			var variableClassType:Class;
			
			var variableXml:XMLList;
			if(sourceObj is Class)
				variableXml = xml.factory.variable;
			else
				variableXml = xml.variable;
			
//			<variable name="point" type="flash.geom::Point">
//				<metadata name="__go_to_definition_help">
//				  <arg key="pos" value="209"/>
//				</metadata>
//			</variable>
			
//			<variable name="name" type="String">
//				<metadata name="__go_to_definition_help">
//				  <arg key="pos" value="142"/>
//				</metadata>
//			  </variable>
				
			for each (variable in variableXml) 
			{
				variableType = variable.@type;
				if(variableType.indexOf("::") != -1)
				{
					if(aliasList.indexOf(variableType) == -1)
					{
						// "flash.geom::Point"	转换为 	"flash.geom.Point"
						variablePackageName = variableType.replace("::", ".");
						variableClassType = getDefinitionByName(variableType) as Class;
						// 注册此别名和类
						if(variableClassType)
						{
							registerClassAlias(variablePackageName, variableClassType);
							registerVariables(variableClassType);
							aliasList.push(variableType);
							trace("register variable", variablePackageName);
						}
					}
				}
			}
		}	
		
	}
}