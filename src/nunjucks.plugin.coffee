path = require 'path'

# Export Plugin
module.exports = (BasePlugin) ->

	class nunjucks extends BasePlugin

		name: 'nunjucks'
		nunjucks: null

		constructor: ->
			super
			roots = @docpad.config.layoutPaths
			nunjucksLib = require 'nunjucks'

			NonWatchingLoader = new nunjucksLib.FileSystemLoader roots, false
			@Nunjucks = new nunjucksLib.Environment NonWatchingLoader
			
		# Render
		# Called per document, for each extension conversion. 
		# Used to render one extension to another.
		render: (options, next) ->
			# Prepare
			{inExtension, outExtension, content, templateData} = options

			if inExtension is 'nunjucks'
				@Nunjucks.renderString content, templateData, (err, result)->
					options.content = result
					next()
			else
				next()
