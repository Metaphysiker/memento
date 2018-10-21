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
    #@notes = Note.all.order(:created_at).reverse_order
    @tag_lists = TagList.all.order(:name)
    #@tasks = Task.all
    @institutions = Institution.order(:name).page(params[:page]).per(20)
    @notes = Note.order(:created_at).page(params[:page]).per(20)
    @tasks = Task.order(:created_at).page(params[:page]).per(20)
  end

  def my_tasks
    @tasks = Task.where(assigned_to_user_id: current_user.id).order(:created_at).page(params[:page]).per(20)
  end

  def playfield
    @people = Person.all.order(:name).page(params[:page])
  end
end
