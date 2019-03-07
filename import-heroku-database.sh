rm -f latest.dump
heroku pg:backups:capture
heroku pg:backups:download
pg_restore --verbose --clean -d memento_development latest.dump
