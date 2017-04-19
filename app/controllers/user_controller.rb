enable :sessions

post '/login' do
	if params[:button] == "Sign Up"
		redirect '/signup'
	else
		user = User.find_by(email: params[:email])
		if user == nil
			# user does not exist
		else
			if user.authenticate(params[:password]) == user
				session[:id]=user.id
				redirect '/'
			else
				# password does not match
			end
		end
	end
end

post '/signup' do
	user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:reconfirm])
	if user.save
		redirect '/login'
	else
		# flash some message
		redirect '/signup'
	end
end

get '/logout' do
	session[:id] = nil
	redirect '/login'
end