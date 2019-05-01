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

  def institutions_import_page

  end

  def import_institutions
    file = params[:file]

    CSV.foreach(file.path, headers: true) do |row|

      institution = row.to_hash
      functionality = row["functionality"].split(' ') unless row["functionality"].nil?
      target_group = row["target_group"].split(' ') unless row["target_group"].nil?
      address = row.to_hash

      Institution.create_or_update_institution(institution, functionality, target_group, address)
    end

    redirect_to import_institutions_page_path, notice: "CSV importiert!"
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

  def import_work_time
    file = params[:file]

    CSV.foreach(file.path, headers: true) do |row|
      next if row["time"].blank?
      username = row["username"].downcase
      puts username
      puts User.where(username: username.capitalize).empty?
      unless User.where(username: username.capitalize).empty?
        work_time = row.to_hash
        puts work_time
        work_time.store("user_id", User.where(username: username.capitalize).last.id)
        work_time.except!("username")
        WorkTime.create(work_time)
      end
    end

    redirect_to my_worktime_path, notice: "CSV importiert!"
  end

  def testing

  end

end
