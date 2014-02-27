package com.amaze.filter.model.filters
{
	import com.amaze.filter.model.vo.FilterVO;
	
	public class WeatherFilter implements IFilter
	{
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			// Not used to filter or product match. Essentially creative fluff!
			filterVO.weather = response.toString();
			
			return filterVO;
		}
	}
}