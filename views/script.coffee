class GeoGen
	geo = this
	selection = "body"
	width = 800
	height = 800

	svg = d3.select(selection).append('svg')
		.attr(id: 'canvas')
		.attr(width: width)
		.attr(height: height)

	#controls
	# countControl
	sliders = [
		{name: 'count', min: 1, max: 300, step: 1, value: 6}
		{name: 'size', min: 1, max: 300, step: 2, value: 20}
		{name: 'radius', min: 0, max: 300, step: 10, value: 100}
	]

	init: () =>	
		#cal vars
		@center = {x: width/2, y: height/2}
		@count = 40
		@circleSize = 100
		@radius = 120
		@angle = 360/@count

		@controlsDiv = d3.select('#controls')
		@controlsGroups = @controlsDiv.selectAll('div')
			.data(sliders)
		.enter()
			.append('div').attr(class: 'control')
		@controlsGroups.append('label')
			.text((d) -> d.name)
		sliderValues = @controlsGroups.append('input')
			.attr(class: 'value')
			.attr(type: 'text')
			.attr(value: (d) -> d.value)
		sliders = @controlsGroups.append('x-slider')
			.attr(name: (d) -> d.name)
			.attr(min: (d) -> d.min)
			.attr(max: (d) -> d.max)
			.attr(step: (d) -> d.step)
			.attr(value: (d) -> d.value)
			.on('change', @updateSlider)
		@controlsGroups.append('span')
			.attr(class: 'min')
			.text((d) -> d.min)
		@controlsGroups.append('span')
			.attr(class: 'max')
			.text((d) -> d.max)

	draw: () =>
		svg.selectAll('circle')
			.data([0..(@count-1)])
		.enter()
			.append('circle')
			.attr(r: @circleSize)
			.attr(cx: (d,i) => p2c(@radius, @angle*i).x + @center.x)
			.attr(cy: (d,i) => p2c(@radius, @angle*i).y + @center.y)
			.attr(stroke: 'black')
			.attr(fill: 'none')
	update: () =>
		console.log "drawing"
		svg.selectAll('circle')
			.transition()
			.attr(r: @circleSize)
			.attr(cx: (d,i) => p2c(@radius, @angle*i).x + @center.x)
			.attr(cy: (d,i) => p2c(@radius, @angle*i).y + @center.y)

	p2c = (radius, angle) ->
		angleRadians = d2r(angle)
		x = radius * Math.cos(angleRadians)
		y = radius * Math.sin(angleRadians)
		{x: x, y: y} 
	d2r = (degrees) ->
		degrees * Math.PI/180

	updateSlider: (d) =>
		controlG = d3.select("#controls [name=#{d.name}]")
		val = controlG.attr('value')
		controlG.select('.value').attr(value: val)
		variable = controlG.data()[0].name
		switch variable
			when 'count' then @count = val
			when 'size' then @circleSize = val
			when 'radius' then @radius = val
		@angle = 360/@count
		@update()


document.addEventListener('DOMComponentsLoaded', () ->
	geo = new GeoGen()
	geo.init()
	geo.draw()
)