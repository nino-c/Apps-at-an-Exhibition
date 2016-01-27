/*

	* @author: Nino P. Cocchiarella
	* (c) 2016
	* 
	* Das Plerpenspiel
	* main javascript app

*/


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
	print(collection)

});




