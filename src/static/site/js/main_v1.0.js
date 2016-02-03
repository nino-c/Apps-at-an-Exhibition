/*
	*************************************
	* @author: Nino P. Cocchiarella
	* (c) 2016
	* 
	* Das Plerpenspiel
	* main javascript app
	*
	*************************************
*/

require.config({
	baseUrl: "/static/site/js/lib",
	paths: {
		"jquery": "jQuery2.1.1.js",
		"app": "../app"
	}
});

var App = {

	depends: ['underscore', 'backbone'],
	dependsLoaded: false,
	documentReady: false,

	collections: {},
	models: {},
	views: {},

	configure: function() {
		var self = this;
		require(this.depends, function() {
			self.dependsLoaded = true;
			echo("deps loaded");
			if (self.documentReady) {
				self.start();
			}
		});
	},

	ready: function() {
		this.documentReady = true;
		echo("document ready");
		if (this.dependsLoaded) {
			this.start();
		}
	},

	start: function() {
		if (this.dependsLoaded && this.documentReady) {

			echo("====== APP start ======");

			this.models.Game = Backbone.Model.extend({
				defaults: {
					title: "New Space",
					description: "",
					scriptURL: "",
				}
			});


			this.collections.GameCollection = Backbone.Collection.extend({
				url: "/game/zero-player",
				model: this.models.Game
			});

			this.views.GameList = Backbone.View.extend({
				el: "#list-apps-container",
				temp: "#list-apps",

				initialize: function() {
					this.listenTo(this.collection, 'sync', this.render);
					this.listenTo(this.collection, 'remove', this.render);
					this.template = _.template($(this.temp).html());
				},

				render: function() {
					echo("render")
					// this.collection.each(function(model) {
					// 	self.$el.append(self.template(model.toJSON()));
					// });
					this.$el.html(this.template({
						games: this.collection.toJSON()
					}));
					return this;
				}
			});

			var games = new this.collections.GameCollection();
			var gamelist = new this.views.GameList({
				collection: games
			});
			games.fetch();

		} else echo("BAD start()");
	}

}; 

require(["jquery", "app/util"], function() {
	$(document).ready(function() { 
		App.ready();
	});
	App.configure();
});
