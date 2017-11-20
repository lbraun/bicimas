require 'open-uri'

class Station < ApplicationRecord
  has_many :station_status_records

  validates_uniqueness_of :number

  def google_maps_name
    "Bicicas Station #{number} - #{name}"
  end

  def google_maps_link
    query =
      if [1, 3, 41, 42, 48, 49, 50, 51, 52, 58].include?(number)
        "#{coordinate_y}, #{coordinate_x}"
      else
        google_maps_name
      end
    "https://www.google.com/maps?q=#{query}"
  end

  def average_bikes_available(options = {})
    ssr = station_status_records
    ssr = ssr.from_hour(options[:hour]) if options[:hour].present?
    ssr = ssr.send(options[:scope]) if options[:scope].present?
    ssr.average(:bikes_available).try(:round)
  end

  def chart_data(scope = nil)
    data = (0..23).map { |hour| average_bikes_available(hour: hour, scope: scope) || 'null' }
    "[#{data.join(', ')}]"
  end

  def capacity
    last_status.anchors.scan(/number/).count
  end

  def last_status
    station_status_records.last
  end

  def self.pull_data
    url = ENV['BICICAS_DATA_URL']
    file = open(url)
    contents = file.read
    bench_hashes = JSON.parse(contents)['features']
    bench_hashes.each { |bench_hash| update_or_create_station(bench_hash) }
  end

  def self.update_or_create_station(bench_hash)
    extracted_number = bench_hash["properties"]["name"].split('.').first.to_i
    coordinates = bench_hash["geometry"]["coordinates"]
    pretty_name = pretty_name_dictionary[extracted_number]

    station = Station.find_by_number(extracted_number)

    if station.nil?
      station = create!(
        number: extracted_number,
        coordinate_x: coordinates.first,
        coordinate_y: coordinates.last,
        name: pretty_name,
      )
    end

    station.station_status_records.create!(
      bikes_total: bench_hash["properties"]["bikes_total"],
      bikes_available: bench_hash["properties"]["bikes_available"],
      anchors: bench_hash["properties"]["anchors"],
      last_seen: bench_hash["properties"]["last_seen"],
      online: bench_hash["properties"]["online"],
      ip: bench_hash["properties"]["ip"],
      number_loans: bench_hash["properties"]["number_loans"],
    )
  end

  def self.pretty_name_dictionary
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
