package mk
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class TweenMac
	{
		//一些图片尺寸和位置信息
		private var imgW:Number = 243;
		private var imgH:Number = 341;
		private var imgX:Number = 278.5;
		private var imgY:Number = 129.5;
		//图片边上面的点数（包括两端）？横竖都分一样。段数越多越细腻，越吃资源
		private var segment:int = 10;
		//点到目标点的距离和延迟时间的系数
		private var delay:Number = 1 / 1000;
	//	private var delay:Number = 1.5;
		//点到目标点补间所用时间
		private var time:Number = 0.6;
		//位图资源
		private var img:BitmapData;
		//是否已经隐藏图片
		private var ifHide:Boolean = false;
		//是否在播放动画
		private var isTweening:Boolean = false;
		//位图被分成三角形网格之后，记录顶点坐标，不知道这个东西什么用的请参考API的Graphics.drawTriangles方法的第一个参数
		private var vertexes:Vector.<Number> = new Vector.<Number>(segment * segment * 2);
		//意义同vertexes，points被缓动，然后把值赋给vertexes进行渲染
		private var points:Vector.<Point> = new Vector.<Point>(segment * segment);
		//三角形点目录，请参考API的Graphics.drawTriangles方法的第二个参数
		private var indices:Vector.<int> = new Vector.<int>((segment - 1) * (segment - 1) * 6);
		//uv纹理，请参考API的Graphics.drawTriangles方法的第三个参数
		private var uvs:Vector.<Number> = new Vector.<Number>(segment * segment * 2);
		//缓动时间轴，用于回放动画
		private var tweens:TimelineLite;
		public var toX:Number;
		public var toY:Number;
		private var graphics:Graphics;
		private var fun:Function;
		private var args:Array;
		public var auto:Boolean;
		public var target:DisplayObject;
		public function TweenMac(target:DisplayObject,canvas:Sprite,auto:Boolean=false)
		{
			this.target=target;
			this.auto=auto;
			img = new BitmapData(target.width, target.height,true,0);
			img.draw(target);//存到位图里面
			imgX=target.x;
			imgY=target.y;
			imgW=img.width;
			imgH=img.height;
			
		this.graphics=canvas.graphics;
//			this.graphics.beginBitmapFill(img);
//			this.graphics.drawRect(0,0,200,300);
//			this.graphics.endFill();
			setPic();
			
			if (auto){
				target.visible=false;
			}
		}
		
		public  function setPic():void{
			var u:Number = imgW / (segment - 1);//水平相邻点距离
			var v:Number = imgH / (segment - 1);//竖直相邻点距离
			var s:Number = 1 / (segment - 1);//水平和竖直相邻点距离占总长的百分比（uv纹理用的）
			var vi:int = 0;
			for (var i:int = 0; i < segment; i++)
			{
				for (var j:int = 0; j < segment; j++)
				{
					//计算点的坐标并写入对应的数组位置
					var lp:Point = new Point(j * u + imgX, i * v + imgY);
					vertexes[vi] = lp.x;
					uvs[vi++] = j * s;
					vertexes[vi] = lp.y;
					uvs[vi++] = i * s;
					points[i * segment + j] = lp;
				}
			}
			vi = 0;
			var ii:int = 0;
			for (i = 0; i < segment - 1; i++)
			{
				for (j = 0; j < segment - 1; j++)
				{
					//指定三角形各个点和vertexes中点的对应关系
					indices[ii++] = vi;
					indices[ii++] = vi + 1;
					indices[ii++] = vi + segment + 1;
					indices[ii++] = vi;
					indices[ii++] = vi + segment;
					indices[ii++] = vi + segment + 1;
					vi++;
				}
				vi++;
			}
			
		}
		
		public function buildTween(x:Number,y:Number,time:Number):void{
			var toX:Number = x;
			var toY:Number = y;
			var i:int = points.length - 1;//遍历的中间变量
			var dist:Number;//点和目标点的距离
			if (isTweening == true) return;//如果正在播放动画，则点击无效
			
			//设置为正在播放
			//如果图片不是隐藏的
			//创建一个缓动时间轴动画，并在动画播放完后执行tweenOver
			tweens = new TimelineLite( { paused:true, onUpdate:frame ,onComplete:tweenOver, onReverseComplete:tweenOver } );
			do
			{
				//计算点到目标点，也就是鼠标点击的点的距离
				dist = Math.sqrt(Math.pow(toX - points[i].x, 2) + Math.pow(toY - points[i].y, 2));
				var dt:Number=time-(dist*delay)
				var t:Number=Math.abs(toY - points[i].y)*time*0.02;
				//dist =-(toY - points[i].y)
				//在时间轴上添加对Point数据的缓动，缓动开始时间和点到目标点的距离成正比，这个是效果的关键
				tweens.insert(TweenLite.to(points[i], t, { x:toX, y:toY } ),dt);
			}
			while (i--)
				
				trace(dt+"最长："+t)
		}
		
		public  function to(x:Number,y:Number,time:Number,fun:Function=null,args:Array=null):void{
			buildTween(x,y,time);
			this.fun=fun;
			this.args=args;
			isTweening = true;//设置正在动画
			tweens.play()
		}
		
		public  function from(x:Number,y:Number,time:Number,fun:Function=null,args:Array=null):void{
			buildTween(x,y,time);
			this.fun=fun;
			this.args=args;
			//tweens.play();//开始对Point数据进行缓动
			//ifHide = true;//设置隐藏
			tweens.complete(false,true);
			isTweening = true;//设置正在动画
		//	tweens.currentTime=tweens.duration;
			tweens.reverse();
			
		}
		
		//动画播放结束调用
		private function tweenOver():void
		{
			isTweening = false;
			graphics.clear();
			if (auto && target){
				target.visible=true;
				
			}
			if (fun!=null){
				fun.apply(null,args);
			}
		}
		
		
		//渲染
		private function frame(e:Event=null):void
		{
			var vi:int = 0;
			var pi:int = 0;
			var i:int = segment * segment;
			//把Point的数据写到vertexes中
			while (i--)
			{
				vertexes[vi++] = points[pi].x;
				vertexes[vi++] = points[pi++].y;
			}
			//绘制
			this.graphics.clear();
			this.graphics.beginBitmapFill(img);
			this.graphics.drawTriangles(vertexes, indices, uvs);
			this.graphics.endFill();
		}
		
		
		
	}
}