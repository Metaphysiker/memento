json.extract! task, :id, :description, :deadline, :priority, :assigned_to_user_id, :done, :created_at, :updated_at
json.url task_url(task, format: :json)
