
Vector.prototype.length = function() {
	return this.distanceFrom($V([0,0]));
}