package com.amaze.filter
{
	import com.amaze.filter.controller.ExternalInterfaceReceiveCommand;
	import com.amaze.filter.controller.StartupCompleteCommand;
	import com.amaze.filter.model.ApplicationDataProxy;
	import com.amaze.filter.model.AssetLoaderProxy;
	import com.amaze.filter.model.ProductDataProxy;
	import com.amaze.puremvc.model.*;
	import com.amaze.puremvc.model.enum.AmazeNotifications;
	import com.amaze.puremvc.patterns.AmazeFacade;
	
	import org.puremvc.as3.multicore.utilities.startupmanager.controller.*;

	// core start up proxies used by this implementation
//	com.amaze.puremvc.model.XrayProxy;
//	com.amaze.puremvc.model.ExternalInterfaceProxy;
	
	// implementation specific start up proxies
	com.amaze.filter.model.ApplicationDataProxy;
	com.amaze.filter.model.ProductDataProxy;
	com.amaze.filter.model.AssetLoaderProxy;
    
	/**
	 * Initialises and caches the Core actors of the MVC triumverate: Model, View and Controller.
	 * Provides a single place to access all of their public methods. 
	 * Allows Proxies, Mediators and Commands to talk to each other in a loosely coupled way, 
	 * without having to import or work directly with the Core framework actors. 
	 * Concrete facade for this implementation. Inherits core Amaze 
	 * functionality from AmazeFacade 
	*/
    public class ApplicationFacade extends AmazeFacade
    {	
		public function ApplicationFacade(key:String)
		{
			super(key);
		}
		
        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance(key:String):ApplicationFacade
		{
            if (instanceMap[key] == null) instanceMap[key] = new ApplicationFacade(key);
            return instanceMap[key] as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController() : void 
        {
            super.initializeController();
			
			registerCommand(AmazeNotifications.EXTERNAL_INTERFACE_RECEIVE, ExternalInterfaceReceiveCommand);
			registerCommand(AmazeNotifications.STARTUP_COMPLETE, StartupCompleteCommand);
        }
    }
}