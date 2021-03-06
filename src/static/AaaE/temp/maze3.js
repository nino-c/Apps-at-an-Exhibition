/*

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
    preserveDrawingBuffer: true,
});
var __renderer = $(renderer);

renderer.setSize( Canvas.width, Canvas.height );
console.log(renderer.domElement); console.log('-----');
document.body.appendChild( renderer.domElement );

window._renderer = renderer;

camera = new THREE.PerspectiveCamera( 90, 
	window.innerWidth / window.innerHeight, 1, 10000 );
scene = new THREE.Scene();

Maze = new Maze(2, 16, 10, cellSize);
Maze.render();

camera.position.x = Maze.cellSize * Maze.x * -0.5;
camera.position.y = 15;
camera.position.z = Maze.cellSize * Maze.y * -0.5 + Maze.cellSize/2;

camera.lookAt(scene.position);
window.addEventListener( 'resize', onWindowResize, false );
animate();

window.appdestroy = function() {
	console.log('domel', $(__renderer[0].domElement));
	__renderer[0].clear();
    __renderer[0].domElement.parendNode.removeChild(__renderer.domElement);
	delete renderer;
 	delete __renderer;
	window.removeEventListener('resize');
}