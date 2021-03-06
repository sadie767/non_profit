class Volunteer

attr_reader :id, :project_id
attr_accessor :name

def initialize(attr)
  @id = attr.fetch(:id)
  @name = attr.fetch(:name)
  @project_id = attr.fetch(:project_id)
end

def ==(another_volunteer)
  (self.name.==another_volunteer.name).&(self.id.==another_volunteer.id)

end

def update(attributes)
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE projects SET title = '#{@name}' WHERE id = #{@id};")
  end

def self.all
  return_name = DB.exec('SELECT * FROM volunteers;')
  name_arrays = []
  return_name.each() do |item|
    id = item.fetch('id').to_i
    name = item.fetch('name')
    project_id = item.fetch('project_id')
    name_arrays.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
  end
    name_arrays
end

def save
  result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') returning id;")
  @id = result.first().fetch('id').to_i()
  return result
end

def self.find(id)
  id_finder = nil
  Volunteer.all().each() do |item|
    if item.id().==(id)
      id_finder = item
    end
  end
  id_finder
end


end
