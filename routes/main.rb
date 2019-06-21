get '/' do
    "Ok"
end

get '/*' do 
	display_error "This is just a template", "Not implemented"
end

not_found do
  @title = "Ошибка 404"
  @error = @title
  @msg   = "Такой страницы не существует"
  haml :error
end
