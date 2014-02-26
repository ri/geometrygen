selection = "body"
width: 800
height: 800

svg = d3.select(selection).append('svg')
	.attr(width: width)
	.attr(height: height)

#cal vars
center = {x: width/2, y: height/2}
console.log center.x