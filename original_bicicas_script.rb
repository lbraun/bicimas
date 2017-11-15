require 'open-uri'
require 'json'
require 'facets/string/titlecase'
require 'csv'
require 'highline/import'
require 'terminal-table'

class Bicicas
  attr_reader :benches

  def initialize
    load_data
  end

  def load_data
    @url ||= 'https://ws2.bicicas.es/bench_status_map'
    file = open(@url)
    contents = file.read

    bicicas_hash = JSON.parse(contents)
    bench_hashes = bicicas_hash["features"]
    @benches = bench_hashes.map { |bench_hash| Bench.new(bench_hash) }
  end

  def get_bench(bench_id)
    benches.find { |bench| bench.id == bench_id }
  end

  def generate_csv
    timestamp = Time.now.strftime('%Y_%m_%d_%H_%M_%S')

    fields = [
      :id,
      :latitude,
      :longitude,
      :name_prettified,
      :capacity,
      :number_loans,
      :ip,
      :google_maps_coordinates,
      :google_maps_name,
    ]

    CSV.open("bicicas_#{timestamp}.csv", "w") do |csv|
      csv << fields.map { |field| field.to_s } # Headers

      benches.each do |bench|
        csv << fields.map { |field| bench.send(field) } # Values
      end
    end
  end

  def print_favorite_bench_information
    favorite_benches = [46, 1, 47, 54, 33, 12, 10].map { |id| get_bench(id) }
    output = ""

    favorite_benches.each do |bench|
      output += "#{bench.google_maps_name}\n"
    end

    headings = %w(id capacity available total)

    rows = []
    favorite_benches.each do |bench|
      rows << [
        bench.id,
        bench.capacity,
        bench.bikes_available,
        bench.bikes_total,
      ]
    end

    puts output + "\n"
    puts Terminal::Table.new(headings: headings, rows: rows)
  end
end

class Bench
  attr_reader :coordinates, :name, :bikes_total, :bikes_available, :anchors, :last_seen, :online, :ip, :number_loans, :id

  def initialize(bench_hash)
    @coordinates = bench_hash["geometry"]["coordinates"]
    @name = bench_hash["properties"]["name"]
    @bikes_total = bench_hash["properties"]["bikes_total"]
    @bikes_available = bench_hash["properties"]["bikes_available"]
    @anchors = bench_hash["properties"]["anchors"]
    @last_seen = bench_hash["properties"]["last_seen"]
    @online = bench_hash["properties"]["online"]
    @ip = bench_hash["properties"]["ip"]
    @number_loans = bench_hash["properties"]["number_loans"]


    @id = @name.split('.').first.to_i
  end

  def longitude
    coordinates.first
  end

  def latitude
    coordinates.last
  end

  def google_maps_coordinates
    coordinates.reverse.join(', ') # Coordinates are stored as x, y; google takes them as y, x
  end

  def google_maps_name
    "Bicicas Station #{id} - #{name_prettified}"
  end

  def name_without_id
    name[4..-1]
  end

  def name_prettified
    pretty_dictionary[id]
  end

  def capacity
    anchors.count
  end

  def pretty_dictionary
    {
      1 => "UJI - FCHS",
      2 => "Estación de Ferrocarril y Autobuses",
      3 => "Plaza de Pescadería",
      4 => "Paseo Buenavista-Grao",
      5 => "Hospital General",
      6 => "Plaza de la Libertad",
      7 => "Plaza Teodoro Izquierdo",
      8 => "Plaza Primer Molí",
      9 => "Patronat Desports",
      10 => "Plaza Doctor Marañón",
      11 => "Plaza Juez Borrull",
      12 => "Escuela Oficial de Idiomas",
      13 => "Tenencia Alcaldia Oeste",
      14 => "Plaza Maestrazgo",
      15 => "Huerto Sogueros",
      16 => "Hospital Provincial",
      17 => "Plaza del Real",
      18 => "Museo Bellas Artes",
      19 => "Planetario",
      20 => "Plaza Muralla Liberal",
      21 => "Piscina Olímpica",
      22 => "Poliesportiu Ciutat de Castelló",
      23 => "Paseo de la Universidad",
      24 => "Alcora",
      26 => "Donoso Cortes",
      27 => "Rio Adra",
      28 => "Plaza Botanico Calduch",
      29 => "Parque Geologo José Royo",
      30 => "Plaza Fernando Herrero Tejedor",
      31 => "Ginjols",
      32 => "Avda. Ferrandis Salvador",
      33 => "Avda. Sos Baynat",
      34 => "Avda. del Rey",
      35 => "Rio Nilo",
      36 => "Tombatossals",
      37 => "Plaza Cardona Vives",
      38 => "Paseo Morella",
      39 => "Parque del Oeste",
      40 => "Av. del Mar",
      41 => "Plaza la Paz",
      42 => "Avda Vall D`Uxo-Cardenal Costa",
      43 => "Fernando el Católico",
      44 => "San Roque",
      45 => "Gran Via",
      46 => "UJI - ESTCE",
      47 => "UJI - FCJE",
      48 => "Plaza Clave",
      49 => "Casal Jove",
      50 => "Avda. Valencia (Grupo Lidón)",
      51 => "San Agustín",
      52 => "Av. del Mar - Recinto de Ferias",
      53 => "Farola",
      54 => "UJI - Paynopain",
      55 => "Bicicas",
      56 => "Tirant Lo Blanch - Pinar",
      57 => "Grupo Lourdes",
      58 => "Plaza Sequiol",
    }
  end
end

bicicas = Bicicas.new
input = nil

until %w(q quit Q QUIT stop end).include?(input) do
  input = ask "\nDo you want to:
    (1) make a csv,
    (2) check on favorites,
    (3) lookup a certain bench, or
    (4) refresh the data?
  "

  case input
  when "1"
    bicicas.generate_csv
    puts "Done!"
  when "2"
    bicicas.print_favorite_bench_information
  when "3"
    bench_id = ask("\nWhat's the bench's ID? ", Integer) { |id| id.in = 1..58 }
    bench = bicicas.get_bench(bench_id)
    puts "\nHere you go!"
    puts "\tCoordinates: #{bench.google_maps_coordinates}"
    puts "\tName: #{bench.google_maps_name}"
  when "4"
    bicicas = Bicicas.new
  end
end