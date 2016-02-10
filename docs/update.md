# Revision 1 #

* This is the first official revision plan for plerp.org, meant to generalize my own "portfolio" into a multi-user platform *

Generalize from my portfolio to user's profile
Generalize the "polynomial landscape" app into THE framework for plerpingapps.
(So that I personally don't have to mess with anything off-the-cloud to make a new "plerp", describe and categorize it, and publish it.  At the same time, that upgrades plerp.org to a multi-user platform, which it already is due to Django-edge.

# Rules of the Game #
=============
* Need word: hybrid("post", "app", "gallery", "art", "creation") = [___, "space"] = "plerper?" *
=============

A "plerper" or "plerpingapp" is an app, whose goal it is to generate galleries of art, moving and not moving
Any gallery-item (snapshot) should be completely reproducable by the same initial condition set.
	- Use of Math.random() is forbidden INSIDE the algorithm (level 1 app),
		so it is only used to search the space (level 2 app).
	- an algorithm to search the space may use Math.random()


# FRONT END #

## Goals ##
- Do as little front-end direct navigation as possible.
	- (Django-edge is already multi-page, keep it that way.)
- Use minimum templates:
	- base.html (includes) top bar
		- home.html (splash = home, which is not at all like ->)
		- user's profile = portfolio
- Move analysis of polynomials, factoring, expanding, to be done backend with sympy or sage
- Add ajax interface, switch to backbone for all that is possible.

## New packages needed ##
- code display (coloring)
- code editor (IDE)

## interface details ##
- No more iframe, all in one DOM
- Add waiting-server-anim
- implement matrix mult in paper through numeric

## the "plerping-panel" ##
	- panel: always has buttons:
		- save ("snapshot")
		- show/edit source
		- add save button, publish button
	- add edit code button



Categories are global, but only a user's plerpingapp is a member of a category.
	- One user makes a new category and it becomes a new category globally.


# User levels #

## Visitor ##
	- list categories of plerpingapps (or "plerper")
	- list plerpsers in each category
	- list users
	- view and use plerpers
	- show source code
	- edit source code for one-time run?

## Level One (the "spotfinder"):
	"""A level one user is a "spot finder" (the finder of a particular
	set of clever initial conditions in someone else's space).  More like
	"save favorites", but is visible (publically or not)"""
	- Click to save a snapshot of someone else's space.
		- saves as static image, or video (giv? svg?) if animated.
		- example: "Nino" made/saved an instance of "Bob's" "Polynomail Landscape"

## Level Two (the "engineer" or "plerpologist") ##
	- create new plerper from sctarch
	- (encouraged) take someone else's plerper, change it, and save as own.
		- server evals diffs to make sure it is different non-trivially

## Level Three (the "synesthesiologist") ##
	- adds music interface

## Level Four (admin, github contributers) ##
