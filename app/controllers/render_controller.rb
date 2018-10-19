class RenderController < ApplicationController
  def render_shared
    parent_type = params[:parent_type]
    parent_id = params[:parent_id]

    klass = class_for(parent_type)

    @parent = klass.find(parent_id)

    render partial: "shared/children"
=begin
      respond_to do |format|
          format.js
      end
=end
  end
end
