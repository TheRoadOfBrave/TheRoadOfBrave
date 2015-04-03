package rpg.view
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	
	import rpg.events.GameEvent;
	
	public final class TitleView extends Group
	{
		public var startBtn:Button;
		public var loadBtn:Button;
		public var clearBtn:Button;
		public function TitleView()
		{
			super();
			drawRect(0,0,480,680,0);
		}
		
		private function drawRect(x:Number,y:Number,w:Number,h:Number,c:uint,r:Number=0):void{
			var g:Graphics=this.graphics;
			g.beginFill(c,0.4);
			if (r>0){
				g.drawRoundRect(x,y,w,h,r)
			}else{
				g.drawRect(x,y,w,h);
			}
			g.endFill();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			startBtn=new Button;
			startBtn.width=150;
			startBtn.height=50;
			startBtn.x=200;
			startBtn.y=100;
			startBtn.label="开始游戏"
			addElement(startBtn);
			
			loadBtn=new Button;
			loadBtn.width=150;
			loadBtn.height=50;
			loadBtn.x=200;
			loadBtn.y=180;
			loadBtn.label="继续游戏"
			addElement(loadBtn);
			
			clearBtn=new Button;
			clearBtn.width=150;
			clearBtn.height=50;
			clearBtn.x=200;
			clearBtn.y=240;
			clearBtn.label="清空存档"
			addElement(clearBtn);
			
			
			startBtn.addEventListener(MouseEvent.CLICK,btnHandler);
			loadBtn.addEventListener(MouseEvent.CLICK,btnHandler);
			clearBtn.addEventListener(MouseEvent.CLICK,btnHandler);
		}
		
		protected function btnHandler(event:MouseEvent):void
		{
			var evt:GameEvent
			switch(event.currentTarget)
			{
				case startBtn:
					evt=new GameEvent(GameEvent.START);
					break;
				case loadBtn:
					evt=new GameEvent(GameEvent.CONTINUE);
					break;
				case clearBtn:
					evt=new GameEvent(GameEvent.DELETE);
					break;
				default:
					break;
				
				
			}
			
			dispatchEvent(evt);
			
		}		
		
		
	}
}