
Rummage
=====

[![Circle CI](https://circleci.com/gh/mpakus/rummage/tree/master.svg?style=svg)](https://circleci.com/gh/mpakus/rummage/tree/master)

* search engine

Install & run
----
> bundle install

> rails s

type `http://localhost:3000/` in your browser and start to search!

Tests
---
> rspec

Rubocop
--- 
> rubocop -a

Objective
--- 
Make data searchable

Bare minimum requirements:
--- 

* Implementation must use Ruby on Rails, JavaScript and HTML (all three)
* Search logic should be implemented in Ruby and written by YOU, don't use a gem or external code for this
* A search for Lisp Common should match a programming language named "Common Lisp"
* Your solution will be tested on a Mac running OS X El Capitan, Ruby 2.2.3 and Rails 4.2.4

Meriting
---

* Writing code with reusability in mind
* Search match precision
* Support for exact matches, eg. Interpreted "Thomas Eugene", which should match "BASIC", but not "Haskell"
* Match in different fields, eg. Scripting Microsoft should return all scripting languages designed by "Microsoft"
* Support for negative searches, eg. john -array, which should match "BASIC", "Haskell", "Lisp" and "S-Lang", but not "Chapel", "Fortran" or "S".
* Solution elegance
* Visual design
