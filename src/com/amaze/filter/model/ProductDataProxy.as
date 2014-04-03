package com.amaze.filter.model
{
	import com.alanmacdougall.underscore._;
	import com.amaze.filter.model.enum.Notifications;
	import com.amaze.filter.model.filters.AboutFilter;
	import com.amaze.filter.model.filters.CompleteFilter;
	import com.amaze.filter.model.filters.ExperienceFilter;
	import com.amaze.filter.model.filters.IFilter;
	import com.amaze.filter.model.filters.NullFilter;
	import com.amaze.filter.model.filters.PronationFilter;
	import com.amaze.filter.model.filters.SurfaceFilter;
	import com.amaze.filter.model.filters.TimeFilter;
	import com.amaze.filter.model.filters.WeatherFilter;
	import com.amaze.filter.model.vo.FilterVO;
	import com.amaze.filter.model.vo.ProductVO;
	import com.amaze.puremvc.model.XMLLoaderProxy;
	import com.amaze.puremvc.model.enum.Cores;
	
	import org.as3commons.logging.LoggerFactory;
	
	public class ProductDataProxy extends XMLLoaderProxy
	{
		public static const NAME:String = "ProductDataProxy";
		
		private var _products:Array = new Array(); // stick w/ array rather than vector for underscore
		private var ASICS:Namespace = new Namespace("http://asicseurope.com/product/catalog");
		
		public function ProductDataProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
		}
		
		override public function onRegister():void 
		{	
			super.onRegister();
			
			logger = LoggerFactory.getClassLogger(ProductDataProxy);	
		}
		
		override protected function onLoad():void
		{
			super.onLoad();
			
			var products:XMLList = this.xml.ASICS::Products;
			
			// Aren't namespaces a pain?
			// Here we parse the data we want from the product feed into 
			// a collection of value objects. 
			for each(var product:XML in products.ASICS::Product) 
			{
				_products.push(new ProductVO(
					product.ASICS::GlobalID,
					product.ASICS::StyleName,
					product.ASICS::ProductGender.toString().toLowerCase(),
					parseAttribute("Pronation", product.ASICS::ProductAttributes),
					parsePassport(product.ASICS::PassportAttributes)
				));
			}
 		}

		// Helper method to grab AttributeValue node associated with a given AttributeName
		private function parseAttribute(name:String, attributes:XMLList):String
		{
			// Might be a neater way of doing this than looping over the XMLList
			for each(var attribute:XML in attributes.ASICS::Attribute) 
			{
				if (attribute.ASICS::AttributeName == name) 
					return attribute.ASICS::AttributeValue.toString().toLowerCase();
			}
			
			return null;
		}		
		
		// Helper method to build product passport dictionary
		private function parsePassport(attributes:XMLList):Object
		{
			var obj:Object = {};
			
			for each(var attribute:XML in attributes.ASICS::PassportAttribute)
			{
				// Some feeds we've received have the attributes in uppercase
				obj[attribute.@type.toString().toLowerCase()] = parseFloat(attribute.@value.toString());	
			}
			
			// Currently some of the products don't have a passport
			return obj;
		}
		
		public function filter(responses:Array):void
		{
			// Clone the product array so we leave it unaffected
			var filterVO:FilterVO = new FilterVO(_.clone(this._products), []);
			
			// Loop through each response and apply the appropriate filter
			for each(var response:Object in responses) 
			{
				// value object is passed into filter along with response
				// and amended value is returned
				filterVO = getFilter(response.type).apply(filterVO, response.value);	
			}
			
			// Send the updated version of the filter value object as the body of the notification.
			// We could also set it as a property of this proxy and access it directly in
			// any action which receives the notification :- 
			// ProductDataProxy(facade.retrieveProxy(ProductDataProxy.NAME)).filterVO;
			sendNotification(Notifications.PRODUCTS_FILTERED, filterVO);
		}
		
		// Factory method to return appropriate filter according to response type
		private function getFilter(type:String):IFilter
		{
			var filter:IFilter;
			
			switch(type) 
			{
				// Q.1
				case "surface": 
				filter = new SurfaceFilter();
				break;
				
				// Q.2
				case "experience": 
				filter = new ExperienceFilter();
				break;
				
				// Q.3
				case "objectives": 
				// Currently we do nothing with objectives at all
				filter = new NullFilter();
				break;
				
				// Q.4
				case "about":
				filter = new AboutFilter();
				break;				
				
				// Q.5
				case "pronation":
				filter = new PronationFilter();
				break;
				
				// Q.6
				case "time":
				filter = new TimeFilter();
				break;
				
				// Q.7
				case "weather":
				filter = new WeatherFilter();
				break;
				
				// All questions answered
				case "complete":
				filter = new CompleteFilter();
				break;
				
				default:
				filter = new NullFilter();
			}
			
			return filter;
		}		
		
		override public function get xml():XML 
		{
			return this.getXML(Cores.SHELL);
		}
	}
}