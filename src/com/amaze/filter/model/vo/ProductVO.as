package com.amaze.filter.model.vo
{
	import com.amaze.model.vo.AbstractVO;
	
	public class ProductVO extends AbstractVO
	{
		public var id:String;
		public var styleName:String;
		public var gender:String;
		public var pronation:String;
		public var passport:Object;
		public var suitability:Number;
		
		public function ProductVO(
			id:String = null,
			styleName:String = null,
			gender:String = null,
			pronation:String = null,
			passport:Object = null,
			suitability:Number = 0
		)
		{
			super();
			
			this.id = id;
			this.styleName = styleName;
			this.gender = gender;
			this.pronation = pronation;
			this.passport = passport;
			this.suitability = suitability;
		}
	}
}