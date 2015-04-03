package mk.util
{
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	public final class ObjUtil
	{
		
		public static function isSimple(value:Object):Boolean
		{
			var type:String = typeof(value);
			switch (type)
			{
				case "number":
				case "string":
				case "boolean":
				{
					return true;
				}
					
				case "object":
				{
					return (value is Date) || (value is Array);
				}
			}
			
			return false;
		}
		
		
		
		private static function regtype(tn:String):void {
			if (tn == null || tn == "null" || tn == "int" || tn == "string" || tn == "Number" || tn == "String" || tn == "Boolean" || tn == "Object")return;
			var type:Class;
			try {
				type = getClassByAlias(tn);
			} catch(err:Error) {
			}
			if (type != null)return;
			try {
				type = Class(getDefinitionByName(tn));
			} catch(err:Error) {
				return;
			}
			if (type == null)return;
			registerClassAlias(tn, type);
			trace("registerClass("+type+");");
		}
		
		public static function registerClass(cls:Class):*
		{
			var className:String=getQualifiedClassName(cls);
			registerClassAlias(className,cls);
		}
		
		public static function registerComplexClass(source:*):void {
			var tn:String = getQualifiedClassName(source);
			regtype(tn);
			if(tn=="Array"||tn=="flash.utils::Dictionary"){
				for(var ele:String in source){
					registerComplexClass(source[ele]);
				}
			}
			//	if (isSimple(source)) return;
			var dxml:XML = describeType(source);
			if (dxml){
				for each(var acc:XML in dxml.accessor) {
					if (acc.@access=="writeonly") continue;
					registerComplexClass(source[acc.@name]);
				}
				for each(var acc1:XML in dxml.variable) {
					registerComplexClass(source[acc1.@name]);
				}
				for each(var acc2:XML in dxml.implementsInterface) {
					regtype(acc2.@type);
				}
				regtype(dxml.extendsClass.@type);
			}
			
		}
		
		public static function readFromBytes(bytes:ByteArray):*
		{
			return bytes;
		}
		
		public static function toBytes(obj:Object):ByteArray
		{
			var bytes:ByteArray=new ByteArray();
			bytes.writeObject(obj);
			bytes.position=0;
			return bytes;
		}
		
		public static function clone(source:*):* {
			
			registerComplexClass(source);
			var copier:ByteArray = new ByteArray();
			copier.writeObject(source);
			copier.position = 0;
			
			return copier.readObject();
		}
		
		public static function copy(value:Object):Object
		{
			var buffer:ByteArray = new ByteArray();
			buffer.writeObject(value);
			buffer.position = 0;
			var result:Object = buffer.readObject();
			return result;
		}
		
		
	}
}