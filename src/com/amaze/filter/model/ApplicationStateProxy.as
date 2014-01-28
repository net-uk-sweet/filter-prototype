package com.amaze.filter.model
{
	import com.amaze.filter.model.enum.Notifications;
	import com.amaze.puremvc.model.AbstractProxy;
	
	public class ApplicationStateProxy extends AbstractProxy
	{
		public static const NAME:String = "ApplicationStateProxy";
		
		// Usually have a separate Proxy to represent application state. 
		// For example, current view index, disabled / enabled etc.
		
		public function ApplicationStateProxy(proxyName:String = null, data:Object = null) 
		{
			super(proxyName, data);
		}
	}
}