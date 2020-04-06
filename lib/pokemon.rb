class Pokemon

    attr_accessor :name, :type, :id, :db
    def initialize(id:, name:, type:, db:)
        @name = name
        @type = type
        @id = id
        @db = db

    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        LIMIT 1
        SQL

        db.execute(sql, id).map do |row|
            self.new_from_db(row, db)
        end.first
    end

    def self.new_from_db(row, db)
       
        id, name, type = row[0], row[1], row[2]
        new_pokemon = self.new(id: id, name: name, type: type, db: db)
        new_pokemon

    end




end
