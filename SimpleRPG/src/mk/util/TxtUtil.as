package mk.util
{
	public class TxtUtil
	{
		
		/**
		 *把xls csv形式文本转换成2维数组 
		 * @param data
		 * @param s 分割符 默认制表符
		 * @return 
		 * 
		 */
		public static function parseTxt(data:String,s:String="\t"):Array{
			data=data.replace(/\r\n/g,"\n");
			var lineArr:Array=data.split("\n");
			var len:uint=lineArr.length; 
			var datas:Array=[];
			for (var i:int=0;i<len;i++){
				var str:String=lineArr[i];
				var obj:Array=str.split(s);
				datas.push(obj);
			}
			
			return datas;
		}
		
		/**
		 *把xls csv形式文本转换成obj数组 
		 * @param data csv数据，第一行为字段名 第二行开始才是数据
		 * @param s 分割符 默认制表符
		 * @return 
		 * 
		 */
		public static function parseTxtObj(data:String,s:String="\t"):Array{
			data=data.replace(/\r\n/g,"\n");
			var lineArr:Array=data.split("\n");
			var len:uint=lineArr.length; 
			var datas:Array=[];
			var fields:Array;
			for (var i:int=0;i<len;i++){
				var str:String=lineArr[i];
				if (i==0){
					fields=str.split(s);
					continue;
				}
				var arr:Array=str.split(s);
				var obj:Object=new Object;
				for (var j:int=0; j<fields.length;j++){
					obj[fields[j]]=arr[j]
				}
				datas.push(obj);
			}
			
			return datas;
		}
		
	}
}