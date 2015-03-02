path = require 'path'
includeAll = require 'include-all'
require 'coffee-script/register'

# Export Plugin
module.exports = (BasePlugin) ->

	class nunjucks extends BasePlugin

		name: 'nunjucks'
		nunjucks: null

		config:
			tags: "tags"
			filters: "filters"

		constructor: ->
			super
			nunjucksLib = require 'nunjucks'
			NonWatchingLoader = new nunjucksLib.FileSystemLoader @docpad.config.layoutsPaths, false
			@engine = new nunjucksLib.Environment NonWatchingLoader

			@config.tags = path.join(@docpad.config.rootPath, @config.tags)
			@config.filters = path.join(@docpad.config.rootPath, @config.filters)

			custom = 
				tags: includeAll({
					dirname: @config.tags,
					filter: /(.+)\.coffee$/,
					optional: true
				})
				filters: includeAll({
					dirname: @config.filters,
					filter: /(.+)\.coffee$/
				})

			@engine.addFilter(name, tag) for name, filter in custom.filters
			@engine.addFilter(name, tag) for name, tag in custom.tags


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
