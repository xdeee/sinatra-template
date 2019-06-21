def display_error text = "Неизвестная ошибка", title = "Ошибка"
  @title = title
  @error = title
  @msg   = text
  halt haml(:error)
end

require_all(__FILE__)
