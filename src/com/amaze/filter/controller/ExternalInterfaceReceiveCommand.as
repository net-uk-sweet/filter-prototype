package com.amaze.filter.controller
{
	import com.amaze.filter.model.ApplicationStateProxy;
	import com.amaze.filter.model.ProductDataProxy;
	import com.amaze.filter.model.enum.Notifications;
	
	import org.as3commons.logging.*;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * Gateway for all incoming external interface calls. 
	 */
	public class ExternalInterfaceReceiveCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(note:INotification):void    
		{
			var responses:Array = note.getBody() as Array;
			ProductDataProxy(facade.retrieveProxy(ProductDataProxy.NAME)).filter(responses);
		}
	}
}