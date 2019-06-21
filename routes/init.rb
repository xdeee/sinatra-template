def display_error text = "Unknown error", title = "Error"
  @title = title
  @error = title
  @msg   = text
  halt haml(:error)
end

require_all(__FILE__)
