COPY game_zeroplayergame (id, title, description, created, category_id, owner_id, "scriptType", source, "seedStructure", "mainImage", parent_id, updated) FROM stdin;
5	Function in 1 variable with time parameter	Sets of graphs of a function in 1 variable with time as a parameter.  (Technically a function in 2 variables)	2016-02-02 19:11:30.899129-08	2	1	text/paperscript	/*
    *
    *   @author: nino p cocchiarella
    *   (c) 2016
    *
*/

view.viewSize = new Size(Canvas.width, Canvas.height);

// define formal mathematical function in 1 var
MFunction = function(func, extrema) {
   
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
    this.compute();
}

MFunction.prototype = {
    
    compute: function(delta) {
        if (!delta) { delta = 100; }

        eval("_func = function(x) { return "+this.func+"; };");

        this.domain.elements = numeric.linspace(this.domain.min, this.domain.max, delta);
        this.codomain.elements = _.map(this.domain.elements, _func);
        this.codomain.min = _.min(this.codomain.elements);
        this.codomain.max = _.max(this.codomain.elements);
        this.mapping = _.zip(this.domain.elements, this.codomain.elements);
    },

    draw: function(path, matrix_premult) {
        if (this.mapping == null) { this.compute(); }
        
        _w = Math.abs(this.domain.max - this.domain.min);
        _h = _.max(  [Math.abs(this.codomain.max),  Math.abs(this.codomain.min)]  );
    

        points = this.mapping;

        if (matrix_premult) {
            points = _.map(points, function(p) {
                return numeric.dot(matrix_premult, p);
            })
        }

        _.each(points, function(p) {
            path.add(new Point(p));
        });
        
        T = new Matrix(
            (view.size.width / _w), 0,
            0, (view.size.height / (-1*_h)), 
            view.center.x, view.center.y);

        project.activeLayer.transform(T); 
    }
}


func = new MFunction(funct, [xMin,xMax]);

// draw Cartesian axes
drawAxes = function(xmax, ymax) {

    if (xmax == undefined) xmax = 10;
    if (ymax == undefined) ymax = 10;

    DARK_GREY = new Color(0.3, 0.3, 0.3, 0.8);
    LIGHT_GREY = new Color(0.9, 0.9, 0.9, 0.2);

    x_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });
    x_axis.add(new Point(-view.size.width/2, 0));
    x_axis.add(new Point(view.size.width/2, 0));

    y_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });
    y_axis.add(new Point(0, -view.size.height/2));
    y_axis.add(new Point(0, view.size.height/2));

    _.each(_.range(-1*xmax,xmax), function(n) {
        var line = new Path({strokeColor: LIGHT_GREY });
        line.add( new Point(n, view.size.height/2) );
        line.add( new Point(n, -view.size.height/2) );
        line.closed = true;
    });


    _.each(_.range(-1*ymax,ymax), function(n) {
        var line = new Path({strokeColor: LIGHT_GREY });
        line.add( new Point(view.size.width/2, n) );
        line.add( new Point(-view.size.width/2, n) );
        line.closed = true;
    });


    project.activeLayer.transform( new Matrix((view.size.width / xmax),0,0,(view.size.height / (-1*ymax)), view.center.x, view.center.y) );

}
//executeRemotePaperscript("/static/site/js/app/graph-util.js");
drawAxes();

////////////////////////

INITCOLOR = _.map(_.range(3), Math.random)
N = 15;


graphs = [];

_.map(_.range(N), function(n) {

    layer = new Layer({
        backgroundColor: new Color(1,1,1,0)
    });

    thickness = (n == 0 ? 3 : 1)
    alpha = 0.5 - (n/(N*2))

    var graph = new Path({
        strokeColor: new Color(  INITCOLOR.concat([alpha]) ),
        strokeWidth: thickness
    });

    matrix = [[1,0],[0,(1-(n/N))]]
    func.draw(graph, matrix);
    graph.smooth();
    graphs.push(graph);

 });




////////////


function onResize(event) {

}

view.onFrame = function(event) {
    scale = 1 + (Math.sin(event.time)/ breathDelta)
    _.each(graphs, function(g) {
        g.scale(1, scale);
    });
}

window.onDestroy = function() {
\tproject.layers.forEach(function(lay) {
\t\tlay.remove();
\t}); 
}	{
    "breathDelta": {"default":17, "min":1.1, "max":1000},
    "funct": {"default": "x*Math.cos(x)"},
    "xMin": {"default": -5},
    "xMax": {"default": 5}
}		\N	2016-03-11 20:03:55.707658-08
24	2-dimensional Maze Generator and Solver	Uses DFS algorithm to create a unique maze each instance of running. Arrow keys let user navigate through and try to solve the maze. Automatic solving -- solution button presents the one and only one correct path.	2016-03-11 21:34:40.222228-08	1	1	text/javascript	/*

Maze Generator pseudo-code

1. Make the initial cell the current cell and mark it as visited
2. While there are unvisited cells
    1. If the current cell has any neighbors which have not been visited
        1. Choose randomly one of the unvisited neighbors
        2. Push the chosen cell to the stack
        3. Remove the wall between the current cell and the chosen cell
        4. Make the chosen cell the current cell and mark it as visited
    2. Otherwise
        1. Pop a cell from the stack
        2. Make it the current cell
*/

