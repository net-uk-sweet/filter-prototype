package com.amaze.filter.model.vo
{
	import com.amaze.model.vo.AbstractVO;
	
	public class FilterVO extends AbstractVO
	{
		// Filtered set of products
		public var products:Array;
		
		// Array of responses to be cached as inputs for the 
		// filter which is run on completion of all questions :-
		// 1. weight, 2. experience, 3. pronation, 4. surface 
		public var responses:Array;
		
		// Potentially used by view to display appropriate visual state?
		public var weather:String;
		public var time:String;
		
		// True if all questions have been answered
		public var complete:Boolean;
		
		// This stuff isn't necessary for the app itself, but useful
		// for debugging the prototype. 
		public var bmi:Number;
		public var weight:String;
		public var userProfile:Object;
		
		public function FilterVO(
			products:Array = null,
			responses:Array = null,
			weather:String = null,
			time:String = null,
			complete:Boolean = false,
			bmi:Number = 0,
			weight:String = null,
			userProfile:Object = null
		)
		{
			super();
			
			this.products = products;
			this.responses = responses;
			this.weather = weather;
			this.time = time;
			this.complete = complete;
			
			// debug props
			this.bmi = bmi;
			this.weight = weight;
			this.userProfile = userProfile;
		}
		
		public function addResponse(type:String, value:String):void
		{
			if (!responses) 
			{
				responses = [];	
			}
			
			responses.push({ type: type, value: value });
		}
	}
}