var Canvas = document.getElementById('big-canvas');

var seed = 
{
    "y":{"type":"number","default":1,"varname":"y"},
    "y^2":{"type":"number","default":2,"varname":"y2"},
    "y^3":{"type":"number","default":3,"varname":"y3"},
    "y^4":{"type":"number","default":-2,"varname":"y4"},
    "y^5":{"type":"number","default":5,"varname":"y5"},
    "x":{"type":"number","default":1,"varname":"x"},
    "xy":{"type":"number","default":1,"varname":"xy"},
    "xy^2":{"type":"number","default":0,"varname":"xy2"},
    "xy^3":{"type":"number","default":7,"varname":"xy3"},
    "xy^4":{"type":"number","default":1,"varname":"xy4"},
    "x^2":{"type":"number","default":0,"varname":"x2"},
    "x^2y":{"type":"number","default":1,"varname":"x2y"},
    "x^2y^2":{"type":"number","default":-13,"varname":"x2y2"},
    "x^2y^3":{"type":"number","default":1,"varname":"x2y3"},
    "x^3":{"type":"number","default":1,"varname":"x3"},
    "x^3y":{"type":"number","default":1,"varname":"x3y"},
    "x^3y^2":{"type":"number","default":1,"varname":"x3y2"},
    "x^4":{"type":"number","default":1,"varname":"x4"},
    "x^4y":{"type":"number","default":1,"varname":"x4y"},
    "x^5":{"type":"number","default":1,"varname":"x5"}
}


var coeffs = _.mapObject(seed, function(val,key) {
    return val.default;
});

var polynomial_string = _.reduce(
    _.filter(_.map(_.pairs(coeffs), function(coeff) {
        var s = coeff[1] == 1 ? coeff[0].toString() : coeff[1].toString()+coeff[0];
        if (coeff[1] == 0) s = '';
        return s;
    }), function(x) {
        return x != '';
    }), function(a,b) {
        var r = a;
        var bnum = parseInt(b.replace(/[^0-9\-]*/, '')) || 1;
        r += (bnum > 0 ? '+'+b : b);
        return r;
    }, '');

if (polynomial_string.substr(0,1) == '+') {
    polynomial_string = polynomial_string.substr(1, polynomial_string.length);
}

var Polynomial = {};
$.post("/symbolic_math/latex/", {
    expressionString: polynomial_string
}, function(data) {
    Polynomial = data;
    console.log(Polynomial)
});


DARK_GREY = new Color(0.3, 0.3, 0.3, 0.8);
LIGHT_GREY = new Color(0.9, 0.9, 0.9, 0.2);
view.viewSize = new Size(Canvas.width, Canvas.height);

x_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });
x_axis.add(new Point(-view.size.width/2, 0));
x_axis.add(new Point(view.size.width/2, 0));
x_axis.closed = true;
//project.activeLayer.insertChild(0,x_axis)

y_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });
y_axis.add(new Point(0, -view.size.height/2));
y_axis.add(new Point(0, view.size.height/2));

x_lines = [];
_.each(_.range(-10,10), function(n) {
    line = new Path({strokeColor: LIGHT_GREY });
    line.add( new Point(n, view.size.height/2) );
    line.add( new Point(n, -view.size.height/2) );
    line.closed = true;
    //project.activeLayer.insertChild(0, line);
    x_lines.push( line );
});

y_lines = [];
_.each(_.range(-10,10), function(n) {
    line = new Path({strokeColor: LIGHT_GREY });
    line.add( new Point(view.size.width/2, n) );
    line.add( new Point(-view.size.width/2, n) );
    line.closed = true;
    //project.activeLayer.insertChild(0, line);
    y_lines.push( line );
});

function transformToCartesian(lay) {
    lay.transform( new Matrix((view.size.width / 10),0,0,(view.size.height / -10), view.center.x, view.center.y) );
}

transformToCartesian(project.activeLayer);


// define formal mathematical function
MFunction = function(func, extrema) {
    //console.log(func.length);
    this.func = func;
    if (!extrema) { extrema = [-5,5]; }

    this.domain = {
        elements: [],
        min: (extrema[0] || -5),
        max: (extrema[1] || 5)
    };

    this.codomain = {
        elements: [],
        min: null,
        max: null
    };

    this.mapping = null;
}

