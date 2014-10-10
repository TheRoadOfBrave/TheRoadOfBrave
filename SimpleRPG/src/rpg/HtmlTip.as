package rpg
{
	import mx.controls.ToolTip;
	
	public final class HtmlTip extends ToolTip
	{
		public function HtmlTip()
		{
			super();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (textField != null)
			{
				textField.text = "";
				textField.htmlText=text;
			}
		}
		
		
	}
}