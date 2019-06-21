get '/' do
    "Ok"
end

get '/*' do 
	display_error "This is just a template", "Not implemented"
end

not_found do
  @title = "Error 404"
  @error = @title
  @msg   = "The page doesn't exist"
  haml :error
end
