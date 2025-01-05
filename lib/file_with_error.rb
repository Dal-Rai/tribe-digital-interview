class VulnerableClass
  def execute_code(user_input)
    # Intentionally vulnerable code
    eval(user_input) # This allows execution of arbitrary code, which is unsafe
  end
end
