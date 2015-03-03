// Generated by CoffeeScript 1.9.1
(function() {
  var includeAll, path,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  path = require('path');

  includeAll = require('include-all');

  require('coffee-script/register');

  module.exports = function(BasePlugin) {
    var nunjucks;
    return nunjucks = (function(superClass) {
      extend(nunjucks, superClass);

      nunjucks.prototype.name = 'nunjucks';

      nunjucks.prototype.nunjucks = null;

      nunjucks.prototype.config = {
        tags: "tags",
        filters: "filters"
      };

      function nunjucks() {
        var NonWatchingLoader, filterFn, i, j, len, len1, name, nunjucksLib, ref, ref1, tagFn;
        nunjucks.__super__.constructor.apply(this, arguments);
        nunjucksLib = require('nunjucks');
        NonWatchingLoader = new nunjucksLib.FileSystemLoader(this.docpad.config.layoutsPaths, false);
        this.engine = new nunjucksLib.Environment(NonWatchingLoader);
        this.config.tags = path.join(this.docpad.config.rootPath, this.config.tags);
        this.config.filters = path.join(this.docpad.config.rootPath, this.config.filters);
        ref = includeAll({
          dirname: this.config.tags,
          filter: /(.+)\.coffee$/,
          optional: true
        });
        for (tagFn = i = 0, len = ref.length; i < len; tagFn = ++i) {
          name = ref[tagFn];
          this.addTag(name, tagFn);
        }
        ref1 = includeAll({
          dirname: this.config.filters,
          filter: /(.+)\.coffee$/,
          optional: true
        });
        for (filterFn = j = 0, len1 = ref1.length; j < len1; filterFn = ++j) {
          name = ref1[filterFn];
          this.addFilter(name, filterFn);
        }
      }

      nunjucks.prototype.addTag = function(name, tagFn) {
        console.log("Adding custom tag: " + name);
        return this.engine.addTag(name, tagFn);
      };

      nunjucks.prototype.addFilter = function(name, filterFn) {
        console.log("Adding custom filter: " + name);
        return this.engine.addFilter(name, filterFn);
      };

      nunjucks.prototype.render = function(options) {
        var content, err, inExtension, templateData;
        inExtension = options.inExtension, content = options.content, templateData = options.templateData;
        if (inExtension === 'nunjucks') {
          try {
            options.content = this.engine.renderString(content, templateData);
          } catch (_error) {
            err = _error;
            return err;
          }
        }
        return true;
      };

      return nunjucks;

    })(BasePlugin);
  };

}).call(this);
