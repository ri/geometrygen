selection = "body"
width = 800
height = 800

svg = d3.select(selection).append('svg')
	.attr(width: width)
	.attr(height: height)

#cal vars
center = {x: width/2, y: height/2}
count = 40
circleSize = 100
radius = 120
angle = 360/count

#controls
# countControl

draw = () ->
	svg.selectAll('circle')
		.data([0..(count-1)])
	.enter()
		.append('circle')
		.attr(r: circleSize)
		.attr(cx: (d,i) -> p2c(radius, angle*i).x + center.x)
		.attr(cy: (d,i) -> p2c(radius, angle*i).y + center.y)
		.attr(stroke: 'black')
		.attr(fill: 'none')

p2c = (radius, angle) ->
	angleRadians = d2r(angle)
	x = radius * Math.cos(angleRadians)
	y = radius * Math.sin(angleRadians)
	{x: x, y: y} 
d2r = (degrees) ->
	degrees * Math.PI/180
draw()