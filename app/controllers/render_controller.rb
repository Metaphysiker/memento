class RenderController < ApplicationController
  def render_shared
    parent_type = params[:parent_type]
    parent_id = params[:parent_id]

    @parent = parent_type.singularize.classify.constantize.find(parent_id)

    respond_to do |format|
        format.js
    end
  end
end
