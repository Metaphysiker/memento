class StaticPagesController < ApplicationController
  def welcome
    @people = Person.order(:name).page(params[:page]).per(20)
    @tag_lists = TagList.all.order(:name)
    @institutions = Institution.order(:name).page(params[:page]).per(20)
  end

  def activities

  end

  def overview

    if params[:search_inputs].present?
      search_inputs = params[:search_inputs]
      klass = class_for(search_inputs[:model])
      search_term = search_inputs[:search_term]
      institutions = search_inputs[:institutions]
      tag_list = search_inputs[:tag_list]
      assigned_to_user_id = search_inputs[:assigned_to_user_id]
      @search_inputs = OpenStruct.new(search_inputs)
    else
      klass = Person
    end

    @records = Search.new(model: klass, search_term: search_term, tag_list: tag_list, institutions: institutions, assigned_to_user_id: assigned_to_user_id, page: params[:page]).search
    #@people = Person.order(:name).page(params[:page]).per(20) #Person.all.includes(:notes)


    #@search_inputs = {search_term: "Mann", model: Person, tags: ""}
=begin
    if params[:search_inputs].present?
      search_inputs = params[:search_inputs]
      model = search_inputs[:model]
      search_term = search_inputs[:search_term]
      institutions = search_inputs[:institutions]
      tag_list = search_inputs[:tag_list]
      klass = class_for(model)
    else
      klass =  Person
      search_term = ""
      institutions = ""
      tag_list = ""
    end

    @records = Search.new(model: klass, search_term: search_term, tag_list: tag_list, institutions: institutions, page: params[:page]).search
    @search_inputs = params[:search_inputs]
=end
  end

  def my_tasks
    @tasks = Task.where(assigned_to_user_id: current_user.id).order(:created_at).page(params[:page]).per(20)
  end

  def playfield
    @people = Person.all.order(:name).page(params[:page])
  end

  def team

  end
end
