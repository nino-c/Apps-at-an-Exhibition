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
	var router = null;

	window.App = {
		Models: {},
		Collections: {},
		Views: {},
		Router: {},

		models: [],
		collections: [],
		views: {},

		currentGameList: null,
		currentGame: function() { return currentGame; },
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
	    	$("#floating-display-control").css({"display":"none"});
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

	    executeGame: function() {

	    	// hide any other views
	    	if(App.views.current != undefined){
	            $(App.views.current.el).hide();
	        }

	        game = currentGame;
	        instance = currentInstance;
	        //echo(game); echo(instance);

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
	        $("#control-panel-header-text").html(htext);

	        // hide footer (future, make nice bottom-hugging footer)
	        $("footer").css({"display":"none"});

	        if (instance.seed) {

	        	// execute seed code
	        	var seedcode = "var seed = " + instance.seed + ";";
	        	var seedcodelines = [seedcode];
	        	eval(seedcode);
	        	//echo(seed);

	        	// prepare seed editor
	        	game.set('_seed', seed);
				App.views.seedEditor = new App.Views.SeedEditor({
					model: game
				});

        		// import seed attributes into local namespace
        		for (attr in seed) {

        			var line;
        			if (typeof seed[attr] == 'string') {

        				// if color field, add colorpicker to form
        				// if (seed[attr].toString().indexOf("rgba(") === 0) {
        				// 	if ($("#color_"+attr.toString())) {
        				// 		$("#color_"+attr.toString()).colorpicker();
        				// 	}
        				// }

        				line = "var " + attr + " = \"" 
        					+ seed[attr].toString() + "\";"
        			} else {
        				line = "var " + attr + " = " + seed[attr].toString() + ";"
        			}
        			seedcodelines.push(line);
        			//eval(line);
        			//echo(line);
        		}
	        	

	        	// execute seed code and game script
	        	if (game.get('scriptType') == "text/paperscript") {
	        		
					with (paper) {
						var source = seedcodelines.join("\n") + "\n" + game.get('source');
						eval(source);
					}
	        	} else {
	        		eval( seedcodelines.join("\n") );
	        		eval(game.get('source'));
	        	}

	        }


	    },

	    snapshot: function() {
	    	var snapshot = Canvas.toDataURL("image/png");
	    	var url = "/game/zero-player/snapshot/";
	    	$.post(url, {
	    			instance: currentInstance.id.toString(),
	    			time: App.getTimeElapsed(),
	    			image: snapshot
	    		},
	    		function(data) {
	    			echo(data);
	    		}
	    	);
	    },

	    redraw: function() {
	    	
	    },

	    editSource: function() {
	    	$("#blackout").css({display:"block"});
	    	$("#source-editor").css({display:"block"});
	    	
	    	text1 = $("#source-textarea");
	    	text2 = $("#seed-structure");

	    	text1.siblings().remove();
			text2.siblings().remove();

	    	text1.text(currentGame.get('source'));
	    	text2.text(currentGame.get('seedStructure'));

			var editor1 = CodeMirror.fromTextArea(document.getElementById('source-textarea'), {
	    		lineNumbers: true
			});
			editor1.setOption("theme", "monokai");

			var editor2 = CodeMirror.fromTextArea(document.getElementById('seed-structure'), {
				lineNumbers: true
			});	
			App.editors = [editor1, editor2];
			editor2.setOption("theme", "monokai");

			

	    },

	    saveSource: function() {
	    	var code = App.editors[0].getValue();
	    	var seedStructure = App.editors[1].getValue();

	    	$("#blackout").css({display:"none"});
	    	$("#source-editor").css({display:"none"});

	    	currentGame.set('source', code);
	    	currentGame.set('seedStructure', seedStructure);

	    	// below is how I "should" do this -- through API
	    	/////////////
	    	// currentGame.save({patch:true}).then(function(data) {
	    	// 	echo(data);
	    	// });

			// backbone save() being a bitch so below is quick hack
			var updatedata = {
	    		id: currentGame.get('id'),
	    		source: code,
	    		seedStructure: seedStructure
	    	};
	    	//echo(updatedata)
	    	$.post("/game/update/"+currentGame.get('id').toString()+"/", updatedata, function(data) {
	    		echo("/game/update/.. response")
	    		echo(data);
	    		App.executeGame();
	    	})


	    	
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

		initialize: function() {
			this.set('images', []);
			this.on("sync", this.getImageSet);
		},

		getImageSet: function() {
			var images = [];
			_.each(this.get('instances'), function(instance) { 
				images = images.concat(instance.images); 
			});
			N = 1;
			if (images.length >= 4) N=4;
			if (images.length >= 9) N=9;
			this.set('images', _.sample(_.flatten(images), N));
			return this.images;
		},
		
		url: function() { return '/game/zero-player/' + this.id + "/"; },
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
		},

		events: {
			'keypress input' : function(e) {
				if (e.keyCode == 13) {
					var attr = e.target.id.toString().replace("seed_", "");
					var seed = currentGame.get('_seed');
					//var seed = currentInstance.seed;
					//echo(currentInstance.seed);

					// update later to also handle color-strings!
					if (typeof seed[attr] == "string") {
						echo("string")
						seed[attr] = e.target.value;
					} else {
						echo("not string")
						seed[attr] = parseFloat(e.target.value);
					}
					// !!!!

					currentGame.set('_seed', seed);
					currentInstance.seed = JSON.stringify(seed);

					App.executeGame();
				}
			},
			'keydown input': function(e) {
				//e.preventDefault();
				e.stopPropagation();
				echo(e);
			}
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
			currentGame = game;

			game.fetch().then(function() {
				var instance = _.filter(game.get('instances'), function(x) { 
					return x.id == instanceid; })[0] || null;
				currentInstance = instance;

				if (instance != null) App.executeGame();
			});
			
		}

	});

	
	

	App.getTimeElapsed = function() {
		return (((new Date()).getTime() - App.timeAtLoad) / 1000);
	};

	App.start = function() {
		echo("App start()");
		App.timeAtLoad = (new Date()).getTime();
		router = new App.Router;
		$('.navbar').addClass('navbar-transparent');
		paper.setup('inline-canvas');
		Backbone.history.start();
	};

})();



/*require.config({
	baseUrl: "/static/site/js/lib",
	paths: {
		"jquery": "jQuery2.1.1.js",
		"app": "../app"
	}
});*/

// for now, html-include fundamental scripts = jquery+underscore+backbone in HTML, use this only for extra libs
//require(["three"], function() {
	// if (document.readyState == "complete") {
	// 	App.start();
	// } else {
		$(document).ready(function() { 
			App.start();
		});
	//}
//});
