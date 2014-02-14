package com.amaze.filter.view
{
	import com.amaze.filter.model.enum.Notifications;
	import com.amaze.filter.model.vo.FilterVO;
	import com.amaze.filter.model.vo.ProductVO;
	import com.amaze.puremvc.view.AbstractMediator;
	
	import flash.external.ExternalInterface;
	
	import org.as3commons.logging.LoggerFactory;
	import org.puremvc.as3.multicore.interfaces.*;
	
	/**
	 */
	public class DisplayMediator extends AbstractMediator
	{
		// Cannonical name of the Mediator
		public static const NAME:String = 'DisplayMediator';
		
		public function DisplayMediator(mediatorName:String = null, viewComponent:Object = null) 
		{
			super(mediatorName, viewComponent);
		}
		
		/**
		 * List all notifications this Mediator is interested in.
		 * <P>
		 * Automatically called by the framework when the mediator
		 * is registered with the view.</P>
		 * 
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array 
		{
			return [Notifications.PRODUCTS_FILTERED];
		}
		
		/**
		 * Handle all notifications this Mediator is interested in.
		 * <P>
		 * Called by the framework when a notification is sent that
		 * this mediator expressed an interest in when registered
		 * (see <code>listNotificationInterests</code>.</P>
		 * 
		 * @param INotification a notification 
		 */
		override public function handleNotification( note:INotification ):void 
		{
			super.handleNotification(note);	
			
			switch ( note.getName() )
			{
				case Notifications.PRODUCTS_FILTERED:
				{
					// Cast the notification body to the correct type and pass it to a handler.
					// Simple logic can be handled directly w/out delegating to a handler method.
					handleProductsFiltered(FilterVO(note.getBody()));
					break;
				}
			}
		}	
		
		// Fired when the mediator is first registered with the facade, useful 
		// for setting up view component - any configuration and addition of event listeners.
		override public function onRegister():void 
		{
			super.onRegister();
			
			logger = LoggerFactory.getClassLogger(DisplayMediator);
		}
		
		private function handleProductsFiltered(filterVO:FilterVO):void
		{
			// Update the view component !!		
			// For the prototype, we'll just use the browser's console as a cheap UI

			this.clear();
			
			this.log("------------------------------------");
			this.log("------------------------------------");
			this.log("Filtered products (" + filterVO.products.length + "):");
			
			for each(var product:ProductVO in filterVO.products)
			{
				this.log(product);
			}

			if (filterVO.weather) 
			{
				this.log("------------------------------------");	
				this.log("Weather (no effect on product data):");
				this.log(filterVO.weather);		
			}				
			
			if (filterVO.time) 
			{
				this.log("------------------------------------");	
				this.log("Time (no effect on product data):");
				this.log(filterVO.time);		
			}			
			
			if (filterVO.complete)
			{
				this.log("------------------------------------");
				this.log("User's BMI:");
				this.log(filterVO.bmi + " (" + filterVO.weight + ")");
				
				this.log("------------------------------------");
				this.log("User's profile:");
				this.table(filterVO.userProfile);			
			}
			
			this.log("------------------------------------");
			this.log("------------------------------------");
		}
		
		private function clear():void {
			
			if (ExternalInterface.available) 
			{
				ExternalInterface.call("console.clear");
			}
		}		
		
		private function log(value:*):void {
			
			if (ExternalInterface.available) 
			{
				ExternalInterface.call("console.log", value);
			}
		}
		
		private function table(value:*):void
		{
			if (ExternalInterface.available)
			{
				ExternalInterface.call("console.table", value);
			}
		}
		
		// Fired when the mediator is unregistered from the facade
		// Useful for removal of view components from stage, and removing
		// any event listeners.
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		/**
		 * Cast the viewComponent to its actual type.
		 * 
		 * <P>
		 * This is a useful idiom for mediators. The
		 * PureMVC Mediator class defines a viewComponent
		 * property of type Object. </P>
		 * 
		 * <P>
		 * Here, we cast the generic viewComponent to 
		 * its actual type in a protected mode. This 
		 * retains encapsulation, while allowing the instance
		 * (and subclassed instance) access to a 
		 * strongly typed reference with a meaningful
		 * name.</P>
		 */
		
		// We have no view component in this demo, but if we did, this
		// is a useful way of avoiding having to cast the generic view
		// component property of PureMVC mediator to its actual type.
//		protected function get display():Display
//		{
//			return viewComponent as Display;
//		}
	}
}