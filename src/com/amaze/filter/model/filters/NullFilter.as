package com.amaze.filter.model.filters
{
	import com.alanmacdougall.underscore._;
	import com.amaze.filter.model.vo.FilterVO;
	import com.amaze.model.vo.AbstractVO;
	
	public class NullFilter implements IFilter
	{
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			// Do nothing with the object
			return filterVO;
		}
	}
}