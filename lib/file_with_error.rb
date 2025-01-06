class FileWithError
  # Hardcoded credentials (known pattern)
  AWS_ACCESS_KEY_ID = "AKIAIOSFODNN7EXAMPLE"
  AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  DATABASE_PASSWORD = "super-secret-password"

  def print_secrets
    puts "AWS Access Key ID: #{AWS_ACCESS_KEY_ID}"
    puts "AWS Secret Access Key: #{AWS_SECRET_ACCESS_KEY}"
    puts "Database Password: #{DATABASE_PASSWORD}"
  end

  def error_code
    result = 100 / 0
    puts result
  end
end
