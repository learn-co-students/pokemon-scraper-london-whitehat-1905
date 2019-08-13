class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(name:, type:, db:, hp: nil, id:)
    { name: name, type: type, db: db, hp: hp, id: id }.each_pair do |key, val|
      send("#{key}=", val)
    end
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = ?
    SQL
    retrieved_id, name, type, hp = db.execute(sql, id).first
    new(id: id, name: name, type: type, db: db, hp: hp)
  end

end

