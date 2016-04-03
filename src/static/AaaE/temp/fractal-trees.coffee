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




moveTo = ([x,y]) -> gl.moveTo(x, y)
lineTo = ([x,y]) -> gl.lineTo(x, y)

# COLOR1 = "#785A3C"
# COLOR2 = "#00aa00"
# NUM_ITERATIONS = 6
# TRAPEZOIDAL_SECTIONS = 20
# CHILDREN = [3, -7, 6, 13]
# DEGREE1_COEFF = 17
# DEGREE2_COEFF = 30



class TreeStick

    rad2deg: (x) ->
        return x * (180/pi)

    constructor: (params) ->
        {@start,
            @direction,
            @length,
            @start_alpha,
            @begin_thickness,
            @end_thickness,
            @generation,
            @children
        } = params

        #console.log 'sa', @start_alpha

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
            #console.log 'direction', @direction

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

        #@draw()
        ##console.log @left_directions, @right_directions, @directions

        if @generation < NUM_ITERATIONS

            for child_index in @children

                if child_index < 0

                    dx = @left_edges[abs(child_index)][1][0] - @left_edges[abs(child_index)][0][0]
                    dy = @left_edges[abs(child_index)][1][1] - @left_edges[abs(child_index)][0][1]
                    midpoint = [\
                        (@left_edges[abs(child_index)][1][0] + @left_edges[abs(child_index)][0][0]) / 2,
                        (@left_edges[abs(child_index)][1][1] + @left_edges[abs(child_index)][0][1]) / 2
                    ]

                    #if @generation == 0
                    ##console.log start_perp, start_perp2
                        #console.log dx, dy

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
                ##console.log @rad2deg(theta)

                #console.log @generation
                start_alpha = (1 - 0.1* @generation)
                #console.log 'sa', start_alpha

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

        @draw()



    draw: ->
        #console.log 'draw'
        for trap in @trapezoids
            #console.log trap
            gl.strokeStyle = '#111111'
            gl.lineWidth = 1
            gl.fillStyle = COLOR1 #'rgba(120, 90, 60, 1)' # + @start_alpha.toString() +')'
            if @generation == NUM_ITERATIONS
                gl.strokeStyle = COLOR2
            gl.beginPath()
            moveTo trap[0]
            lineTo trap[1]
            lineTo trap[2]
            lineTo trap[3]
            gl.closePath()
            gl.stroke()
            gl.fill()


    grow: ->

        #console.log 'grow'

        # draw a trapezoid
        #gl.fillStyle = '#007700'
        #gl.beginPath()
        #gl.moveTo 0,0
        #gl.lineTo 100,100
        #gl.lineTo 200,50
        #gl.closePath()
        #gl.fill()


gl = null

$(document).ready ->

    Canvas = document.getElementById('big-canvas')

    gl = Canvas.getContext('2d')

    Canvas.width = $(window).width()
    Canvas.height = $(window).height()

    
    gl.scale(1, -1)
    gl.translate(0, -Canvas.height)
    U_width = Canvas.width
    U_height = Canvas.height

    originalTreeStick =
        start: [U_width/2, 0]
        direction: pi/2
        length: U_height
        start_alpha: 1
        begin_thickness: 130
        end_thickness: 20
        generation: 0
        children: CHILDREN

    #console.log originalTreeStick

    @hank = new TreeStick originalTreeStick
    #@hank.draw()
    #@frameInterval = setInterval (=> @hank.grow()), 100