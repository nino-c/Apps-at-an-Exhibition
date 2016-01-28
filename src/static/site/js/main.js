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


(function(){

	window.App = {
		Models: {},
		Collections: {},
		Views: {},
		Router: {}
	};

	

	App.Game = Backbone.Model.extend({
		defaults: {
			title: "New Space",
			description: "",
			scriptURL: "",
		}
	});


	App.GameCollection = Backbone.Collection.extend({
		url: "/game/zero-player",
		model: App.Game
	});

	App.GameList = Backbone.View.extend({
		el: "#list-apps-container",
		temp: "#list-apps",

		initialize: function() {
			this.listenTo(this.collection, 'sync', this.render);
			this.listenTo(this.collection, 'remove', this.render);
			this.template = _.template($(this.temp).html());
		},

		render: function() {
			this.$el.html(this.template({
				games: this.collection.toJSON()
			}));
			return this;
		}
	});

	App.Router = Backbone.Router.extend({
		routes: {
			'': 'index',
			'show/:id': 'show'
		},

		index: function(){
			echo("ROUTE: index")
			var games = new App.GameCollection();
			var gamelist = new App.GameList({
				collection: games
			});
			games.fetch();
		},

		show: function(id){
			echo("ROUTE: show " + id.toString());
		},
	});

	new App.Router;
	Backbone.history.start();
	

	App.start = function() {
		echo("App start()")
	}

})();




require.config({
	baseUrl: "/static/site/js/lib",
	paths: {
		"jquery": "jQuery2.1.1.js",
		"app": "../app"
	}
});

// for now, html-include fundamental scripts = jquery+underscore+backbone in HTML, use this only for extra libs
require(["three"], function() {
	if (document.readyState == "complete") {
		App.start();
	} else {
		$(document).ready(function() { 
			App.start();
		});
	}
});
