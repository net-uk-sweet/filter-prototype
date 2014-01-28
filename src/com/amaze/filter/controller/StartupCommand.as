package com.amaze.filter.controller
{
	import com.amaze.filter.model.ApplicationStateProxy;
	import com.amaze.filter.model.AssetLoaderProxy;
	import com.amaze.puremvc.controller.ApplicationStartupCommand;
	import com.amaze.puremvc.model.ExternalInterfaceProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class StartupCommand extends ApplicationStartupCommand
	{
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			// We can override the default framework StartupCommand to register any 
			// non asynchronous proxies we need for our application.
			
			facade.registerProxy(new ExternalInterfaceProxy(ExternalInterfaceProxy.NAME));
			//facade.registerProxy(new ApplicationStateProxy(ApplicationStateProxy.NAME));
			//facade.registerProxy(new AssetLoaderProxy(AssetLoaderProxy.NAME));
		}
	}
}