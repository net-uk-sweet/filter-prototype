package com.amaze.filter.view
{
	import com.amaze.filter.Application;
	import com.amaze.filter.model.enum.DictionaryTerms;
	import com.amaze.filter.model.enum.SettingsKeys;
	import com.amaze.model.IDictionary;
	import com.amaze.model.ISettings;
	import com.amaze.puremvc.model.enum.AmazeNotifications;
	import com.amaze.puremvc.model.enum.Cores;
	import com.amaze.puremvc.view.AmazeFlashMediator;
	import com.amaze.util.ServiceLocator;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class ApplicationMediator extends AmazeFlashMediator implements IMediator
	{
		// Cannonical name of the Mediator
		public static const NAME:String = 'ApplicationMediator';
		
		public function ApplicationMediator(mediatorName:String=null, viewComponent:Object=null)
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
			return super.listNotificationInterests().concat([
				AmazeNotifications.STARTUP_COMPLETE
			]);
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
		override public function handleNotification(note:INotification):void 
		{
			super.handleNotification(note);
			
			switch (note.getName())
			{			
				case AmazeNotifications.STARTUP_COMPLETE:
				{
					initializeView();
					initializeResources();
					break;	
				}	
			}
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// This is called as soon as the framework is instantiated but before
			// framework startup command has been completed. Good place for registering 
			// a view to display load feedback if required.
		}
		
		private function initializeView():void
		{
			// Initialise the view here - usually makes sense, even for simple apps
			// to abstract view functionality out of this mediator to an mediator.
			
			// View component can be passed to mediator either as the second param of the
			// Mediator constructor, or set-up and registered w/in the onRegister method
			// of the mediator itself.
			facade.registerMediator(new DisplayMediator(DisplayMediator.NAME));
		}
		
		private function initializeResources():void
		{
			// Access dictionary and settings as follows: 
			// Often makes sense to cache a reference as a property of the Mediator / Proxy
			// Ideally these would only be referenced directly in framework code
			// ie. pass the required values to any UI components
			var dictionary:IDictionary = serviceLocator.getDictionary(Cores.SHELL);
			var settings:ISettings = serviceLocator.getSettings(Cores.SHELL);
			
			// Using the logger :- debug, info, warn, error, fatal
			logger.debug("Testing dictionary: " + dictionary.getTerm(DictionaryTerms.DICTIONARY_TEST));
			logger.debug("Testing settings: " + settings.getSetting(SettingsKeys.SETTINGS_TEST));
		}

		/**
		 * Cast the viewComponent to its actual type.
		 * 
		 * <P>
		 * This is the same viewComponent returned by
		 * the com.amaze.puremvc.view.AmazeMediator.document
		 * method, but by implementing a getter in our 
		 * concrete class we can return the component as the
		 * specific type which is necessary in multicore
		 * implementations.
		 * </P>
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
		 * 
		 * @return Application the viewComponent cast to Application (document class type)
		 */
		protected function get application():Application
		{
			return viewComponent as Application;
		}
	}
}