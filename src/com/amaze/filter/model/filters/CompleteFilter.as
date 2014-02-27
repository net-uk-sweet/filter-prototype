package com.amaze.filter.model.filters
{
	import com.alanmacdougall.underscore._;
	import com.amaze.filter.model.vo.FilterVO;
	import com.amaze.filter.model.vo.ProductVO;
	
	public class CompleteFilter implements IFilter
	{
		// If these are likely to change, may be worth loading them as an external JSON
		private var scores:Object = {
			weight: {
				under: {
					cushioning: 6.5,
					support: 6,
					fit: 5,
					ride: 6.5,
					grip: 0
				},
				normal: {
					cushioning: 8.5,
					support: 8,
					fit: 5,
					ride: 8.5,
					grip: 0				
				},
				over: {
					cushioning: 10,
					support: 10,
					fit: 8,
					ride: 9.5,
					grip: 0				
				},
				obese: {
					cushioning: 11,
					support: 11,
					fit: 8,
					ride: 10.5,
					grip: 0				
				}
			},
			experience: {
				newbie: {
					cushioning: 10.5,
					support: 10.5,
					fit: 6,
					ride: 10,
					grip: 0				
				},
				beginner: {
					cushioning: 9,
					support: 9.5,
					fit: 6,
					ride: 10,
					grip: 0				
				},
				intermediate: {
					cushioning: 7.5,
					support: 8,
					fit: 5.5,
					ride: 8,
					grip: 0				
				},
				expert: {
					cushioning: 6,
					support: 6,
					fit: 5,
					ride: 7,
					grip: 0
				}
			},
			pronation: {
				under: {
					cushioning: 10,
					support: 7,
					fit: 0,
					ride: 0,
					grip: 0				
				},
				neutral: {
					cushioning: 8,
					support: 9,
					fit: 0,
					ride: 0,
					grip: 0				
				},
				over: {
					cushioning: 9,
					support: 11,
					fit: 0,
					ride: 0,
					grip: 0				
				},
				dunno: {
					cushioning: 9.5,
					support: 10,
					fit: 0,
					ride: 0,
					grip: 0	
				}
			},
			grip: {
				off: {
					cushioning: 6,
					support: 0,
					fit: 5,
					ride: 6,
					grip: 10				
				},
				urban: {
					cushioning: 9.5,
					support: 0,
					fit: 6,
					ride: 10,
					grip: 4				
				}
			}
		};
		
		public function apply(filterVO:FilterVO, response:Object):FilterVO
		{	

			filterVO.complete = true;		
			
			filterVO.products = filterProducts(filterVO);
			filterVO.products.sortOn("suitability", Array.NUMERIC);

			return filterVO;
		}
		
		private function filterProducts(filterVO:FilterVO):Array
		{
			var userProfile:Object = getUserProfile(filterVO.responses);
			
			// useful for debugging prototype
			filterVO.userProfile = userProfile;
			
			return _.map(filterVO.products, function(product:ProductVO):ProductVO {
				
				var diff:Number = 0;
				var passportScore:Number;
				
				for (var prop:String in userProfile) {
					
					// For shoes w/ no passport, use a score of 0 for each property
					passportScore = product.passport[prop] || 0;
					diff += Math.abs(passportScore - userProfile[prop]);
				}
				
				// Lower score indicates a better match as there is less variance
				// between user profile and shoe's passport.
				// It's pretty crude however as the variance could be large on one 
				// particular property but overall variance still low. 
				product.suitability = diff;
				
				return product;
			});
		}
		
		private function getUserProfile(responses:Array):Object
		{
			// TODO: It would be nice not to have to prepare this object first
			// but build it dynamically from the questions.
			var profile:Object = {
				cushioning: 0,
				support: 0,
				fit: 0,
				ride: 0,
				grip: 0
			};
			
			var tmp:Array = _.map(responses, function(response:Object):Object {
				return scores[response.type][response.value];
			});
			
			// Combine all the scores
			_.each(tmp, function(el:Object):void {
				for (var prop:String in el) {
					profile[prop] += el[prop];
				}
			});
			
			// Get the average scores
			for (var prop:String in profile) {
				profile[prop] = Math.round(profile[prop] / tmp.length);
			}
			
			return profile;
		}
	}
}