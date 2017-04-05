// Generated by CoffeeScript 1.12.4
(function() {
  var fs, includeAll, path,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  fs = require('fs');

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
        tags: false,
        filters: false
      };

      function nunjucks() {
        var NonWatchingLoader, filterFn, filtersStat, i, j, len, len1, name, newValue, nunjucksLib, ref, ref1, ref2, tagFn, tagsStat, value;
        nunjucks.__super__.constructor.apply(this, arguments);
        nunjucksLib = require('nunjucks');
        nunjucksLib.installJinjaCompat();
        NonWatchingLoader = new nunjucksLib.FileSystemLoader(this.docpad.config.layoutsPaths, false);
        this.engine = new nunjucksLib.Environment(NonWatchingLoader);
        ref = this.config;
        for (name in ref) {
          value = ref[name];
          if (value) {
            newValue = path.join(this.docpad.config.srcPath, value);
            this.config[name] = newValue;
          }
        }
        if (this.config.tags) {
          tagsStat = fs.lstatSync(this.config.tags);
          if (tagsStat.isDirectory()) {
            ref1 = includeAll({
              dirname: this.config.tags,
              filter: /(.+)\.[js|coffee|litcoffee]+$/,
              optional: true
            });
            for (tagFn = i = 0, len = ref1.length; i < len; tagFn = ++i) {
              name = ref1[tagFn];
              this.addTag(name, tagFn);
            }
          }
        }
        if (this.config.filters) {
          filtersStat = fs.lstatSync(this.config.filters);
          if (filtersStat.isDirectory()) {
            ref2 = includeAll({
              dirname: this.config.filters,
              filter: /(.+)\.[js|coffee|litcoffee]+$/,
              optional: true
            });
            for (filterFn = j = 0, len1 = ref2.length; j < len1; filterFn = ++j) {
              name = ref2[filterFn];
              this.addFilter(name, filterFn);
            }
          }
        }
      }

      nunjucks.prototype.addTag = function(name, tagFn) {
        console.info("Adding custom tag: " + name);
        return this.engine.addTag(name, tagFn);
      };

      nunjucks.prototype.addFilter = function(name, filterFn) {
        console.info("Adding custom filter: " + name);
        return this.engine.addFilter(name, filterFn);
      };

      nunjucks.prototype.render = function(options) {
        var content, err, inExtension, outExtension, templateData;
        inExtension = options.inExtension, outExtension = options.outExtension, content = options.content, templateData = options.templateData;
        console.log(inExtension, outExtension);
        if (inExtension === 'nunjucks') {
          try {
            options.content = this.engine.renderString(content, templateData);
          } catch (error) {
            err = error;
            return err;
          }
        }
        return true;
      };

      return nunjucks;

    })(BasePlugin);
  };

}).call(this);
