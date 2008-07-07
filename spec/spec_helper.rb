require 'rubygems'
require 'action_controller'
require 'action_view'
require File.join(File.dirname(__FILE__), "../lib/headliner")

ActionView::Base.class_eval do
  include Headliner
end