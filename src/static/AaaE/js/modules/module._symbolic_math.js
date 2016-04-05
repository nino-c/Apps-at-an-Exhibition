angular.module('symbolic_math', [])
	.service('MultivariatePolynomial', [
		function() {
			return {
				cartesianProduct: cartesianProduct,
				getTerms: getTerms
			};

			function cartesianProduct(A,B) {
			    prod = [];
			    _.each(A, function(a) {
			        _.each(B, function(b) {
			            prod.push([a,b]);
			        });
			    });
			    return prod;
			}

			function getTerms(degree, vars) {
				
				var term_exp = _.filter(cartesianProduct(_.range(degree+1), _.range(degree+1)),
		            function(x) {
		                return (x[0] + x[1]) <= degree && (x[0] + x[1]) != 0;
		            });

				return _.map(term_exp, function(exp) {

                	var t1 = vars[0]+'^'+exp[0];
                	if (exp[0] == 0) t1 = '';
                	if (exp[0] == 1) t1 = vars[0];

                	var t2 = vars[1]+'^'+exp[1];
                	if (exp[1] == 0) t2 = '';
                	if (exp[1] == 1) t2 = vars[1];

                	return t1 + t2;

                });
			}
		}
	])