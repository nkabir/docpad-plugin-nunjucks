path = require 'path'

# Export Plugin
module.exports = (BasePlugin) ->

	class NunjucksPlugin extends BasePlugin

		name: 'nunjucks'
		nunjucks: null

		constructor: ->
			super
			roots = @docpad.config.layoutPaths
			nunjucksLib = require 'nunjucks'

			NonWatchingLoader = new Nunjucks.FileSystemLoader roots, false
			@Nunjucks = new nunjucks.Environment NonWatchingLoader
			
		# Render
		# Called per document, for each extension conversion. Used to render one extension to another.
		render: (opts, next) ->
			# Prepare
			{inExtension, outExtension, content, templateData} = opts

			if inExtension is 'nunjucks'
				opts.content = @Nunjucks.renderString content, templateData, next

			else
				return next()

