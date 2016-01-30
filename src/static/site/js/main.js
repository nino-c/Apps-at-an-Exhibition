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

	var Canvas = null;
	var canvas = null;
	var controlPanel = null;
	var currentGame = null;
	var currentInstance = null;

	window.App = {
		Models: {},
		Collections: {},
		Views: {},
		Router: {},

		models: [],
		collections: [],
		views: {},

		currentGameList: null,
		currentGame: null,
		currentGameInstance: null,

		showJustOneView: function(view) {
	        if(App.views.current != undefined){
	            $(App.views.current.el).hide();
	        }
	        App.views.current = view;
	        $(App.views.current.el).show();
	    },

	    hideCanvas: function() {
	    	canvas = $("#inline-canvas");
	    	canvas.css({"display":"none"});
	    },

	    instantiateGame: function(id) {
	    	var url = "/game/zero-player/" + id + "/instantiate/";
			$.ajax({
				url: url,
				method: "GET",
				dataType: "json",
				success: function(data) {
					echo(data);
					//game.fetch();
				}
			});
	    },

	    executeGame: function(game, instance) {

	    	// hide any other views
	    	if(App.views.current != undefined){
	            $(App.views.current.el).hide();
	        }

	        currentGame = game;
	        currentInstance = instance;

	        // get game-level scope declared, show elements
	    	canvas = $("#inline-canvas");
	    	Canvas = document.getElementById("inline-canvas");
	    	controlPanel = $("#floating-display-control");
	        controlPanel.css({'display':'block'});
	        canvas.css({'display':'block'});
	        Canvas.width = $(window).width();
	        Canvas.height = $(window).height() - 52;

	        var htext = "<strong>&quot;"+game.get('title')+"&quot;</strong>";
	        htext += "<br />by " + game.get('owner').name;
	        $("#control-panel-header").html(htext);

	        // hide footer (future, make nice bottom-hugging footer)
	        $("footer").css({"display":"none"});

	        if (instance.seed) {

	        	// execute seed code
	        	var seedcode = "var seed = " + instance.seed + ";"
	        	eval(seedcode);
	        	//echo(seed);

	        	// import seed attributes into local namespace
	        	if (seed != undefined) {

	        		game.set('_seed', seed);

	        		App.views.seedEditor = new App.Views.SeedEditor({
						model: game
					});

	        		for (attr in seed) {
	        			var line = "var " + attr + " = " + seed[attr].toString() + ";"
	        			eval(line);
	        			echo(line);
	        		}
	        	}

	        	// execute game script
	        	eval(game.get('source'));

	        }


	    },

	    snapshot: function() {
	    	var snapshot = Canvas.toDataURL("image/png");
	    	echo(">>snapshot length="); echo(snapshot.length);
	    	var url = "/game/snapshot/" + currentInstance.id;
	    	echo(url);
	    	$.ajax({
	    		url: url,
	    		method: "POST",
	    		success: function(data) {
	    			
	    		}
	    	});
	    }

	};

	
	/*
	*
	*********   MODELS
	*
	*/

	App.Models.Game = Backbone.Model.extend({
		
		defaults: {
			title: "New Space",
			description: "A brand new, clean app-skeleton.",
		},
		
		url: function() { return '/game/zero-player/' + this.id; },
	});

	App.Models.GameInstance = Backbone.Model.extend({});


	/*
	*
	*********   COLLECTIONS
	*
	*/

	App.Collections.GameCollection = Backbone.Collection.extend({
		url: "/game/zero-player",
		model: App.Models.Game
	});

	App.Collections.GameInstanceCollection = Backbone.Collection.extend({
		url: "/game/instances",
		model: App.Models.GameInstance
	})


	/*
	*
	*********   VIEWS
	*
	*/

	App.Views.GameList = Backbone.View.extend({
		el: "#list-games",
		temp: "#list-games-template",

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
		},

	});

	App.Views.GameDetail = Backbone.View.extend({
		el: "#display-game",
		temp: "#display-game-template",

		initialize: function() {
			this.listenTo(this.model, 'change', this.render)
			this.template = _.template($(this.temp).html());
			this.render();
		},

		render: function() {
			this.$el.html(this.template(this.model.toJSON()));
			return this;
		},
	});

	App.Views.SeedEditor = Backbone.View.extend({
		el: "#seed-editor",
		temp: "#seed-editor-template",

		initialize: function() {
			this.listenTo(this.model, 'change', this.render);
			this.template = _.template($(this.temp).html());
			this.render();
		},

		render: function() {
			this.$el.html(this.template(this.model.toJSON()));
			return this;
		}
	});

	
	/*
	*
	*********   ROUTER
	*
	*/


	App.Router = Backbone.Router.extend({
		routes: {
			'': 'home',
			'game/:id': 'game',
			'instance/:gameid/:instanceid': 'instance'
		},

		home: function(){
			App.hideCanvas();
			var games = new App.Collections.GameCollection();
			App.views.gameList = new App.Views.GameList({
				collection: games
			});
			App.showJustOneView(App.views.gameList);
			games.fetch();
		},

		game: function(id){
			App.hideCanvas();
			var game = new App.Models.Game({id:id});
			game.fetch().then(function() {
				App.views.gameDetail = new App.Views.GameDetail({
					model: game
				});
				App.showJustOneView(App.views.gameDetail);

				// if there are no instances, make one
				if (game.get('instances').length == 0) {
					echo("no instances, making one"); 
					App.instantiateGame( game.get('id') );
				}
			});
		},

		instance: function(gameid, instanceid) {
			/*var instance = _.filter(App.views.gameDetail.model.get('instances'), function(x) { 
				return x.id == id; })[0] || null;*/
			var game = new App.Models.Game({id:gameid});
			game.fetch().then(function() {
				echo(game.get('instances'));
				var instance = _.filter(game.get('instances'), function(x) { 
					return x.id == instanceid; })[0] || null;
				echo(instance);
				if (instance != null) App.executeGame(game, instance);
			});
			
		}

	});

	var router = new App.Router;
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