// class Maze {

function Maze(dimension, x, y, cellSize) {
    this.x = x;
    this.y = y;
    this.map = [];
    this.visited = [];
    this.stack = [];
    this.cellSize = cellSize;
    this.begin = [];
    this.turnArounds = [];
    this.currentPosition = [0, 0];
    this.ballRadius = this.cellSize * 0.4;
    this.linesDrawn = [];

    for (var i=0; i<y; i++) {
        this.map.push( [] );
        this.visited.push( [] );
        for (var j=0; j<x; j++) {
            this.map[i].push( [1,1,1,1] );
            this.visited[i].push( false );
        }
    }

    this.generateMap();
}

Maze.prototype.unvisitedCellsExist = function() {
    for (var i=0; i<this.y; i++) {
        for (var j=0; j<this.x; j++) {
            if (this.visited[i][j]) return true;
        }
    }
    return false;
};

Maze.prototype.chooseNeighbor = function(cx,cy) {
    var neighbors = [];
    var directions = [];
    if (cx > 0 && !this.visited[cy][cx-1]) 
        { neighbors.push( [cx-1, cy] ); directions.push('W'); }
    if (cx < this.x-1 && !this.visited[cy][cx+1]) 
        { neighbors.push( [cx+1, cy] ); directions.push('E'); }
    if (cy < this.y-1 && !this.visited[cy+1][cx]) 
        { neighbors.push( [cx, cy+1] ); directions.push('S'); }
    if (cy > 0 && !this.visited[cy-1][cx]) 
        { neighbors.push( [cx, cy-1] ); directions.push('N'); }
    if (neighbors.length) {
        r = Math.floor(Math.random()*neighbors.length);
        return [ neighbors[r], directions[r] ];
    } else return false;
};

Maze.prototype.removeWall = function(x1, y1, direction) { 
    switch (direction) {
        case 'N':
            this.map[y1][x1][0] = 0;
            this.map[y1-1][x1][2] = 0;
        break;
        case 'E':
            this.map[y1][x1][1] = 0;
            this.map[y1][x1+1][3] = 0;
        break;
        case 'S':
            this.map[y1][x1][2] = 0;
            this.map[y1+1][x1][0] = 0;
        break;
        case 'W':
            this.map[y1][x1][3] = 0;
            this.map[y1][x1-1][1] = 0;
        break;
    }
};

Maze.prototype.generateMap = function() {
    
    // choose initial cell
    var rx = Math.floor(Math.random()*this.x);
    var ry = Math.floor(Math.random()*this.y);

    this.begin = [rx, ry];

    var cx = rx;
    var cy = ry;
    var nx;
    var ny;

    this.visited[cy][cx] = true;

    var next;
    var nextDirection;

    // while there are still unvisited cells
    while (this.unvisitedCellsExist()) {
        if (this.chooseNeighbor(cx,cy)) {
            
            next = this.chooseNeighbor(cx,cy);
            
            nx = next[0][0];
            ny = next[0][1];
            
            nextDirection = next[1];
            this.stack.push( [nx, ny] );
            this.removeWall(cx, cy, nextDirection);
            this.visited[ny][nx] = true;

            cx = nx;
            cy = ny;
        
        } else if (this.stack.length) {

            next = this.stack.pop();
            cx = next[0];
            cy = next[1];
            this.turnArounds.push([cx, cy]);
          
        } else break;
    }

    this.end = [cx, cy];
    this.map[0][0][3] = 0;
    this.map[this.y-1][this.x-1][1] = 0;

};

Maze.prototype.getClearRect = function(cx, cy) {
    var fx = cx * this.cellSize + (this.cellSize/2) - (this.ballRadius) - 1;
    var fy = cy * this.cellSize + (this.cellSize/2) - (this.ballRadius) - 1;
    return [fx,fy];
};

Maze.prototype.getBallCoords = function(nx, ny) {
    var bx = nx * this.cellSize + (this.cellSize/2);
    var by = ny * this.cellSize + (this.cellSize/2);
    return [bx,by];
};

Maze.prototype.clearBall = function() {
    var cl = this.getClearRect(this.currentPosition[0], this.currentPosition[1]);
    ctx.clearRect(cl[0], cl[1], this.ballRadius*2+2, this.ballRadius*2+2);
};

Maze.prototype.drawBall = function() {
    var ballCoords = this.getBallCoords(this.currentPosition[0], this.currentPosition[1]);
    ctx.beginPath();
    ctx.arc(ballCoords[0], ballCoords[1], this.ballRadius, 0, 2*Math.PI, false);
    ctx.fillStyle = 'green';
    ctx.fill();
    ctx.lineWidth = 1;
    ctx.strokeStyle = '#003300';
    ctx.stroke();
};

Maze.prototype.move = function(d) {
    var dx = d[0];
    var dy = d[1];
    this.clearBall();
    this.currentPosition = [this.currentPosition[0]+dx, this.currentPosition[1]+dy];
    this.drawBall();
};

