class Project

attr_reader :id
attr_accessor :title

def initialize(attr)
  @id = attr.fetch(:id)
  @title = attr.fetch(:title)
end

def save
  result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') returning id;")
  @id = result.first().fetch('id').to_i()
  return result
end

def self.all
  return_title = DB.exec('SELECT * FROM projects;')
  title_arrays = []
  return_title.each() do |item|
    id = item.fetch('id').to_i
    title = item.fetch('title')
    title_arrays.push(Project.new({:id => id, :title => title}))
  end
    title_arrays
end


  def ==(another_project)
    (self.title.==another_project.title).&(self.id.==another_project.id)
  end

  def self.find(id)
    id_finder = nil
    Project.all().each() do |item|
      if item.id().==(id)
        id_finder = item
      end
    end
    id_finder
  end

  def volunteers
    array_volunteers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id};")
    volunteers.each do |volunteer|
      id = volunteer["id"].to_i
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      array_volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
    end
    array_volunteers

   end

def update(attributes)
    @title = attributes.fetch(:title)
    @id = self.id()
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
   end

end
