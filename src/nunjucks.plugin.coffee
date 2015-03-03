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

			@addTag(name, tagFn) for name, tagFn in includeAll({
				dirname: @config.tags,
				filter: /(.+)\.coffee$/,
				optional: true
			})
			@addFilter(name, filterFn) for name, filterFn in includeAll({
				dirname: @config.filters,
				filter: /(.+)\.coffee$/,
				optional: true
			})

		addTag: (name, tagFn)->
			console.log "Adding custom tag: #{name}"
			@engine.addTag name, tagFn

		addFilter: (name, filterFn)->
			console.log "Adding custom filter: #{name}"
			@engine.addFilter name, filterFn

		# Render
		# Called per document, for each extension conversion. 
		# Used to render one extension to another.
		render: (options) ->
			# Prepare
			{inExtension, content, templateData} = options

			if inExtension is 'nunjucks'
				try
					options.content = @engine.renderString content, templateData
				catch err
					return err

			return true