Maze.prototype.lineIsDrawn = function(mt, lt) {
    for (var i=0; i<this.linesDrawn.length; i++) {
        if (this.linesDrawn[i][0][0] == mt[0] &&
            this.linesDrawn[i][0][1] == mt[1] &&
            this.linesDrawn[i][1][0] == lt[0] &&
            this.linesDrawn[i][1][1] == lt[1]) {

            return true;
        }
    }
    return false;
};

Maze.prototype.render = function(ctx) {
    
    var cell;
    var cx;
    var cy;

    ctx.moveTo(0,0);
    ctx.lineWidth = 1;
    ctx.strokeStyle = '#666666';
    
    for (var i=0; i<this.y; i++) {
        for (var j=0; j<this.x; j++) {
            
            ctx.beginPath();
            cell = this.map[i][j];
            cx = this.cellSize * j;
            cy = this.cellSize * i;
            var mt;
            var lt;

            if (cell[0]) {
                mt = [cx, cy];
                lt = [cx+this.cellSize, cy];
                if (!this.lineIsDrawn(mt, lt)) {
                    this.linesDrawn.push([mt, lt]);
                    ctx.moveTo(mt[0], mt[1]);
                    ctx.lineTo(lt[0], lt[1]);
                    ctx.stroke();
                }
            } 
            if (cell[1]) {
                mt = [cx+this.cellSize, cy];
                lt = [cx+this.cellSize, cy+this.cellSize];
                if (!this.lineIsDrawn(mt, lt)) {
                    this.linesDrawn.push([mt, lt]);
                    ctx.moveTo(mt[0], mt[1]);
                    ctx.lineTo(lt[0], lt[1]);
                    ctx.stroke();
                }
            } 
            if (cell[2]) {
                mt = [cx+this.cellSize, cy+this.cellSize];
                lt = [cx, cy+this.cellSize];
                if (!this.lineIsDrawn(mt, lt)) {
                    this.linesDrawn.push([mt, lt]);
                    ctx.moveTo(mt[0], mt[1]);
                    ctx.lineTo(lt[0], lt[1]);
                    ctx.stroke();
                }
            }
            if (cell[3]) {
                mt = [cx, cy+this.cellSize];
                lt = [cx, cy];
                if (!this.lineIsDrawn(mt, lt)) {
                    this.linesDrawn.push([mt, lt]);
                    ctx.moveTo(mt[0], mt[1]);
                    ctx.lineTo(lt[0], lt[1]);
                    ctx.stroke();
                }
            }

        }
    }

    this.move([0,0]);

};

// } end class Maze

/*
    MazeSolver pseudo-code

    1. start at the entrance
    2. while not at the exit
        1. push the current cell to visited
        2. if exists one or more directions that have not been visited
            1. push the current cell to pathStack
            2. choose any direction from those not visited
            3. move in that direction
            4. draw path from previous cell to chosen cell
            5. make the chosen cell the current cell
        3. otherwise backtrack
            1. pop the pathStack
            2. remove line from currentCell to popped cell
            3. do not remove popped cell from visited
*/

// class MazeSolver {

function MazeSolver(maze) {
    this.Maze = maze;
    this.position = [0, 0];
    this.pathStack = [];
    this.visited = [];
    this.Maze.clearBall();

    var self = this;
    this.solveStep = function() {
        self.moveForward();
    };
}

MazeSolver.prototype.getValidDirections = function(x,y) {
    
    var directions = [];
    
    if (!this.Maze.map[y][x][0]) 
        directions.push([0,-1]);
    if (!this.Maze.map[y][x][1] && (x!=this.Maze.x-1 || y!=this.Maze.y-1)) 
        directions.push([1,0]);
    if (!this.Maze.map[y][x][2]) 
        directions.push([0,1]);
    if (!this.Maze.map[y][x][3] && (x||y)) 
        directions.push([-1,0]);

    var validDirections = [];
    for (var i=0; i<directions.length; i++) {
        var tx = x+directions[i][0];
        var ty = y+directions[i][1];
        if (!this.isVisited(tx,ty)) {
            validDirections.push(directions[i]);
        }
    }

    return validDirections;
};

MazeSolver.prototype.isVisited = function(x,y) {
    for (var i=0; i<this.visited.length; i++) {
        if (this.visited[i][0] == x && this.visited[i][1] == y) 
            return true;
    }
    return false;
};

MazeSolver.prototype.isDeadEnd = function(x,y) {
    if (!this.getValidDirections(x,y).length)
        return true;
    return false;
};

MazeSolver.prototype.movePath = function(cx,cy,nx,ny) {
    ctx.lineWidth = 4;
    ctx.strokeStyle = solutionPathColor;
    ctx.beginPath();

    ctx.moveTo(cx*this.Maze.cellSize+this.Maze.cellSize/2, 
        cy*this.Maze.cellSize+this.Maze.cellSize/2);
    ctx.lineTo(nx*this.Maze.cellSize+this.Maze.cellSize/2, 
        ny*this.Maze.cellSize+this.Maze.cellSize/2);
    ctx.stroke();
};

MazeSolver.prototype.clearPath = function(x,y) {
    ctx.clearRect(x*this.Maze.cellSize+2, y*this.Maze.cellSize+2, 
        this.Maze.cellSize-4, this.Maze.cellSize-4);
};

MazeSolver.prototype.isFinished = function() {
    if (this.position[0] == this.Maze.x-1 && this.position[1] == this.Maze.y-1)
        return true;
    return false;
};

