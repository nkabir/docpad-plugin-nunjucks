# Nunjucks Plugin for [DocPad](http://docpad.org)

enable your docpad projects to render your document's content with [nunjucks](http://mozilla.github.io/nunjucks/) adding the `nunjucks` extension to them.


Convention:  `.*.nunjucks`


## Install

``` bash
npm install git+ssh://git@dev.fusion.one:7999/fus/docpad-plugin-nunjucks.git
```

## Custom Tags & Filters

```coffee
...

plugins:
	nunjucks:
		tags: 'relative/path/to/tags/directory'
		filters: 'relative/path/to/filters/directory'

...

```

