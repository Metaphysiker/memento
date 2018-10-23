class StaticPagesController < ApplicationController
  def welcome
    @people = Person.order(:name).page(params[:page]).per(20)
    @tag_lists = TagList.all.order(:name)
    @institutions = Institution.order(:name).page(params[:page]).per(20)
  end

  def activities

  end

  def overview
    @people = Person.order(:name).page(params[:page]).per(20) #Person.all.includes(:notes)
    #@search_inputs = {search_term: "Mann", model: Person, tags: ""}
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