MazeSolver.prototype.moveForward = function() {
    
    var cx = this.position[0];
    var cy = this.position[1];
    
    this.visited.push([cx,cy]);
    
    if (this.isFinished()) {
        console.log("FINISH");
        clearInterval(this.interval);
        return;
    }

    if (!this.isDeadEnd(cx,cy)) {
        this.pathStack.push([cx,cy]);
        var directions = this.getValidDirections(cx,cy);
        var randomDirection = Math.floor(Math.random()*directions.length);
        
        var nx = cx + directions[randomDirection][0];
        var ny = cy + directions[randomDirection][1];

        this.movePath(cx,cy,nx,ny);
        this.position = [nx,ny];

    } else { 
        this.backtrack();
    }
};

MazeSolver.prototype.backtrack = function() {
    var lastCell = this.pathStack.pop();
    this.clearPath(this.position[0], this.position[1]);
    this.position = [lastCell[0], lastCell[1]];
};

// } end class MazeSolver




function solveMaze() {
    solver = new MazeSolver(Maze);
    solver.interval = setInterval(solver.solveStep, 5);
}

var Maze;
var ctx = Canvas.getContext("2d");
var solver;

ctx.fillStyle = '#ffffff'
ctx.fillRect(0,0,Canvas.width, Canvas.height)



var mx = Math.floor((Canvas.width) / cellSize);
var my = Math.floor((Canvas.height) / cellSize);

console.log([Canvas.height, $(window).height(), mx, my]);

Maze = new Maze(2, mx, my, cellSize);
Maze.render(ctx);

$(window).keydown(function(e) {
            
    var tx = Maze.currentPosition[0];
    var ty = Maze.currentPosition[1];

    switch (e.keyCode) {

        case 37: // left
            if (!Maze.map[ty][tx][3]) Maze.move([-1,0]);
        break;
        case 38: // up
            if (!Maze.map[ty][tx][0]) Maze.move([0,-1]);
        break;
        case 39: // right
            if (!Maze.map[ty][tx][1]) Maze.move([1,0]);
        break;
        case 40: // down
            if (!Maze.map[ty][tx][2]) Maze.move([0,1]);
        break;
        case 83: // 's' key
            solver = new MazeSolver(Maze);
            solver.interval = setInterval(solver.solveStep, 5);
        break;

    }
});	{
    "cellSize": {"min": 5, "max": 150, "default": 30},
    "solutionPathColor": {"default": "rgba(0,0,200,0.8)"}
}	\N	\N	2016-03-12 03:22:11.854548-08
25	Neenbox	just some stooopid boxes	2016-03-12 05:09:56.958477-08	2	1	text/javascript	


var ctx = Canvas.getContext('2d')
ctx.fillStyle = '#cccc00';
ctx.fillRect(10, 20, 400, 400);	{"param1":{"default":""}}	\N	\N	2016-03-12 05:09:56.958528-08
4	Multivariate Polynomial Landscape	Choose coefficients of high-degree a polynomial function in 2 variables, as well as the 3x3 matrix used to project the graph of the surface onto a 2-dimensional canvas.  Many intricate and beautiful scenes emerge with certain affine transformations.  Defaults to a "standard" parallel projection of the z-axis (the axis "coming out of the screen")	2016-02-02 21:50:13.820034-08	2	1	text/paperscript	

