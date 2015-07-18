require_relative '../../lib/graph'

class Map < ActiveRecord::Base
  has_many :paths, dependent: :destroy

  validates :name, presence: true

  with_options allow_blank: true do |v|
    v.validates :name, uniqueness: true
  end

  def to_graph
    paths.map { |p| [p.from, p.to, p.distance.to_f] }
  end

  def to_show
    to_graph.map(&:to_s).join("\n")
  end

  def search_path(path, fuel)
    graph = Graph.new(to_graph)
    start, stop = [path.from, path.to]
    found_path, dist = graph.shortest_path(start, stop)
    autonomy = path.distance
    distance = dist
    cost = (distance / autonomy) * fuel
    [found_path, cost]
  end
end
