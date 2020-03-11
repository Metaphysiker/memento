class StaticPagesController < ApplicationController
  def welcome
    @people = Person.order(:name).page(params[:page]).per(20)
    @tag_lists = TagList.all.order(:name)
    @institutions = Institution.order(:name).page(params[:page]).per(20)
  end

  def activities
    @audits = Audited::Audit.order(:created_at).reverse_order.page(params[:page]).per(50)
  end

  def worktime
    @worktimes = WorkTime.where(user_id: current_user.id)
  end

  def overview
=begin
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
      @search_inputs = OpenStruct.new(model: klass)
    end
=end

  if params[:search_inputs].present?
    @search_inputs = OpenStruct.new(params[:search_inputs])
  else
    @search_inputs = OpenStruct.new(model: "Person")
  end
  @records = Search.new(@search_inputs).search
  @records = @records.page(params[:page]).per(20)

    #@records = Search.new(model: klass, search_term: search_term, tag_list: tag_list, institutions: institutions, assigned_to_user_id: assigned_to_user_id, page: params[:page]).search
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
    user_id = params[:user_id]
    if user_id.blank?
      @user = current_user
    else
      @user = User.find(user_id)
    end

    @tasks = Task.where(assigned_to_user_id: user_id).order(:created_at).page(params[:page]).per(20)
  end

  def playfield
    if params.fetch(:project_information, {}).fetch(:selection, false)
      selection = params[:project_information][:selection]
    end
    if params.fetch(:project_information, {}).fetch(:project, false)
      project = Project.find(params[:project_information][:project])
      project.people << Person.where(id: selection)
    end
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new(model: "Person", selection: selection)
    end

    @records = Person.where.not(id: project.person_ids) unless project.nil?
    @records = Person.all if project.nil?
    #@records = @records.page(params[:page]).per(20)
  end

  def team

  end

  def merch_showcase

  end

  def members

  end

  def manual
  end


end
