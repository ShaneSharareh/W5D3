require 'singleton'
require 'sqlite3'

class QuestionsDB < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end 

class Question 
    attr_accessor :title, :body
    attr_reader :id
    def self.find_by_id(id)
        result = QuestionsDB.instance.execute(<<-SQL, id)
        SELECT 
            *
        FROM 
            questions 
        WHERE
            id = ?
        SQL
        Question.new(result.first)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
    end

end

class User
    attr_accessor :fname, :lname
    attr_reader :id

    def self.find_by_name(fname, lname)
        result = QuestionsDB.instance.execute(<<-SQL, fname, lname)
        SELECT
            *
        FROM
            users
        WHERE
            fname = ? AND lname = ?
        SQL
        User.new(result.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

end

class QuestionFollows 
      attr_reader :id
    def self.find_by_id(id)
        result = QuestionsDB.instance.execute(<<-SQL, id)
        SELECT 
            *
        FROM 
            questions 
        WHERE
            id = ?
        SQL
        QuestionFollows.new(result.first)
    end

def initialize(options)
        @id = options['id']
    end
end

class Reply 
    attr_reader :id
    def self.find_by_id(id)
        result = QuestionsDB.instance.execute(<<-SQL, id)
        SELECT 
            *
        FROM 
            questions 
        WHERE
            id = ?
        SQL
        Reply.new(result.first)
    end

      def initialize(options)
        @id = options['id']
    end


end

class QuestionLikes 
    attr_accessor :question, :user
    attr_reader :id
    def self.find_by_id(id)
        result = QuestionsDB.instance.execute(<<-SQL, id)
        SELECT 
            *
        FROM 
            questions 
        WHERE
            id = ?
        SQL
        QuestionLikes.new(result.first)
    end

    def initialize(options)
        @id = options['id']
        @question = options['question']
        @user = options['user']
    end


end


