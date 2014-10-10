package rpg.command
{
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.logging.Log;
	
	import spark.components.TextArea;
	
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	
	import org.robotlegs.mvcs.Command;
	
	import rpg.LogTarget;
	
	public class SetupLoggerCmd extends Command
	{
		private var txt:TextArea;
		private var textFlow:TextFlow;
		public function SetupLoggerCmd()
		{
			super();
		}
		
		
		override public function execute():void
		{
			var logTarget:LogTarget=new LogTarget;
			logTarget.filters = ["Proxy"]; 
			
			//logTarget.includeDate = true; //输出信息是否包含日期
			logTarget.includeTime = true; //输出信息是否包含时间
			logTarget.includeLevel = true; //输出信息是否包含等级
			//	logTarget.includeCategory = true; //输出信息是否包含class名
			//	logTarget.level = LogEventLevel.INFO; //设定输出的等级
			
			logTarget.logFun=logFunction;
			Log.addTarget(logTarget);
			
			var menu:ContextMenu=contextView.contextMenu
			var item:ContextMenuItem = new ContextMenuItem("debug");
			menu.customItems.push(item);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, showDebug);
			var item2:ContextMenuItem = new ContextMenuItem("clean");
			menu.customItems.push(item2);
			item2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, clean);
			
			
			txt=new TextArea();
			txt.setStyle("contentBackgroundColor",0xeeeeee);
			txt.width=1000;
			txt.height=600;
			txt.editable=false;
			textFlow=new TextFlow;
			txt.textFlow=textFlow;
			
		}
		
		protected function logFunction(str:String):void{
			//txt.text+=str+"\n";
			trace(str);
			
			
			var span:SpanElement = new SpanElement();
			if (str.indexOf(">>>")>-1){
				span.color=0x009900;
			}else if (str.indexOf("<<<")>-1){
				span.color=0x000099;
			}
			span.fontSize=15;
			span.text = str+"\n";
			var paragraph:ParagraphElement = new ParagraphElement();
			paragraph.addChild(span);
			txt.textFlow.addChild(paragraph);
			txt.appendText("");
		}
		
		protected function showDebug(event:ContextMenuEvent):void
		{
			var main:SimpleRPG=SimpleRPG(contextView)
			if (main.contains(txt)){
				main.removeElement(txt);
			}else{
				main.addElement(txt);
			}
		}
		
		protected function clean(event:ContextMenuEvent):void
		{
			txt.text="";
		}
		
		
		
	}
}