MFunction.prototype = {
    
    compute: function(delta) {
        if (!delta) { delta = 50; }
        this.domain.elements = numeric.linspace(this.domain.min, this.domain.max, delta);
        this.codomain.elements = _.map(this.domain.elements, this.func);
        this.codomain.min = _.min(this.codomain.elements);
        this.codomain.max = _.max(this.codomain.elements);
        this.mapping = _.zip(this.domain.elements, this.codomain.elements);

        this._w = Math.abs(this.domain.max - this.domain.min);
        this._h = _.max(  [Math.abs(this.codomain.max),  Math.abs(this.codomain.min)]  );

        this.transformation_matrix = new Matrix(
            (view.size.width / this._w), 0,
            0, (view.size.height / (-1*this._h)), 
            view.center.x, view.center.y);

        this.computed = true;
        console.log("computed")
    },

    // "flattens" mapping
    // i.e. [[1,2],3] -> [1,2,3]
    getPoints: function() {
        if (!this.computed) { this.compute(); }
        this.points = _.map(this.mapping, function(pair) {
            return _.flatten(pair);
        });
        return this.points;
    },


    draw: function(path, matrix_premult, map3d, tmatrix) {

        if (!this.computed) { this.compute(); }

        if (map3d) {
            this.points = this.points3d;
        } else {
            this.points = this.getPoints();
        }

        if (matrix_premult) {
            this.points = _.map(this.points, function(p) {
                return numeric.dot(matrix_premult, p);
            })
        }

        _.each(this.points, function(p) {
            path.add(new Point(p));
        })

        path.add(new Point(this.domain.max*2, Math.abs(this.codomain.min)*-5 + Math.abs(this.codomain.max)*-5));
        path.add(new Point(this.domain.min*2, Math.abs(this.codomain.min)*-5 + Math.abs(this.codomain.max)*-5));
        path.closed = true;

        //path.transform(this.transformation_matrix);

        //path.smooth();
        
        if (tmatrix) {
            path.transform(tmatrix);
        } else {
            path.transform(this.transformation_matrix);
        } 
    }
}


function CartesianProduct(A,B) {
    prod = [];
    _.each(A, function(a) {
        _.each(B, function(b) {
            prod.push([a,b]);
        });
    });
    return prod;
}

BivariatePolynomialFunction = function(degree, vars, coeffs, roots) {


    if (roots) {
        // each set of roots must be <= degree in order
        factorsSym = [];
        _.each(roots[0], function(root) {
            factorsSym.push("("+vars[0]+"-"+root.toString()+")")
        });
        _.each(roots[1], function(root) {
            factorsSym.push("("+vars[1]+"-"+root.toString()+")")
        });
        latex = _.reduce(factorsSym, function(j,k) { return j.toString() + k.toString(); });

        f = function(x,z) {
            factors = [];
            _.each(roots[0], function(root) {
                factors.push( (x-root) );
            });
            _.each(roots[1], function(root) {
                factors.push( (z-root) );
            });
            return _.reduce(factors, function(j,k) { return j*k; });
        }
        f.latex = "f("+vars[0]+", "+vars[1]+")=" +latex.split('--').join('+');
        return f;

    } else {

        // num coeffs should be 1 less than degree-th triangular number
        term_exps = _.filter(CartesianProduct(_.range(degree+1), _.range(degree+1)),
            function(x) {
                return (x[0] + x[1]) <= degree && (x[0] + x[1]) != 0;
            });
        
        if (!coeffs) {
            coeffs = _.map(_.range(term_exps.length), function(i) {
                rand = (Math.random() * degree) - (degree/2);
                if (Math.random() > .4) return 0;
                return Math.round(rand*3);
            });
        }  
        
        terms_sym = _.map(term_exps, function(term, i) {
            if (coeffs[i] == 0) return "";
            if (coeffs[i] == 1) {
                coeff = "";
            } else if (coeffs[i] == -1) {
                coeff = "-"
            } else coeff = coeffs[i].toString();
            return coeff + " "
                + vars[0]+"^"+term[0].toString() + " "
                + vars[1]+"^"+term[1].toString();
        });
        terms_sym = _.filter(terms_sym, function(x) { return x != ""; })
        //console.log(terms_sym.join(" + "));

        f = function(x,z) {
            terms = _.map(term_exps, function(term, i) {
                return coeffs[i] * Math.pow(x, term[0]) * Math.pow(z, term[1]);
                });
            return _.reduce(terms, function(j,k) { return j+k; });
        }
        f.latex = terms_sym.join("+").split("+-").join("-").split("+").join(" + ");
        f.latex = f.latex.split("^1").join("");
        f.latex = "f("+vars[0]+", "+vars[1]+")=" + f.latex.split(/[a-z]\\^0/).join("");
        return f;
    }

}



