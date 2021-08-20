# frozen_string_literal: true

class Manage
  include TrainMethods
  include StationMethods
  include RouteMethods
  include CarriageMethods

  attr_accessor :trains, :carriages, :stations, :routes, :menu, :items

  def initialize
    @trains = []
    @carriages = []
    @stations = []
    @routes = []
    @menu = Menu.new
    @menu.items = Items.new
  end
end
