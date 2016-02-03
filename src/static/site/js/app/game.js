/*
	****************************************
	* @author: Nino P. Cocchiarella
	* (c) 2016
	* 
	* Das Plerpenspiel
	* main javascript app
	****************************************
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
	dependsLoaded = false;
	documentReady = false;

	configure: function() {
		var self = this;
		require(this.depends, function() {
			self.dependsLoaded = true;
			echo("deps loaded");
			if (this.documentReady) {
				this.start();
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
			echo("APP start ===========");
		} else echo("BAD start()");
	}

}; 

require(["jquery", "app/util"], function() {
	$(document).ready(function() { 
		App.ready();
	});
	App.configure();
});



// Models
var ZeroPlayerGame = Backbone.Model.extend({
	defaults: {
		title: "New Space",
		description: "",
		scriptURL: "",
	}
});

// Collections
var ZeroPlayerGameCollection = Backbone.Collection.extend({
	url: "/game/zero-player",
	model: ZeroPlayerGame
});

// Views
var GameList = Backbone.View.extend({
	el: "#list-apps-container",
	temp: "#list-apps",

	initialize: function() {
		this.listenTo(this.collection, 'sync', this.render);
		this.listenTo(this.collection, 'remove', this.render);
		this.template = _.template($(this.temp).html());
	},

	render: function() {
		var self = this;
		this.collection.each(function(model) {
			self.$el.append(self.template(model.toJSON()));
		});
		return this;
	}
});


$(document).ready(function() {

	print("game.js ready")

	var collection = new ZeroPlayerGameCollection();
	var view = new GameList({
		collection: collection
	});
	collection.fetch();
	print(collection);

});




