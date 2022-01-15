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

  # Calculates which where the most performant sites (sites with more pageviews) with their number of pageviews,
  # in descending order in a given month.
  def best_performant_sites(month)
    projects = projects_from_month(month)
    sites = projects.map { |project| project['sites'] }.flatten.uniq
    sites.map do |site|
      [site, projects.select { |project| project['sites'].include? site }
                     .map { |project| project['pageviews'] }.sum]
    end.sort_by { |site| site[1] }.reverse
  end

  
  private

  def projects_from_month(month)
    @data.select { |project| Date.parse(project['created_at']).month == month }
  end

end
