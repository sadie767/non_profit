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
  @volunteer = Volunteer.all
  erb(:index)
end

post('/projects') do
  id = params[:id]
  title = params['title']
  @project_input = Project.new({:id => nil, :title => title})
  @project_input.save()
  @project = Project.all
  erb(:index)
end

get('/projects/:id') do
  @project_id = params[:id]
  @project_input = Project.find(params.fetch("id").to_i)
  @volunteer = Volunteer.all
  erb(:projects)
end

get('/edit/:id') do
  @projects_id = params[:id]
  @project_input = Project.find(params.fetch("id").to_i)
  erb(:project_edit)
end


patch("/projects/:id/update") do
  title = params["title"]
  @project_input = Project.find(params.fetch("id").to_i)
  @project_input.update({:title => title})
  erb(:project_edit)
end

delete('/projects/:id/delete') do
  @project_id = params[:id]
  @project_input = Project.find(params.fetch("id").to_i)
  @project_input.delete()
  @project = Project.all()
  erb(:index)
end

post('/projects/:project_id/add_volunteer') do
  project_id = params[:project_id]
  name = params['name']
  new_volunteer = Volunteer.new({:id => nil, :name => name, :project_id => project_id})
  new_volunteer.save
  @volunteer = Volunteer.all()
  redirect("/projects/#{project_id}")
end

get("/volunteer_edit/:id") do
  @volunteer_input = Volunteer.find(params.fetch("id").to_i)
  erb(:volunteer_edit)
end

patch("/volunteer/:id" ) do
name = params["name"]
@volunteer_input = Volunteer.find(params.fetch("id").to_i)
@volunteer_input.update({:name => name})
erb(:volunteer_edit)
end
