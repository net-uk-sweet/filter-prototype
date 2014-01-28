package com.amaze.filter.model
{
	import com.amaze.filter.model.enum.SettingsTypes;
	import com.amaze.model.ISettings;
	import com.amaze.model.Settings;
	import com.amaze.puremvc.model.AmazeDataProxy;
	
	import org.as3commons.logging.LoggerFactory;
	
	public class ApplicationDataProxy extends AmazeDataProxy
	{
		public static const NAME:String = "ApplicationDataProxy";
		
//		private var _slides:Vector.<SlideVO> = new Vector.<SlideVO>();
		
		public function ApplicationDataProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
		}
		
		override public function onRegister():void 
		{	
			super.onRegister();
			
			logger = LoggerFactory.getClassLogger(ApplicationDataProxy);	
		}
		
		override protected function onLoad():void
		{
			super.onLoad();
			
			// Super class caches references to dictionary and settings
			
			// Typically parse the content XML into VOs here
			/*
			for each(var slide:XML in xml.slide) 
			{
				slides.push(new SlideVO(
					slide.background.@source,
					slide.car.@source,
					slide.animation.@source,
					slide.foreground.@source,
					slide.@transition,
					parseInt(slide.@duration)
				));
			}
			*/
		}
	}
}