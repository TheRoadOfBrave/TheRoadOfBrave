package rpg
{
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.IFlexModuleFactory;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	
	public class RpgAlert extends Alert
	{
		public function RpgAlert()
		{
			super();
		}
	}
	
public static function show(text:String = "", title:String = "",
								flags:uint = 0x4 /* Alert.OK */, 
								parent:Sprite = null, 
								closeHandler:Function = null, 
								iconClass:Class = null, 
								defaultButtonFlag:uint = 0x4 /* Alert.OK */,
								moduleFactory:IFlexModuleFactory = null):Alert
	{
		var modal:Boolean = (flags & Alert.NONMODAL) ? false : true;
		
		if (!parent)
		{
			var sm:ISystemManager = ISystemManager(FlexGlobals.topLevelApplication.systemManager);
			// no types so no dependencies
			var mp:Object = sm.getImplementation("mx.managers.IMarshallPlanSystemManager");
			if (mp && mp.useSWFBridge())
				parent = Sprite(sm.getSandboxRoot());
			else
				parent = Sprite(FlexGlobals.topLevelApplication);
		}
		
		var alert:Alert = new Alert();
		
		if (flags & Alert.OK||
			flags & Alert.CANCEL ||
			flags & Alert.YES ||
			flags & Alert.NO)
		{
			alert.buttonFlags = flags;
		}
		
		if (defaultButtonFlag == Alert.OK ||
			defaultButtonFlag == Alert.CANCEL ||
			defaultButtonFlag == Alert.YES ||
			defaultButtonFlag == Alert.NO)
		{
			alert.defaultButtonFlag = defaultButtonFlag;
		}
		
		alert.text = text;
		alert.title = title;
		alert.iconClass = iconClass;
		
		if (closeHandler != null)
			alert.addEventListener(CloseEvent.CLOSE, closeHandler);
		
		// Setting a module factory allows the correct embedded font to be found.
		if (moduleFactory)
			alert.moduleFactory = moduleFactory;    
		else if (parent is IFlexModule)
			alert.moduleFactory = IFlexModule(parent).moduleFactory;
		else
		{
			if (parent is IFlexModuleFactory)
				alert.moduleFactory = IFlexModuleFactory(parent);
			else                
				alert.moduleFactory = FlexGlobals.topLevelApplication.moduleFactory;
			
			// also set document if parent isn't a UIComponent
			if (!parent is UIComponent)
				alert.document = FlexGlobals.topLevelApplication.document;
		}
		
	//	alert.addEventListener(FlexEvent.CREATION_COMPLETE, static_creationCompleteHandler);
		PopUpManager.addPopUp(alert, parent, modal);
		
		return alert;
	}
}