package com.amaze.filter.model.filters
{
	import com.alanmacdougall.underscore._;
	import com.amaze.filter.model.vo.FilterVO;
	
	public class PronationFilter implements IFilter
	{
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			var pronation:String = response.toString();
			
			filterVO.addResponse("pronation", pronation);
			
			// Don't filter the products for users who don't know their pronation
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