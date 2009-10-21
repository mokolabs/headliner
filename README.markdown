Headliner
=========

Headliner is a Rails plugin that makes it easier to assign and format page titles from your views.


Background
==========

Normally, if your Rails application has lots of actions and a shared layout, you might find yourself setting custom page title names in your controllers.

Here's an example:

    class PagesController < ApplicationController
      def about
        @title = "About us"
      end
    end

Then, in your main layout, you might have something like this:

    <head>
    <title>My website<% if @title %>: <%= @title %><% end %></title>
    </head

This works okay... but page titles don't really belong in controllers, do they?

So, by moving these titles into your views, we can DRY things up a bit and reinforce the MVC design pattern that's so fundamental to Ruby on Rails.


Install
=======

To install, just add Headliner to your `vendor/plugins` directory:

    script/plugin install git://github.com/mokolabs/headliner.git
    
    
Usage
=====

First, add this code to your main layout:

    <head>
    <%= title :site => "My website" %>
    </head>

Then, to set the page title, add this to each of your views:

    <h1><%= title "My page title" %></h1>

When views are rendered, the page title will be included in the right
spots:

    <head>
    <title>My website | My page title</title>
    </head>
    <body>
    <h1>My page title</h1>
    </body>


Options
=======

Use these options to customize the title format:

    :prefix (text between site name and separator)
    :separator (text used to separate website name from page title)
    :suffix (text between separator and page title)
    :lowercase (when true, the page name will be lowercase)
    :reverse (when true, the page and site names will be reversed)
    :default (default title to use when title is blank)

And here are a few examples to give you ideas.

    <%= title :separator => "&mdash;" %>
    <%= title :prefix => false, :separator => ":" %>
    <%= title :lowercase => true %>
    <%= title :reverse => true, :prefix => false %>
    <%= title :default => "The ultimate site for Rails" %>


Dealing with special pages
==========================

How do you set the page title without showing it in the view?

    <% title "My page title" %>

What if your view headline is different from your page title?

    <%= title "My page title", "My headline" %>


Mr. T says, ‘Use my method, fool!’
==================================

Just like ERB's HTML safe method, you can invoke Headliner with a single letter alias.

    <h1><%=t "My page title" %></h1>
    
Note: this alias conflicts with the Rails Internationalization (I18n) API translation method (since it provides the same alias). If you're app requires I18n support, you should use one of [these](http://github.com/nivanson/headliner) [forks](http://github.com/galfert/headliner) on Github.


How does it work?
=================

Ruby on Rails renders actions *before* inserting them into layouts. So, if you set a variable in your view, it will be accessible in your layout. But, at first glance, it looks like you're using a variable (in the head) before it's been assigned a value (in the body). Cool, huh?


Contributors
============

Special thanks to James Chan, Nick Zadrozny, and Jordan Fowler. 


Feedback
========

Comments and patches welcome at [http://github.com/mokolabs/headliner/](http://github.com/mokolabs/headliner/).
