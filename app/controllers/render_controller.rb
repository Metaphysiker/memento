class RenderController < ApplicationController
  def render_shared
    parent_type = params[:parent_type]
    parent_id = params[:parent_id]

    klass = class_for(parent_type)

    @parent = klass.find(parent_id)
    @random_div = SecureRandom.uuid

    render partial: "shared/children"
=begin
      respond_to do |format|
          format.js
      end
=end
  end

  def render_index
    model = params[:search_inputs][:model]

    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: model, random_div: SecureRandom.uuid)
    end
    @records = Search.new(@search_inputs).search
    @records = @records.page(params[:page]).per(20)

    render partial: "basic/index"
  end

  def render_tags
    @tag_lists = TagList.all

    render partial: "tag_lists/index"
  end

  def render_project_people
    @project = Project.find(params[:project_id])

    render partial: "projects/project_people"
  end

  def render_group_people
    @group = Group.find(params[:group_id])

    render partial: "groups/group_people"
  end

end
