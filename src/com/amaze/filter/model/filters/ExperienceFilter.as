package com.amaze.filter.model.filters
{
	import com.amaze.filter.model.vo.FilterVO;
	
	public class ExperienceFilter implements IFilter
	{
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{
			/*
				Translated on the client :-
				
				From:					To:
			
				Once a month			- newbie
				Once a week				- beginner
				Twice a week			- intermediate
				More than twice a week	- expert
			*/
			
			filterVO.addResponse("experience", response.toString());
			
			// TBC whether filtering will be required here. 
			// Currently no product data to filter against			
			
			return filterVO;
		}
	}
}