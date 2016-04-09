#####################################
#                                   #
#   @author: Nino P. Cocchiarella   #
#   Copyright (C) 2015              #
#   plerp.org                       #
#                                   #
#####################################

pi = Math.PI
abs = Math.abs
sin = Math.sin
cos = Math.cos
arcsin = Math.asin
arccos = Math.acos
arctan = Math.atan
root = Math.sqrt


gl = null

moveTo = ([x,y]) -> gl.moveTo(x, y)
lineTo = ([x,y]) -> gl.lineTo(x, y)

#FRACTAL_DIMENSION = 4
#TRAPEZOIDAL_SECTIONS = 10
#CHILDREN = [3, -7]
#DEGREE1_COEFF = 17
#DEGREE2_COEFF = 30



class TreeStick

    rad2deg: (x) ->
        return x * (180/pi)

    constructor: (params) ->
        {
            @start,
            @direction,
            @length,
            @start_alpha,
            @begin_thickness,
            @end_thickness,
            @generation,
            @children
        } = params

        @delta_thickness = (@begin_thickness - @end_thickness) / TRAPEZOIDAL_SECTIONS
        @delta_length = @length / TRAPEZOIDAL_SECTIONS

        @current_position = @start
        @current_thickness = @begin_thickness

        perp = @direction + pi/2

        @current_edges = [
            [@start[0] + (@begin_thickness/2)*(cos perp), @start[1] + (@begin_thickness/2)*(sin perp)],
            [@start[0] - (@begin_thickness/2)*(cos perp), @start[1] - (@begin_thickness/2)*(sin perp)]
        ]

        @trapezoids = []
        @left_edges = []
        @right_edges = []
        @directions = []
        @left_directions = []
        @right_directions = []


        for i in [0...TRAPEZOIDAL_SECTIONS]

            points = []
            start_midpoint = @current_position
            end_midpoint = [\
                (@current_position[0] + @delta_length * cos @direction), \
                (@current_position[1] + @delta_length * sin @direction)]

            perp = @direction + pi/2
            start_perp = [\
                (@current_position[0] + (@current_thickness/2) * cos perp),\
                (@current_position[1] + (@current_thickness/2) * sin perp)]
            end_perp = [\
                (@current_position[0] - (@current_thickness/2) * cos perp),\
                (@current_position[1] - (@current_thickness/2) * sin perp)]


            @current_position = end_midpoint
            @current_thickness -= @delta_thickness


            #####  main curve function
            @direction -= (pi/DEGREE1_COEFF - i*(pi/DEGREE2_COEFF))


            #### sucessor

            start_perp2 = [\
                (@current_position[0] + (@current_thickness/2) * cos perp),\
                (@current_position[1] + (@current_thickness/2) * sin perp)]
            end_perp2 = [\
                (@current_position[0] - (@current_thickness/2) * cos perp),\
                (@current_position[1] - (@current_thickness/2) * sin perp)]

            points.push @current_edges[0]
            points.push @current_edges[1]
            points.push end_perp2
            points.push start_perp2

            @left_edges.push [start_perp, start_perp2]
            @right_edges.push [end_perp2, end_perp]

            @directions.push @direction

            dx = start_perp2[0] - start_perp[0]
            dy = start_perp2[1] - start_perp[1]





            left_direction = arctan (dy/dx)
            @left_directions.push left_direction

            dx = end_perp2[0] - end_perp[0]
            dy = end_perp2[1] - end_perp[1]
            right_direction = arctan (dy/dx)
            @right_directions.push right_direction


            @trapezoids.push points
            @current_edges = [start_perp2, end_perp2]

        @draw()
        #console.log @left_directions, @right_directions, @directions

        if @generation < FRACTAL_DIMENSION

            for child_index in @children

                if child_index < 0

                    dx = @left_edges[abs(child_index)][1][0] - @left_edges[abs(child_index)][0][0]
                    dy = @left_edges[abs(child_index)][1][1] - @left_edges[abs(child_index)][0][1]
                    midpoint = [\
                        (@left_edges[abs(child_index)][1][0] + @left_edges[abs(child_index)][0][0]) / 2,
                        (@left_edges[abs(child_index)][1][1] + @left_edges[abs(child_index)][0][1]) / 2
                    ]

                    if @generation == 0
                    #console.log start_perp, start_perp2
                        console.log dx, dy

                if child_index > 0

                    dx = @right_edges[abs(child_index)][1][0] - @right_edges[abs(child_index)][0][0]
                    dy = @right_edges[abs(child_index)][1][1] - @right_edges[abs(child_index)][0][1]
                    midpoint = [\
                        (@right_edges[abs(child_index)][1][0] + @right_edges[abs(child_index)][0][0]) / 2,
                        (@right_edges[abs(child_index)][1][1] + @right_edges[abs(child_index)][0][1]) / 2
                    ]



                # get length of edge
                edge_length = root (dx**2 + dy**2)

                # get angle
                theta = @left_directions[abs(child_index)] - (pi/2) if child_index < 0
                theta = @right_directions[abs(child_index)] + (pi/2) if child_index > 0
                #console.log @rad2deg(theta)

                babyTreeStick =
                    start: midpoint
                    direction: theta
                    length: @length * ((TRAPEZOIDAL_SECTIONS-abs(child_index))/TRAPEZOIDAL_SECTIONS)
                    start_alpha: 1 - 0.1* @generation
                    begin_thickness: edge_length
                    end_thickness: edge_length * (@end_thickness/@begin_thickness)
                    generation: @generation + 1
                    children: @children

                baby = new TreeStick babyTreeStick

        #else
        #    for child_index in @children
        #        gl.fillStyle = '#0000cc'
        #        gl.beginPath()
        #        gl.arc(@left_edges[abs(child_index)][1][0], @left_edges[abs(child_index)][1][1], 2, 0, 2*pi, false)
        #        gl.fill()



    draw: ->
        console.log 'draw'
        for trap in @trapezoids
            console.log trap
            gl.strokeStyle = '#111111'
            gl.lineWidth = 1
            gl.fillStyle = 'rgba(120, 90, 60, ' + @start_alpha.toString() +')'
            #if @generation == FRACTAL_DIMENSION
            #    gl.strokeStyle = '#00aa00'
            gl.beginPath()
            moveTo trap[0]
            lineTo trap[1]
            lineTo trap[2]
            lineTo trap[3]
            gl.closePath()
            gl.stroke()
            gl.fill()


    grow: ->

        console.log 'grow'

        # draw a trapezoid
        #gl.fillStyle = '#007700'
        #gl.beginPath()
        #gl.moveTo 0,0
        #gl.lineTo 100,100
        #gl.lineTo 200,50
        #gl.closePath()
        #gl.fill()



