package com.amaze.filter.controller
{
	import com.amaze.filter.model.ApplicationStateProxy;
	import com.amaze.filter.model.AssetLoaderProxy;
	import com.amaze.filter.model.ProductDataProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupCompleteCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			// Might not need this, but we can use it to execute any logic
			// required when initial start up process has finished
		}
	}
}