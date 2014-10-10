package mk.util
{
	public class StrUtil
	{
		public function StrUtil()
		{
		}
		
		public static function replace(str:String, ... rest):String{
			for (var i:int = 0; i < rest.length; i++)
			{
				str =str.replace(new RegExp("\\{"+i+"\\}", "g"), rest[i]);
			}
			return str;
		}
		
		/**
		 *去掉换行符 
		 * 在标签中换行 的换行符是 &#xd; &#xa; &#13;而不是 \n 或 \r；
		 * @param str
		 * @return 
		 * 
		 */
		public static function trimBr(str:String):String{
			str= str.replace(/\r\n/g,"");
			return str;
		}
		
		/**
		 * 换行符合换成<br> 避免空2行
		 * @param str
		 * @return 
		 * 
		 */
		public static function changBr(str:String):String{
			str= str.replace(/\r\n/g,"<br/>");
			str= str.replace(/\r/g,"<br/>");
			str= str.replace(/\n/g,"<br/>");
			return str;
		}
		/**
		 *"FF6600";
			txt = systemChange(txt,16,10); //16转10
			trace(txt); //输出: 16737792
			txt = systemChange(txt,10,8); //10转8
			trace(txt); //输出: 77663000
			txt = systemChange(txt,2,32); //2转32
			trace(txt); //输出: fupg0
		 * @param txt
		 * @param radix
		 * @param target
		 * @return 
		 * 
		 */		
		public static function systemChange(txt:String,radix:uint,target:uint):String
		{
			var num:Number = parseInt(txt,radix); //把2~32进制转换为10进制
			return num.toString(target); //把10进制转换为2~32进制
		}
	}
}