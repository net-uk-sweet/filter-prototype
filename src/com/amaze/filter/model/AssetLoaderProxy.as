package com.amaze.filter.model
{
	import br.com.stimuli.loading.*;
	
	import com.amaze.filter.model.enum.AssetKeys;
	import com.amaze.filter.model.enum.Notifications;
	import com.amaze.filter.model.vo.ProductVO;
	import com.amaze.puremvc.model.AbstractProxy;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import org.as3commons.logging.LoggerFactory;
	
	public class AssetLoaderProxy extends AbstractProxy
	{
		public static const NAME:String = "AssetLoaderProxy";
		
		private var loader:BulkLoader;
		
		public function AssetLoaderProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
		}

		override public function onRegister():void 
		{
			super.onRegister();

			logger = LoggerFactory.getClassLogger(AssetLoaderProxy);
		}		
		
		public function load():void 
		{
			// Loading of external assets required on start up is usually handled by 
			// AssetLoaderProxy which uses the BulkLoader library. 
			
			
//			var dataProxy:ApplicationDataProxy = ApplicationDataProxy(
//				facade.retrieveProxy(ApplicationDataProxy.NAME));
//			
//			var stateProxy:ApplicationStateProxy  = ApplicationStateProxy(
//				facade.retrieveProxy(ApplicationStateProxy.NAME));
//			
//			var index:int = stateProxy.index;
//			var slide:SlideVO = dataProxy.getSlideByIndex(index);
//			
//			// Load the assets if they aren't already cached
//			if (!slide.loader) 
//			{
//				sendNotification(Notifications.SLIDE_LOADING);
//				
//				// Create a new loader instance for each slide
//				loader = new BulkLoader("Loader_" + index);
//				
//				addAsset(slide.background, AssetKeys.BACKGROUND, "image");
//				addAsset(slide.car, AssetKeys.CAR, "image");
//				addAsset(slide.animation, AssetKeys.ANIMATION, "movieclip");
//				addAsset(slide.foreground, AssetKeys.FOREGROUND, "movieclip");
//							
//				loader.addEventListener(BulkLoader.COMPLETE, completeHandler);
//				loader.addEventListener(BulkLoader.ERROR, errorHandler);
//				loader.start();
//				
//				// Store the loader instance on the Slide value object
//				slide.loader = loader;
//			}
//			else
//			{
//				completeHandler();
//			}
		}	
		
		private function addAsset(url:String, id:String, type:String):void
		{
			// All assets are optional, though at a minimum we require either 
			// a background (static image) or foreground (animation).
			if (url)
			{
				loader.add(url, {id: id, type: type});
			}
		}
		
		private function completeHandler(event:Event = null):void
		{
			//sendNotification(Notifications.ASSETS_LOADED);
		}
		
		private function errorHandler(event:ErrorEvent):void
		{
			logger.error("Failed to load slide");
		}
	}
}