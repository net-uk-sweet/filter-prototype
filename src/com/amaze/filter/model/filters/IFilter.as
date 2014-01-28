package com.amaze.filter.model.filters
{
	import com.amaze.filter.model.vo.FilterVO;

	public interface IFilter
	{
		function apply(filterVO:FilterVO, response:Object):FilterVO;
	}
}