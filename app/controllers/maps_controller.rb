class MapsController < ApplicationController
  include Parser

  before_action :set_map, only: [:show, :update, :search]

  respond_to :text

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @maps = Map.all
    respond_with @maps
  end

  def show
    respond_with @map
  end

  def create
    @map = Map.new name: params[:id]
    paths = parser_body
    @map.paths << paths
    @map.save
    head :no_content
  end

  def update
    paths = parser_body
    @map.paths.replace(paths)
    @map.save
    head :no_content
  end

  def destroy
    @map = Map.find_by(name: params[:id])
    @map.destroy
    head :no_content
  end

  def search
    path, fuel = Parser.parse_entry(request.body.read)
    @shortest_path = @map.search_path(path, fuel).join(' ')
    respond_with @shortest_path
  end

  private
  def handle_not_found
    head :not_found
  end

  def set_map
    @map = Map.where(name: params[:id]).includes(:paths).take!
  end

  def parser_body
    Parser.parse_file(request.body.read)
  end
end