DARK_GREY = new Color(0.3, 0.3, 0.3, 0.8);
LIGHT_GREY = new Color(0.9, 0.9, 0.9, 0.2);
console.log(paper.Matrix)
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
Function = function(func, extrema) {
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

Function.prototype = {
    
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
Polynomial = new BivariatePolynomialFunction(5, ['x','y']);//, null, [[2,3,0,-7,0],[1,-2, -4, -13]]);


slices = [];
zrange = [-15,0];
xrange = [-9, 9];
zspace = numeric.linspace(zrange[0], zrange[1], 50);

F0 = function(x) { return Polynomial(x,0); }
slice0 = new Function(F0, [xrange[0],xrange[1]]);
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
        slice = new Function(F, [xrange[0],xrange[1]]);

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

}	{
  "x1": {"default": 5}
}		\N	2016-03-06 14:23:06.253224-08
2	3-dimensional "Wolfenstein" Maze Generator	Generates a unique random 3-dimensional maze each instance. Allows user to navigate through maze with old-fashioned "Wolfenstein"-style interface. Collision detection built in.	2016-02-04 00:16:14.056506-08	1	1	text/javascript	/*

        Maze Generator pseudo-code

        1. Make the initial cell the current cell and mark it as visited
        2. While there are unvisited cells
            1. If the current cell has any neighbors which have not been visited
                1. Choose randomly one of the unvisited neighbors
                2. Push the chosen cell to the stack
                3. Remove the wall between the current cell and the chosen cell
                4. Make the chosen cell the current cell and mark it as visited
            2. Otherwise
                1. Pop a cell from the stack
                2. Make it the current cell
        */

        // class Maze {

        function Maze(dimension, x, y, cellSize) {
            this.x = x;
            this.y = y;
            this.map = [];
            this.visited = [];
            this.stack = [];
            this.cellSize = cellSize;
            this.begin = [];
            this.turnArounds = [];
            this.currentPosition = [0, 0];
            this.ballRadius = this.cellSize * 0.4;
            this.wallsRendered = [];
            this.grass;
            this.sky;
            this.collisionPadding = 20;
            this.playerCurrentCell = [0, 0];
            this.atWall = false;
            this.directionUnlocked = 0;
            this.approachQuadrant = 0;

            for (var i=0; i<y; i++) {
                this.map.push( [] );
                this.visited.push( [] );
                for (var j=0; j<x; j++) {
                    this.map[i].push( [1,1,1,1] );
                    this.visited[i].push( false );
                }
            }

            this.generateMap();
        }

        Maze.prototype.unvisitedCellsExist = function() {
            for (var i=0; i<this.y; i++) {
                for (var j=0; j<this.x; j++) {
                    if (this.visited[i][j]) return true;
                }
            }
            return false;
        };

        Maze.prototype.chooseNeighbor = function(cx,cy) {
            var neighbors = [];
            var directions = [];
            if (cx > 0 && !this.visited[cy][cx-1]) 
                { neighbors.push( [cx-1, cy] ); directions.push('W'); }
            if (cx < this.x-1 && !this.visited[cy][cx+1]) 
                { neighbors.push( [cx+1, cy] ); directions.push('E'); }
            if (cy < this.y-1 && !this.visited[cy+1][cx]) 
                { neighbors.push( [cx, cy+1] ); directions.push('S'); }
            if (cy > 0 && !this.visited[cy-1][cx]) 
                { neighbors.push( [cx, cy-1] ); directions.push('N'); }
            if (neighbors.length) {
                r = Math.floor(Math.random()*neighbors.length);
                return [ neighbors[r], directions[r] ];
            } else return false;
        };

        Maze.prototype.removeWall = function(x1, y1, direction) { 
            switch (direction) {
                case 'N':
                    this.map[y1][x1][0] = 0;
                    this.map[y1-1][x1][2] = 0;
                break;
                case 'E':
                    this.map[y1][x1][1] = 0;
                    this.map[y1][x1+1][3] = 0;
                break;
                case 'S':
                    this.map[y1][x1][2] = 0;
                    this.map[y1+1][x1][0] = 0;
                break;
                case 'W':
                    this.map[y1][x1][3] = 0;
                    this.map[y1][x1-1][1] = 0;
                break;
            }
        };

        Maze.prototype.generateMap = function() {
            
            // choose initial cell
            var rx = Math.floor(Math.random()*this.x);
            var ry = Math.floor(Math.random()*this.y);

            this.begin = [rx, ry];

            var cx = rx;
            var cy = ry;
            var nx;
            var ny;

            this.visited[cy][cx] = true;

            var next;
            var nextDirection;

            // while there are still unvisited cells
            while (this.unvisitedCellsExist()) {
                if (this.chooseNeighbor(cx,cy)) {
                    
                    next = this.chooseNeighbor(cx,cy);
                    
                    nx = next[0][0];
                    ny = next[0][1];
                    
                    nextDirection = next[1];
                    this.stack.push( [nx, ny] );
                    this.removeWall(cx, cy, nextDirection);
                    this.visited[ny][nx] = true;

                    cx = nx;
                    cy = ny;
                
                } else if (this.stack.length) {

                    next = this.stack.pop();
                    cx = next[0];
                    cy = next[1];
                    this.turnArounds.push([cx, cy]);
                  
                } else break;
            }

            this.end = [cx, cy];
            this.map[0][0][3] = 0;
            this.map[this.y-1][this.x-1][1] = 0;

        };

        Maze.prototype.getClearRect = function(cx, cy) {
            var fx = cx * this.cellSize + (this.cellSize/2) - (this.ballRadius) - 1;
            var fy = cy * this.cellSize + (this.cellSize/2) - (this.ballRadius) - 1;
            return [fx,fy];
        };

        Maze.prototype.getBallCoords = function(nx, ny) {
            var bx = nx * this.cellSize + (this.cellSize/2);
            var by = ny * this.cellSize + (this.cellSize/2);
            return [bx,by];
        };

        Maze.prototype.clearBall = function() {
            var cl = this.getClearRect(this.currentPosition[0], this.currentPosition[1]);
            ctx.clearRect(cl[0], cl[1], this.ballRadius*2+2, this.ballRadius*2+2);
        };

        Maze.prototype.drawBall = function() {
            var ballCoords = this.getBallCoords(this.currentPosition[0], this.currentPosition[1]);
            ctx.beginPath();
            ctx.arc(ballCoords[0], ballCoords[1], this.ballRadius, 0, 2*Math.PI, false);
            ctx.fillStyle = 'green';
            ctx.fill();
            ctx.lineWidth = 1;
            ctx.strokeStyle = '#003300';
            ctx.stroke();
        };

        Maze.prototype.move = function(d) {
            var dx = d[0];
            var dy = d[1];
            this.clearBall();
            this.currentPosition = [this.currentPosition[0]+dx, this.currentPosition[1]+dy];
            this.drawBall();
        };

        Maze.prototype.wallIsRendered = function(mt, lt) {
            for (var i=0; i<this.wallsRendered.length; i++) {
                if (this.wallsRendered[i][0][0] == mt[0] &&
                    this.wallsRendered[i][0][1] == mt[1] &&
                    this.wallsRendered[i][1][0] == lt[0] &&
                    this.wallsRendered[i][1][1] == lt[1]) {

                    return true;
                }
            }
            return false;
        };

        Maze.prototype.getQuadrant = function(theta) {
            if (theta <= (Math.PI/2)) return 1;
            if (theta <= Math.PI) return 2;
            if (theta <= (Math.PI*3)/2) return 3;
            if (theta <= (Math.PI*2)) return 4;
        }

        Maze.prototype.getOppositeQuad = function(quad) {
            if (quad == 1) return 3;
            if (quad == 2) return 4;
            if (quad == 3) return 1;
            if (quad == 4) return 2;
        }

        Maze.prototype.isDirectionValid = function(direction) {
            
            var currentAngle = (((Math.PI*3)/2) - camera.rotation.y) % (2*Math.PI);
            if (currentAngle < 0) currentAngle += (2*Math.PI);
            var currentQuad = this.getQuadrant(currentAngle);

            // if at a wall, handle wall vs. direction, then return false
            if (this.atWall) {

                switch (this.atWall) {
                    case 'N':
                        if ((currentQuad == 3 || currentQuad == 4) && direction == 1)
                            return true;
                        if ((currentQuad == 1 || currentQuad == 2) && direction == -1)
                            return true;
                        if (currentQuad == 1)
                            camera.position.x += 10;
                        if (currentQuad == 2)
                            camera.position.x -= 10;
                        return false;
                    break;
                    case 'E':
                        if ((currentQuad == 2 || currentQuad == 3) && direction == 1)
                            return true;
                        if ((currentQuad == 1 || currentQuad == 4) && direction == -1)
                            return true;
                        if (currentQuad == 1)
                            camera.position.z -= 10;
                        if (currentQuad == 4)
                            camera.position.z += 10;
                        return false;
                    break;
                    case 'S':
                        if ((currentQuad == 1 || currentQuad == 2) && direction == 1)
                            return true;
                        if ((currentQuad == 3 || currentQuad == 4) && direction == -1)
                            return true;
                        if (currentQuad == 3)
                            camera.position.x -= 10;
                        if (currentQuad == 4)
                            camera.position.x += 10;
                        return false;
                    break;
                    case 'W':
                        if ((currentQuad == 1 || currentQuad == 4) && direction == 1)
                            return true;
                        if ((currentQuad == 2 || currentQuad == 3) && direction == -1)
                            return true;
                        if (currentQuad == 2)
                            camera.position.z -= 10;
                        if (currentQuad == 3)
                            camera.position.z += 10;
                        return false;
                    break;
                }

                return false;

            }

            return true;

        };

        Maze.prototype.checkWallCollision = function() {
            
            // figure out which cell player is in
            var playerX = Math.floor(camera.position.x / this.cellSize) + (this.x/2);
            var playerZ = Math.floor(camera.position.z / this.cellSize) + (this.y/2);

            // mark cell as current cell if not already
            if (playerX != this.playerCurrentCell[0] || playerZ != this.playerCurrentCell[1]) {
                this.playerCurrentCell = [playerX, playerZ];
                console.log('entered cell ' + playerX + ', ' + playerZ);
            }

            // get walls in current cell
            var walls = this.map[this.playerCurrentCell[1]][this.playerCurrentCell[0]];

            // get global boundary coords
            var bounds = [];
            bounds.push((this.playerCurrentCell[1] * this.cellSize - 
                ((this.y*this.cellSize)/2)) + this.collisionPadding);
            bounds.push((this.playerCurrentCell[0] * this.cellSize - 
                ((this.x*this.cellSize)/2)) + this.cellSize - this.collisionPadding);
            bounds.push((this.playerCurrentCell[1] * this.cellSize - 
                ((this.y*this.cellSize)/2)) + this.cellSize - this.collisionPadding);
            bounds.push((this.playerCurrentCell[0] * this.cellSize - 
                ((this.x*this.cellSize)/2)) + this.collisionPadding);

            
            // test each wall for collision
            var whichWall = false;

            if (walls[0] && camera.position.z <= bounds[0]) {
                console.log('hit north wall');
                whichWall = 'N';
            }
            if (walls[1] && camera.position.x >= bounds[1]) {
                console.log('hit east wall');
                whichWall = 'E';
            }
            if (walls[2] && camera.position.z >= bounds[2]) {
                console.log('hit south wall');
                whichWall = 'S';
            }
            if (walls[3] && camera.position.x <= bounds[3]) {
                console.log('hit west wall');
                whichWall = 'W';
            }

            this.atWall = whichWall;
        };

        Maze.prototype.render = function(ctx) {
            
            var cell;
            var cx;
            var cy;

            var geometry, texture, mesh;

            // draw grass
            geometry = new THREE.BoxGeometry(this.x*this.cellSize, 10, this.y*this.cellSize);
            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/grass.jpg');
            texture.anisotropy = renderer.getMaxAnisotropy();
            material = new THREE.MeshBasicMaterial( { map: texture } );
            this.grass = new THREE.Mesh( geometry, material );
            this.grass.position.set(0, -100, 0); 
            scene.add( this.grass );

            // draw sky
            var skyRadius;
            if (this.y > this.x) {
                skyRadius = (this.y*this.cellSize);
            } else skyRadius = (this.x*this.cellSize); 
            
            geometry = new THREE.SphereGeometry(skyRadius, 16, 16, Math.PI/2,  Math.PI*2, 0, Math.PI);
            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/sky.jpg');
            texture.anisotropy = renderer.getMaxAnisotropy();
            material = new THREE.MeshBasicMaterial( {map: texture} );
            material.side = THREE.BackSide
            this.sky = new THREE.Mesh(geometry, material);
            this.sky.position.set(0,0,0);
            scene.add(this.sky);

            for (var i=0; i<this.y; i++) {
                for (var j=0; j<this.x; j++) {
                    
                    cell = this.map[i][j];
                    cx = this.cellSize * j - ((this.x*this.cellSize)/2);
                    cy = this.cellSize * i - ((this.y*this.cellSize)/2);
                    var mt;
                    var lt;

                    if (cell[0]) {
                        mt = [cx, cy];
                        lt = [cx+this.cellSize, cy];
                        if (!this.wallIsRendered(mt, lt)) {
                            geometry = new THREE.BoxGeometry(  200, 200, 10  );
                            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/wood.jpg');
                            texture.anisotropy = renderer.getMaxAnisotropy();
                            material = new THREE.MeshBasicMaterial( { map: texture } );
                            mesh = new THREE.Mesh( geometry, material );
                            mesh.position.set(mt[0]+this.cellSize/2, 0, mt[1]); 
                            scene.add( mesh );
                        }
                    } 
                    if (cell[1]) {
                        mt = [cx+this.cellSize, cy];
                        lt = [cx+this.cellSize, cy+this.cellSize];
                        if (!this.wallIsRendered(mt, lt)) {
                            geometry = new THREE.BoxGeometry(  10, 200, 200  );
                            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/wood.jpg');
                            texture.anisotropy = renderer.getMaxAnisotropy();
                            material = new THREE.MeshBasicMaterial( { map: texture } );
                            mesh = new THREE.Mesh( geometry, material );
                            mesh.position.set(mt[0], 0, mt[1]+this.cellSize/2); 
                            scene.add( mesh );
                        }
                    } 
                    if (cell[2]) {
                        mt = [cx+this.cellSize, cy+this.cellSize];
                        lt = [cx, cy+this.cellSize];
                        if (!this.wallIsRendered(mt, lt)) {
                            geometry = new THREE.BoxGeometry(  200, 200, 10  );
                            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/crate.gif');
                            texture.anisotropy = renderer.getMaxAnisotropy();
                            material = new THREE.MeshBasicMaterial( { map: texture } );
                            mesh = new THREE.Mesh( geometry, material );
                            mesh.position.set(mt[0]-this.cellSize/2, 0, mt[1]); 
                            scene.add( mesh );
                        }
                    }
                    if (cell[3]) {
                        mt = [cx, cy+this.cellSize];
                        lt = [cx, cy];
                        if (!this.wallIsRendered(mt, lt)) {
                            geometry = new THREE.BoxGeometry(  10, 200, 200  );
                            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/crate.gif');
                            texture.anisotropy = renderer.getMaxAnisotropy();
                            material = new THREE.MeshBasicMaterial( { map: texture } );
                            mesh = new THREE.Mesh( geometry, material );
                            mesh.position.set(mt[0], 0, mt[1]-this.cellSize/2); 
                            scene.add( mesh );
                        }
                    }

                }
            }
        };

        Maze.prototype.walkForward = function() {
            this.checkWallCollision();
            if (this.isDirectionValid(1)) {
                camera.position.x -= 10 * Math.sin(camera.rotation.y);
                camera.position.z += 10 * Math.cos(camera.rotation.y);
                console.log('F');
            }
        };

        Maze.prototype.walkBackwards = function() {
            this.checkWallCollision();
            if (this.isDirectionValid(-1)) {
                camera.position.x += 10 * Math.sin(camera.rotation.y);
                camera.position.z -= 10 * Math.cos(camera.rotation.y);
                console.log('B');
            }
        };

        Maze.prototype.turnLeft = function() {
            camera.rotation.y -= Math.PI / 10;
        };

        Maze.prototype.turnRight = function() {
            camera.rotation.y += Math.PI / 10;
        };

        Maze.prototype.flyUp = function() {
            camera.position.y += 10;
        };

        Maze.prototype.flyDown = function() {
            camera.position.y -= 10;
        };

        // } end class Maze

        /*
            MazeSolver pseudo-code

            1. start at the entrance
            2. while not at the exit
                1. push the current cell to visited
                2. if exists one or more directions that have not been visited
                    1. push the current cell to pathStack
                    2. choose any direction from those not visited
                    3. move in that direction
                    4. draw path from previous cell to chosen cell
                    5. make the chosen cell the current cell
                3. otherwise backtrack
                    1. pop the pathStack
                    2. remove line from currentCell to popped cell
                    3. do not remove popped cell from visited
        */

        // class MazeSolver {

        function MazeSolver(maze) {
            this.Maze = maze;
            this.position = [0, 0];
            this.pathStack = [];
            this.visited = [];
            this.Maze.clearBall();

            var self = this;
            this.solveStep = function() {
                self.moveForward();
            };
        }

        MazeSolver.prototype.getValidDirections = function(x,y) {
            
            var directions = [];
            
            if (!this.Maze.map[y][x][0]) 
                directions.push([0,-1]);
            if (!this.Maze.map[y][x][1] && (x!=this.Maze.x-1 || y!=this.Maze.y-1)) 
                directions.push([1,0]);
            if (!this.Maze.map[y][x][2]) 
                directions.push([0,1]);
            if (!this.Maze.map[y][x][3] && (x||y)) 
                directions.push([-1,0]);

            var validDirections = [];
            for (var i=0; i<directions.length; i++) {
                var tx = x+directions[i][0];
                var ty = y+directions[i][1];
                if (!this.isVisited(tx,ty)) {
                    validDirections.push(directions[i]);
                }
            }

            return validDirections;
        };

        MazeSolver.prototype.isVisited = function(x,y) {
            for (var i=0; i<this.visited.length; i++) {
                if (this.visited[i][0] == x && this.visited[i][1] == y) 
                    return true;
            }
            return false;
        };

        MazeSolver.prototype.isDeadEnd = function(x,y) {
            if (!this.getValidDirections(x,y).length)
                return true;
            return false;
        };

        MazeSolver.prototype.movePath = function(cx,cy,nx,ny) {
            ctx.lineWidth = 4;
            ctx.strokeStyle = '#5555ff';
            ctx.beginPath();

            ctx.moveTo(cx*this.Maze.cellSize+this.Maze.cellSize/2, 
                cy*this.Maze.cellSize+this.Maze.cellSize/2);
            ctx.lineTo(nx*this.Maze.cellSize+this.Maze.cellSize/2, 
                ny*this.Maze.cellSize+this.Maze.cellSize/2);
            ctx.stroke();
        };

        MazeSolver.prototype.clearPath = function(x,y) {
            ctx.clearRect(x*this.Maze.cellSize+2, y*this.Maze.cellSize+2, 
                this.Maze.cellSize-4, this.Maze.cellSize-4);
        };

        MazeSolver.prototype.isFinished = function() {
            if (this.position[0] == this.Maze.x-1 && this.position[1] == this.Maze.y-1)
                return true;
            return false;
        };

        MazeSolver.prototype.moveForward = function() {
            
            var cx = this.position[0];
            var cy = this.position[1];
            
            this.visited.push([cx,cy]);
            
            if (this.isFinished()) {
                console.log("FINISH");
                clearInterval(this.interval);
                return;
            }

            if (!this.isDeadEnd(cx,cy)) {
                this.pathStack.push([cx,cy]);
                var directions = this.getValidDirections(cx,cy);
                var randomDirection = Math.floor(Math.random()*directions.length);
                
                var nx = cx + directions[randomDirection][0];
                var ny = cy + directions[randomDirection][1];

                this.movePath(cx,cy,nx,ny);
                this.position = [nx,ny];

            } else { 
                this.backtrack();
            }
        };

        MazeSolver.prototype.backtrack = function() {
            var lastCell = this.pathStack.pop();
            this.clearPath(this.position[0], this.position[1]);
            this.position = [lastCell[0], lastCell[1]];
        };

        // } end class MazeSolver


        $(document).keydown(function(e) {
            
            var tx = Maze.currentPosition[0];
            var ty = Maze.currentPosition[1];

            switch (e.keyCode) {

                case 37: // left
                    Maze.turnLeft();
                break;
                case 38: // up (forward)
                    Maze.walkForward();
                break;
                case 39: // right
                    Maze.turnRight();
                break;
                case 40: // down (backwards)
                    Maze.walkBackwards();
                break;
                case 65: // 'a' key
                    Maze.flyUp();
                break;
                case 90: // 'z' key
                    Maze.flyDown();
                break;

            }
        });

        function solveMaze() {
            solver = new MazeSolver(Maze);
            solver.interval = setInterval(solver.solveStep, 5);
        }

        var Maze;
        

        var ctx;
        var solver;

        var camera, scene, renderer;
        var mesh;

function onWindowResize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize( window.innerWidth, window.innerHeight );
}

function animate() {
  requestAnimationFrame(animate);
  renderer.render(scene, camera);
}

    
    var cellSize = 200;

renderer = new THREE.WebGLRenderer({
    preserveDrawingBuffer: true
});
renderer.setSize( Canvas.width, Canvas.height );
console.log(renderer.domElement); console.log('-----');
document.body.appendChild( renderer.domElement );

window._renderer = renderer;

camera = new THREE.PerspectiveCamera( 90, window.innerWidth / window.innerHeight, 1, 10000 );
scene = new THREE.Scene();

Maze = new Maze(2, 16, 10, cellSize);
Maze.render();

camera.position.x = Maze.cellSize * Maze.x * -0.5;
camera.position.y = 15;
camera.position.z = Maze.cellSize * Maze.y * -0.5 + Maze.cellSize/2;

camera.lookAt(scene.position);
window.addEventListener( 'resize', onWindowResize, false );
animate();	{}		\N	2016-02-29 18:57:30.047799-08
\.
