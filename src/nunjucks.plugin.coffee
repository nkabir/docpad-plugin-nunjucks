path = require 'path'

# Export Plugin
module.exports = (BasePlugin) ->

	class nunjucks extends BasePlugin

		name: 'nunjucks'
		nunjucks: null

		constructor: ->
			super
			nunjucksLib = require 'nunjucks'
			NonWatchingLoader = new nunjucksLib.FileSystemLoader @docpad.config.layoutsPaths, false
			@engine = new nunjucksLib.Environment NonWatchingLoader
			
		# Render
		# Called per document, for each extension conversion. 
		# Used to render one extension to another.
		render: (options, next) ->
			# Prepare
			{inExtension, outExtension, content, file, templateData} = options
			# filename = file.get('relative')

			if inExtension is 'nunjucks'
				@engine.renderString content, templateData, (err, res)->
					options.content = res
					next()