// choose a polynomial
//Polynomial = new BivariatePolynomialFunction(3, ['x','y'], [1,-1,0,0,0,0,-2,3,1]);

var polynomial_degree = 5;

Polynomial = new BivariatePolynomialFunction(polynomial_degree, ['x','y']);//, null, [[2,3,0,-7,0],[1,-2, -4, -13]]);


$.post("/symbolic_math/latex/", {
    expressionString: 
}, function(data) {

});


slices = [];
zrange = [-15,0];
xrange = [-9, 9];
zspace = numeric.linspace(zrange[0], zrange[1], 50);

F0 = function(x) { return Polynomial(x,0); }
slice0 = new MFunction(F0, [xrange[0],xrange[1]]);
slice0.compute();
global_matrix = slice0.transformation_matrix;

CartesianMatrix = new Matrix(1,0,0,-1, view.center.x, view.center.y);

// begin drawing process
GraphLayer = new Layer({
     blendMode: "multiply",
});
//GraphLayer.globalMatrix = CartesianMatrix;
//GraphLayer.transform(CartesianMatrix);

console.log("global matrix"); console.log(global_matrix);

function_shown = false;
zindex=0

view.onFrame = function(event) {
    
    if (zindex < zspace.length) {
        
        //prevLayer = project.activeLayer;
        l = new Layer({
            //blendMode: "multiply"
        });

        z = zspace[zindex];
        //console.log(z)
    

        F = function(x) { return Polynomial(x,z); }
        slice = new MFunction(F, [xrange[0],xrange[1]]);

        points3d = slice.getPoints();
        _.each(_.range(points3d.length), function(i) { points3d[i].push(z); });

        slice.points3d = points3d

        transformation = [
            [1, 0, 0], //5*Math.cos(Math.PI/-4)],
            [0, 1, 0] //5*Math.sin(Math.PI/-4)],
        ];

        path1 = new Path({
            strokeColor: new Color(0.3, 0.3, 0.3, 0.5),
            strokeWidth: 1,
            closed: true,
            fillColor: new Color(Math.random(),1,Math.random(),0.2),
        });

        slice.draw(path1, transformation, true, global_matrix);
        //path.transform(CartesianMatrix)

        // transformation2 = new Matrix(
        //     1-(z/50), 0, 0, 1-(z/50), 0, 0 //5*Math.sin(Math.PI/-4)],
        // );

        transformation2 = new Matrix(
            1, 0, 0, 1, 0, 0 //5*Math.sin(Math.PI/-4)],
        );

        //path1.transform(transformation2);
        path1.scale(1-(z/50), 1-(z/50), view.center)
        path1.translate(new Point(-10*z, 30*z))
        
        project.activeLayer.insertChild(0,path1);

        slices.push({layer: project.activeLayer,
            func: slice,
            transformation: transformation,
            path: path1});

        //console.log(path.position)
        
        if (zindex == zspace.length-1) { 
            //console.log(slices);
            //view.pause();
        }
        zindex++;

        if (!function_shown) {
            if (display = document.getElementById("function-katex")) {
                //katex.render(Polynomial.latex, display);
                tokens = Polynomial.latex.split(" ");
                line_length = Math.ceil(tokens.length/2);
                line2 = tokens.splice(-1*line_length).join(" ");
                line1 = tokens.join(" ");
                $("#function-katex").text(
                    "$$" + line1 + "$$\
$$\\\\space \\\\space \\\\space \\\\space " + line2 + "$$ \
"
                     + "$$\\\\left(\\\\begin{array}{rrr}\
1 & 0 & \\\\frac{1}{2} \\\\, \\\\sqrt{2} \\\\\\\\\
0 & 1 & \\\\frac{1}{2} \\\\, \\\\sqrt{2}\\\\\\\\\
 \\\\end{array}\\\ight)$$");
                function_shown = true;
            }
        }
    }
    
}



////////////


function onResize(event) {

}