nunjucks = require 'nunjucks'


# Export Plugin
module.exports = (BasePlugin) ->

	class NunjucksPlugin extends BasePlugin

		name: 'nunjucks'

		# Render
		# Called per document, for each extension conversion. Used to render one extension to another.
		render: (opts, next) ->
			# Prepare
			{inExtension, outExtension, file, content, templateData} = opts

			# TEMPLATE_ROOT = @docpad.config.layoutPaths

			if inExtension is 'nunjucks'

				renderer = nunjucks.configure '/', watch: false

				opts.content = renderer.renderString content, templateData, next

			else
				return next()

