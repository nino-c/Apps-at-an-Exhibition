
Vector.prototype.length = function() {
	return this.distanceFrom($V([0,0]));
}

Vector.prototype.normalize = function() {
    return this.multiply(1/this.length())
}