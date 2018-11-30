class ImportController < ApplicationController
  def upload_page

  end

  def institution

  end

  def people
    file = params[:file]

    CSV.foreach(file.path, headers: true) do |row|
      person = row.to_hash
      functionality = row["functionality"].split(' | ') unless row["functionality"].nil?
      target_group = row["target_group"].split(' | ') unless row["target_group"].nil?
      institutions = row["institutions"].split(' | ') unless row["institutions"].nil?

      Person.create_or_update_person(person, functionality, target_group, institutions)
    end

    redirect_to upload_page_path, notice: "CSV importiert!"
  end

  def testing

  end

end
