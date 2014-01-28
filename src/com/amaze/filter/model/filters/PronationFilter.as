package com.amaze.filter.model.filters
{
	import com.alanmacdougall.underscore._;
	import com.amaze.filter.model.vo.FilterVO;
	import com.amaze.model.vo.AbstractVO;
	
	public class PronationFilter implements IFilter
	{
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			var pronation:String = response.toString();
			
			filterVO.addResponse("pronation", pronation);
			
			if (pronation != "dunno")
			{
				filterVO.products = _.filter(filterVO.products, function(product:Object):Boolean {
					return product.pronation == pronation;
				});
			}
			
			return filterVO;
		}
	}
}