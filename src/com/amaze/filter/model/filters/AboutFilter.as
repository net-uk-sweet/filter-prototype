package com.amaze.filter.model.filters
{
	import com.alanmacdougall.underscore._;
	import com.amaze.filter.model.vo.FilterVO;
	
	public class AboutFilter implements IFilter
	{
		// Is BMI calculated the same way across the world?
		// If not, we may want to move some of these ranges into a settings file
		
		// Assumes client app will pass only the upper limit of selected age range
		private var ages:Array = [24, 34, 44, 54, 64, 74];
		
		// Associate BMI ranges w/ human readable values
		private var weightCategories:Array = [
			{ type: "under", range: [0, 19] },
			{ type: "normal", range: [20, 25] },
			{ type: "over", range: [26, 30] },
			{ type: "obese", range: [31, 1000] } 
		];
		
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			// Assumes a metric input of kilograms and centimetres
			// For UK rollout we may need a setting to switch calcs to imperial
			
			var gender:String = response.gender.toString();
			var height:Number = parseFloat(response.height) / 100;
			var weight:Number = parseFloat(response.weight);
			var age:int = parseInt(response.age);
			
			// Calculate weighted BMI
			var bmi:Number = weight / (height * height);
			bmi += (gender == "male") ? 1 : 0;
			bmi -= ages.indexOf(age) * 0.5;

			var weightCategory:String = getWeightCategory(bmi);
			
			//			LoggerFactory.getClassLogger(AboutFilter).debug("BMI: " + bmi);
			
			filterVO.addResponse("weight", weightCategory);
			filterVO.products = _.filter(filterVO.products, function(product:Object):Boolean { 
				return product.gender == gender; 
			});

			filterVO.bmi = bmi; // This won't be used, but it's handy to see for debugging
			filterVO.weight = weightCategory; // Product matching is based on descriptive value not actual BMI score
			
			return filterVO; 
		}
		
		// Convert the calculated, weighted BMI into a descriptive value
		private function getWeightCategory(bmi:Number):String 
		{
			bmi = Math.round(bmi);
			
			return _.find(weightCategories, function(cat:Object):Boolean {
				return bmi >= cat.range[0] && bmi <= cat.range[1];
			}).type;   
		}
	}
}