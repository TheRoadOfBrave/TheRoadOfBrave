package mk.util
{
	public final class HtmlUtil
	{
		public static function font(str:String,color:String="#ffffff",size:uint=12,b:Boolean=false):String{
			str= "<font color='"+color+"' size='"+size+"'>"+str+"</font>";
			if (b){
				str=bold(str);
			}
			return str;
		}
		
		public static function color(str:String,color:String="#ffffff"):String{
			str= "<font color='"+color+"' >"+str+"</font>";
			return str;
		}
		
		public static function bold(str:String):String{
			str= "<b>"+str+"</b>";
			return str;
		}
	}
}