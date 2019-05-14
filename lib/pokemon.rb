class Pokemon
    attr_reader :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = "INSERT INTO pokemon (name, type) VALUES ('#{name}', '#{type}');"
        db.execute(sql)
    end

    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = #{id};"
        row = db.execute(sql)[0]
        Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)
    end

end
