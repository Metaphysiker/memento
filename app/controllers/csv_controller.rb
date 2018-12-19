require 'csv'

class CsvController < ApplicationController
  def basic_csv
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search

    send_data @records.to_csv, filename: "#{@search_inputs.model.to_s}-#{Date.today}.csv"
  end

  def headers_csv
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search

    send_data @records.headers_to_csv, filename: "headers.csv"
  end

  def example_csv
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search

    send_data @records.example_csv, filename: "headers.csv"
  end
end
