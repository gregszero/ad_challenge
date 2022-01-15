# frozen_string_literal: true

# This class fetch data from a URL and parses the result calculating metrics.
class Metric
  require 'net/http'
  require 'json'
  require 'date'

  # Initialize a new Metric object with the given URL to fetch data.
  def initialize(source)
    response = Net::HTTP.get_response(URI.parse(source))
    @data = JSON.parse(response.body)
  end

  # Calculates the most bookmarked projects in a given market (site) in a given month, sorted by number of bookmarks
  # in descending order.
  def most_bookmarked_projects(site, month)
    projects_from_month(month).select { |project| (project['sites'].include? site) }
                              .sort_by { |project| project['bookmarks'].count }
                              .reverse
                              .map { |project| project['title'] }
  end

  private

  def projects_from_month(month)
    @data.select { |project| Date.parse(project['created_at']).month == month }
  end

end
