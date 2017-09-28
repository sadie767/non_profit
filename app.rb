require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/volunteer')
require('./lib/project')
require("pg")
require("pry")

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get('/') do
  @project = Project.all
  erb(:index)
end

post('/new_titles') do
  id = params[:id]
  @title = params['title']
  new_title = Project.new({:id => id, :title => @title})
  new_title.save
  @project = Project.all()
  erb(:index)
end


get('/projects/:id/edit') do
  @project_input = Project.find(params.fetch("id").to_i())
  erb(:title_edit)
end


patch("/change_titles/:id/edit") do
  id = params[:id]
  @title = params["title"]
  @project_input = Project.find(params.fetch("id").to_i())
  @project_input.update({:title => @title})
  redirect('/')
end

get('/projects/:id/delete') do
  @project_input = Project.find(params.fetch("id").to_i())
  erb(:title_edit)
end

delete ('/delete_titles/:id/delete') do
  @id = params[:id]
  @title = params['title']
  @project_input = Project.find(params.fetch("id").to_i())
  @project_input.delete()
  @project = Project.all()
  redirect('/')
end
