package com.amaze.filter.model.filters
{
	import com.amaze.filter.model.vo.FilterVO;
	
	public class SurfaceFilter implements IFilter
	{
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			/*
				Translated below (with other questions, the translation is done client-side) :-
			
				From: 		To:
			
				Trail 		- off
				Track 		- urban
				Road 		- urban
				Treadmill	- urban
				Mixed		- urban
			*/
			
			var surface:String = (response.toString() == "trail") ? "off" : "urban";
			filterVO.addResponse("grip", surface);		
			
			return filterVO;
		}
	}
}