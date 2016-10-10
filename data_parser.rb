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

  def determine_pilot
    @pilot = ("Fry" if destination == " Earth") || ("Amy" if destination == " Mars") || ("Bender" if destination == " Uranus") || "Lela"
  end


end


log = import.collect { |row| Log.new(row)}

profit = log.reduce(0) { |sum, trip| sum + trip.money }

grouped = log.group_by { |job| job.pilot }

groupedbyplanet = log.group_by { |job| job.destination }

grouped.each { |job| puts job.inspect }

puts profit

grouped.each { |pilot, trip| puts trip }

new_file = File.open("./report.html", "w+")
new_file << ERB.new(File.read("report.html.erb")).result(binding)
new_file.close
