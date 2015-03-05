# Export Plugin Tester
module.exports = (testers) ->

	class NunjucksTester extends testers.RendererTester

		docpadConfig:

			logLevel: 5

			enabledPlugins:
				nunjucks: true

			plugins:
				nunjucks:
					filters: 'api/filters'
					