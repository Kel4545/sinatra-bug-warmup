require "sinatra"
require "gschool_database_connection"
require "rack-flash"



class App < Sinatra::Base
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    erb :home
  end

  get "/register" do
    erb :register
  end

  post "/registrations" do
    insert_sql = <<-SQL
      INSERT INTO users (username, email, password, name_is_hunter)
      VALUES ('#{params[:username]}', '#{params[:email]}', '#{params[:password]}', '#{params[:name_is_hunter]}')
    SQL

    # write this to check debugging puts "=" * 20
    # puts insert_sql
    # puts "=" * 20

    @database_connection.sql(insert_sql)
    flash[:notice] = "Thanks for signing up"

    redirect "/"
  end
end