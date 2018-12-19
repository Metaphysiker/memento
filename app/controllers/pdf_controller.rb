class PdfController < ApplicationController

  def basic_pdf
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person")
    end
    @records = Search.new(@search_inputs).search

    send_data render_to_string(pdf: "#{@search_inputs.model.to_s}-#{Date.today}",
                               template: "basic/pdf.html.erb",
                               layout: "pdf_layout.html",
                               dpi: 75), filename: "#{@search_inputs.model.to_s}-#{Date.today}.pdf"
  end

end
