require 'net/http'

namespace :sync do

  task users: :environment do
    getusers
  end

  task societies: :environment do
    getsocieties
  end

  task totalsync: :environment do
    getusers
    getsocieties
  end

  def getusers
    url      = 'http://localhost:3000/getusers'
    uri      = URI(url)
    response = Net::HTTP.get(uri)
    response2 = JSON.parse(response)
    response3 = response2.first
    users = response3.second

    users.each do |u|
      if Person.find_by_philosophie_id(u["id"]).nil?
        create_person(u)
      end
    end
  end

  def create_person(user)
    user = OpenStruct.new(user)
    Person.create(
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email,
      created_at: user.created_at,
      updated_at: user.updated_at,
      philosophie_id: user.id,
      gender: user.gender
    )
  end

  def sync_person(user)
    user = OpenStruct.new(user)

    update_if_value_is_different(Person, user.id, :firstname, user.firstname)
    update_if_value_is_different(Person, user.id, :lastname, user.lastname)
    update_if_value_is_different(Person, user.id, :email, user.email)
  end

  def update_if_value_is_different(klass, philosophie_id, attribute, value)

    if klass.find_by_philosophie_id(philosophie_id)[attribute] != value
      klass.find_by_philosophie_id(philosophie_id).update_attribute(attribute, value)
    end

  end

  def getsocieties
  url      = 'http://localhost:3000/getsocieties'
  uri      = URI(url)
  response = Net::HTTP.get(uri)
  response2 = JSON.parse(response)
  response3 = response2.first
  societies = response3.second

  societies.each do |s|
    society = OpenStruct.new(s)

    Institution.create(
      name: society.name,
      philosophie_society_id: society.id
    )
    society.profiles.each do |p|
      puts p["id"]
      Person.find_by_philosophie_id(p["id"]).institutions << Institution.find_by_philosophie_society_id(society.id) unless Person.find_by_philosophie_id(p["id"]).nil?
    end
  end

end

end
