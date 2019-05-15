class Pokemon

  attr_accessor :name, :type, :id, :hp
  attr_reader :db

  def initialize(id:nil,name:,type:,db:,hp: nil)
    @id = id
    @name = name
    @type = type
    @db = db
    unless hp.nil? then @hp = hp end
  end

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon (name, type)
    VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
    # @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT * FROM pokemon
    WHERE id = ?
    LIMIT 1
    SQL
    db.execute(sql, id).map{|pokemon| self.new(id: pokemon[0],name: pokemon[1],type: pokemon[2],db: db, hp: pokemon[3])}.first
  end

  def alter_hp(newhp, db)
    @hp = newhp
    sql = <<-SQL
    UPDATE pokemon SET hp = ?
    SQL
    db.execute(sql, newhp)
  end

end
