json.extract! blog, :id, :planned_date, :language, :working_title, :submitted, :published, :author_informed, :created_at, :updated_at
json.url blog_url(blog, format: :json)
