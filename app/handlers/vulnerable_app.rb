require 'sinatra'

class VulnerableApp < Sinatra::Base
  # Hardcoded secret (vulnerable)
  SECRET_KEY = "super-secret-key"

  # Unsafe user input usage (command injection)
  get '/execute' do
    user_input = params[:cmd]
    result = `#{user_input}` # Vulnerable to command injection
    "Command output: #{result}"
  end

  # SQL Injection vulnerability
  get '/user' do
    user_id = params[:id]
    result = ActiveRecord::Base.connection.execute("SELECT * FROM users WHERE id = '#{user_id}'")
    "User info: #{result.to_a}"
  end
end
