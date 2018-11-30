class ImportController < ApplicationController
  def upload_page

  end

  def institution

  end

  def people
    file = params[:file]

    CSV.foreach(file.path, headers: true) do |row|
      Person.create_or_update_person(row.to_hash, row["tag"].split(' | '), row["institutions"].split(' | '))
    end

    redirect_to upload_page_path, notice: "CSV importiert!"
  end

  def testing

  end

end
