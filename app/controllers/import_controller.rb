require 'csv'

class ImportController < ApplicationController
  def import_people_page

  end

  def import_people
    file = params[:file]

    CSV.foreach(file.path, headers: true) do |row|
      person = row.to_hash
      institutions = row["institutions"].split(' ') unless row["institutions"].nil?
      groups = row["groups"].split(' ') unless row["groups"].nil?
      functionality = row["functionality"].split(' ') unless row["functionality"].nil?
      target_group = row["target_group"].split(' ') unless row["target_group"].nil?
      address = row.to_hash

      Person.create_or_update_person(person, institutions, groups, functionality, target_group, address)
    end

    redirect_to import_people_page_path, notice: "CSV importiert!"
  end

  def import_institutions

  end

  def institutions_import_page

  end

  def import_working_hours_page

  end

  def import_working_hours
    file = params[:file]

    CSV.foreach(file.path, headers: true) do |row|
      working_hour = row.to_hash
      WorkingHour.create(working_hour)
    end

    redirect_to import_working_hours_page_path, notice: "CSV importiert!"
  end

  def testing

  end

end
