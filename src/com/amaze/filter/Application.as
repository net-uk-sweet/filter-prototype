package com.amaze.filter
{
	import com.amaze.filter.controller.StartupCommand;
	import com.amaze.filter.view.ApplicationMediator;
	import com.amaze.puremvc.AmazeApplication;
	import com.amaze.puremvc.model.enum.Cores;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	/**
	 * The Document class and root of the shell multicore component. 
	 */
	[SWF(width="1400", height="460", frameRate="31")]	
	public class Application extends AmazeApplication
	{
		private static const NAME:String = "Template";
		private static const VERSION:String = "0.0.0.r.0";
		
		override protected function startup():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;	
			
			facade = ApplicationFacade.getInstance(Cores.SHELL);
			facade.name = NAME;
			facade.version = VERSION;
			
			facade.startup(this, com.amaze.filter.controller.StartupCommand);
		}
		
		override public function get applicationMediator():Class
		{
			return ApplicationMediator;
		}
	}
}