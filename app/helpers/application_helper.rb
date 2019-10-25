module ApplicationHelper

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

  def is_admin?
    current_user.role == "admin"
  end

  def is_current_user_admin?
    !current_user.nil? && current_user.role == "admin"
  end

  def is_nil_or_empty? value
    value.nil? || value.empty?
  end

  def is_model_allowed?(name_of_model)

    allowed_models = ["Person", "Institution", "Note", "Task"]

    allowed_models.include?(name_of_model)

  end

  def class_for(name_of_model)
    allowed_models = ["Person", "Institution", "Note", "Task", "Project", "Group", "Blog"]
    if allowed_models.include?(name_of_model)
      klass = allowed_models[allowed_models.index(name_of_model)]
      return klass.singularize.classify.constantize
    else
      raise "ModelNotAllowed"
    end
  end

end
