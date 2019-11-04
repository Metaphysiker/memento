class Search
  include ApplicationHelper

  def initializex(search_term: nil, model: "Person", tag_list: nil, institutions: nil, assigned_to_user_id: nil, page: 0, language: nil)
    @search_term = search_term
    @tags = tag_list
    @institutions = institutions
    @model = model
    @assigned_to_user_id = assigned_to_user_id
    @page = page
    @records = []
  end

  def initialize(search_inputs)
    @selection = search_inputs[:selection] || nil
    @search_term = search_inputs[:search_term] || nil
    @tags = search_inputs[:tag_list] || nil
    @functionalities = search_inputs[:functionality_list] || nil
    @target_groups = search_inputs[:target_group_list] || nil
    @institutions = search_inputs[:institutions] || nil
    @topics = search_inputs[:topics] || nil
    @groups = search_inputs[:groups] || nil
    @model = search_inputs[:model] || "Person"
    @assigned_to_user_id = search_inputs[:assigned_to_user_id] || nil
    @language = search_inputs[:language] || nil
    @page = search_inputs[:page] || 0
    @records = []
  end

  def search
    klass = class_for(@model)
    #klass = @model

    if klass == Person
      @records = PeopleSearch.new(selection: @selection, groups: @groups, search_term: @search_term, tags: @tags, target_groups: @target_groups, functionalities: @functionalities, institutions: @institutions, topics: @topics, language: @language).search
      @records = @records.order(:name)
    elsif klass == Institution
      @records = InstitutionsSearch.new(search_term: @search_term, tags: @tags, target_groups: @target_groups, functionalities: @functionalities, institutions: @institutions, language: @language).search
      @records = @records.order(:name)
    elsif klass == Note
      @records = NotesSearch.new(search_term: @search_term, tags: @tags, institutions: @institutions).search
      @records = @records.order(:created_at)
    elsif klass == Task
      @records = TasksSearch.new(search_term: @search_term, tags: @tags, institutions: @institutions, assigned_to_user_id: @assigned_to_user_id).search
      @records = @records.order(:created_at)
    elsif klass == Project
      @records = ProjectsSearch.new(search_term: @search_term).search
      @records = @records.order(:name)
    elsif klass == Group
      @records = GroupsSearch.new(search_term: @search_term).search
      @records = @records.order(:name)
    elsif klass == Blog
      @records = BlogsSearch.new(search_term: @search_term).search
      @records = @records.order(:planned_date)
    end
    #@records.page(@page).per(20)
  end

end
