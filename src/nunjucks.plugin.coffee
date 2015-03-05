fs = require 'fs'
path = require 'path'
includeAll = require 'include-all'
require 'coffee-script/register'

# Export Plugin
module.exports = (BasePlugin) ->

	class nunjucks extends BasePlugin

		name: 'nunjucks'
		nunjucks: null

		# no custom tags or filters by default
		config:
			tags: false
			filters: false

		constructor: ->
			super
			nunjucksLib = require 'nunjucks'
			NonWatchingLoader = new nunjucksLib.FileSystemLoader @docpad.config.layoutsPaths, false
			@engine = new nunjucksLib.Environment NonWatchingLoader
			
			for name, value of @config
				if value
					newValue = path.join(@docpad.config.srcPath, value)
					@config[name] = newValue

			if @config.tags
				tagsStat = fs.lstatSync @config.tags
				if tagsStat.isDirectory()
					@addTag(name, tagFn) for name, tagFn in includeAll({
						dirname: @config.tags
						filter: /(.+)\.[js|coffee|litcoffee]+$/
						optional: true
					})

			if @config.filters
				filtersStat = fs.lstatSync(@config.filters)
				if filtersStat.isDirectory()
					@addFilter(name, filterFn) for name, filterFn in includeAll({
						dirname: @config.filters
						filter: /(.+)\.[js|coffee|litcoffee]+$/
						optional: true
					})

		addTag: (name, tagFn)->
			console.info "Adding custom tag: #{name}"
			@engine.addTag name, tagFn

		addFilter: (name, filterFn)->
			console.info "Adding custom filter: #{name}"
			@engine.addFilter name, filterFn

		# Render
		# Called per document, for each extension conversion. 
		# Used to render one extension to another.
		render: (options) ->
			# Prepare
			{inExtension, outExtension, content, templateData} = options

			console.log inExtension, outExtension

			if inExtension is 'nunjucks'
				try
					options.content = @engine.renderString content, templateData
				catch err
					return err

			return true