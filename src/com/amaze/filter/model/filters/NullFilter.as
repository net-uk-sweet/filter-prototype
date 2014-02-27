package com.amaze.filter.model.filters
{
	import com.amaze.filter.model.vo.FilterVO;
	
	public class NullFilter implements IFilter
	{
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			// Do nothing with the object
			return filterVO;
		}
	}
}