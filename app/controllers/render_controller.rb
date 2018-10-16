class RenderController < ApplicationController
  def render_shared
    parent_type = params[:parent_type]
    parent_id = params[:parent_id]

    allowed_models = ["Person"]

    if allowed_models.include?(parent_type)
      klass = allowed_models[allowed_models.index(parent_type)]
      @parent = klass.singularize.classify.constantize.find(parent_id)
    end

    render partial: "shared/children"
=begin
      respond_to do |format|
          format.js
      end
=end
  end
end
