package com.amaze.filter.model.filters
{
	import com.alanmacdougall.underscore._;
	import com.amaze.filter.model.vo.FilterVO;
	import com.amaze.model.vo.AbstractVO;
	
	public class ExperienceFilter implements IFilter
	{
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			filterVO.addResponse("experience", response.toString());
			
			// Might be filtering required here			
			
			return filterVO;
		}
	}
}