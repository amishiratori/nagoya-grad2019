ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")

class User < ActiveRecord::Base
  has_many :questions
  has_many :videos
end

class Question < ActiveRecord::Base
  belongs_to :user
end

class Video < ActiveRecord::Base
  belongs_to :user
end