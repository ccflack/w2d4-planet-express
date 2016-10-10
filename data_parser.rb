require 'csv'
require 'ERB'

import = CSV.foreach("planet_express_logs.csv", headers: true, :header_converters => :symbol)

class Log
  attr_accessor :destination,
                :shipment,
                :crates,
                :money,
                :pilot

  def initialize(destination:, shipment:, crates:, money:)
    @destination = destination
    @shipment = shipment
    @crates = crates
    @money = money.to_i
    determine_pilot
  end

  def preferred_planet
  end

  def determine_pilot
    # In place of:
    # if destination == " Earth"
    #   @pilot = "Fry"
    # elsif destination == " Mars"
    #   @pilot = "Amy"
    # elsif destination == " Uranus"
    #   @pilot = "Bender"
    # else
    #   @pilot = "Lela"
    # end
    @pilot = ("Fry" if destination == " Earth") || ("Amy" if destination == " Mars") || ("Bender" if destination == " Uranus") || "Lela"
  end

  # def pilot_flew
  #   log.each {|job| }
  #
  # def bonus
  #   bonus =
  # end

end



# puts log.preferred_planet

log = import.collect { |row| Log.new(row)}

profit = log.reduce(0) { |sum, trip| sum + trip.money }

grouped = log.group_by { |job| job.pilot }

groupedbyplanet = log.group_by { |job| job.destination }

grouped.each { |job| puts job.inspect }

puts profit

grouped.each { |pilot, trip| puts trip }



# lela_job_count = grouped.each {|pilot, job| job.each {|detail| detail(-1) == "Lela".count }}
# amy_job_count =
# fry_job_count =
# bender_job_count =

# puts "Lela has #{lela_job_count} jobs"
# puts "Amy has #{amy_job_count} jobs"
# puts "Fry has #{fry_job_count} jobs"
# puts "Bender has #{bender_job_count} jobs"
#
#
# log.each {|job| puts job.inspect }
#
# puts grouped.each { |k, v| puts k, v.each { |value| puts value.money}}
# log.each { |job| puts "#{job.pilot} got a bonus of #{job.bonus}"}


new_file = File.open("./report.html", "w+")
new_file << ERB.new(File.read("report.html.erb")).result(binding)
new_file.close