window.start = () ->

    console.log 'startfunc'
  
    if Canvas and Canvas != undefined

        Canvas.width = $(window).width()
        Canvas.height = $(window).height()

        gl = Canvas.getContext("2d")
        gl.scale(1, -1)
        gl.translate(0, -Canvas.height)
        U_width = Canvas.width
        U_height = Canvas.height

        console.log('gl', gl)

        gl.strokeStyle = 'rgb(100, 25, 100)'

        originalTreeStick =
            start: [U_width/2, 0]
            direction: pi/2
            length: U_height
            start_alpha: 1
            begin_thickness: 130
            end_thickness: 20
            generation: 0
            children: CHILDREN

        console.log originalTreeStick

        @hank = new TreeStick originalTreeStick
        #@hank.draw()
        #@frameInterval = setInterval (=> @hank.grow()), 1000






"""

move = ([x,y]) -> gl.moveTo(x, y)
line = ([x,y]) -> gl.lineTo(x, y)

class FractalTree
    constructor: (@height) ->
        @trunk = new Branch @height, [300,500], pi/2, 0, null, this
        @frameInterval = setInterval (=> @trunk.grow()), 10

class Branch
    constructor: (@length, @start, @angle, @generation, @parent, @tree) ->
        @parentTree = @tree
        @angleVariation = pi/2.4
        @ratio = 2/(1+root(5))
        @maxChildren = 7
        @parent ?= null
        @unit = 2
        @children = []
        @location = @start.slice()
        @growing = true
        @color = 'rgba(98, 78, 44, ' + (1 - @generation*0.2).toString() +
')'
        if @generation > 2
            @color = 'rgba(98, 78, 44, 0.17)'
        if @generation > 3
            @color = 'rgba(0,100,0,0.15)'
        console.log @color
        @thickness = 1.5 #FRACTAL_DIMENSION - @generation
        @childLocations = (
Math.random()*@length*@ratio/2+(@length*@ratio/2) \
            for n in [0...@maxChildren] )

    grow: ->
        @draw() if @growing
        @growing = false if @getLength() >= @length
        if @getLength() >= @childLocations[@children.length]
            @birthChild() unless @generation >= FRACTAL_DIMENSION

        child.grow() for child in @children

    draw: ->
        gl.strokeStyle = @color
        gl.lineWidth = @thickness
        gl.beginPath()
        move @location
        @location[0] += @unit * cos(@angle)
        @location[1] -= @unit * sin(@angle)
        line @location
        gl.stroke()

    getLength: ->
        return root( (@location[0]-@start[0])**2 +
(@location[1]-@start[1])**2 )

    birthChild: ->
        angle = @angle + (Math.random()*@angleVariation*2) - @angleVariation
        child = new Branch @length * @ratio, @location, angle,
@generation+1, this, @tree
        @children.push child
"""


#################################################