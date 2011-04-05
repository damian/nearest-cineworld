require 'rubygems'
require 'crack/json'

namespace :cineworld do
  desc "Get cinemas"
  task :update_cinemas => :environment do
    cineworld = Cineworld::API.new(Settings.cineworld_api_key)
    cineworld.cinemas(:full => true)['cinemas'].each do |cinema|
      Cinema.create do |c|
        c.name = cinema['name']
        c.address = cinema['address']
        c.postcode = cinema['postcode']
        c.cinema_url = cinema['cinema_url']
        c.telephone = cinema['telephone']
        c.cinema_id = cinema['id']
      end
      puts "#{cinema['name']}\n"
    end
  end

  desc "Get films"
  task :update_films => :environment do
    cineworld = Cineworld::API.new(Settings.cineworld_api_key)
    cineworld.films(:full => true)['films'].each do |film|

      Film.create do |f|
        f.edi = film['edi']
        f.title = film['title']
        f.classification = film['classification']
        f.poster_url = film['poster_url']
        f.film_url = film['film_url']
        f.still_url = film['still_url']
        f.advisory = film['advisory']
      end
      puts "#{film['title']}\n"
    end
  end

  desc "Get performances"
  task :update_performances => :environment do
    date = Date.today
    today = date.strftime('%Y%m%d')
    tomorrow = (date + 1).strftime('%Y%m%d')
    cineworld = Cineworld::API.new(Settings.cineworld_api_key)
    Film.all.each do |film|
      Cinema.all.each do |cinema|
        [tomorrow].each do |date|
          cineworld.performances(:date => date, :cinema => cinema.id, :film => film.edi)['performances'].each do |performance|
            Performance.create(:time => performance['time'], :available => performance['available'], :performance_type => performance['type'], :ad => performance['ad'], :subtitled => performance['subtitled'], :booking_url => performance['booking_url'], :cinema_id => cinema.id, :film_id => film.edi, :date => date)
          end
        end
      end
    end
  end

  desc "Update films and performances"
  task :films_and_performances => [:update_films, :update_performances]
end

