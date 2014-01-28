package com.amaze.filter.model.filters
{
	import com.alanmacdougall.underscore._;
	import com.amaze.filter.model.vo.FilterVO;
	import com.amaze.model.vo.AbstractVO;
	
	public class SurfaceFilter implements IFilter
	{
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			var surface:String = (response.toString() == "trail") ? "off" : "urban";
			filterVO.addResponse("grip", surface);		
			
			return filterVO;
		}
	}
}