enable :sessions

post '/login' do
	if params[:button] == "Sign Up"
		redirect '/signup'
	else
		user = User.find_by(email: params[:email])
		if user == nil
			flash[:message] = "Email address not found"
			redirect '/login'
		else
			if user.authenticate(params[:password]) == user
				session[:id]=user.id
				redirect '/'
			else
				flash[:message] = "Incorrect password"
				redirect '/login'
			end
		end
	end
end

post '/signup' do
	user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:reconfirm])
	if params.values.include?("")
		flash[:message] = "Please fill up required field"
		redirect '/signup'
	else
		if user.save
			session[:id] = user.id
			redirect '/'
		else
			if user.errors.messages.keys[0] == :password_confirmation
				flash[:message] = "Password does not match"
			else
				flash[:message] = user.errors.messages.values[0]
			end
			redirect '/signup'
		end
	end
end

get '/logout' do
	session[:id] = nil
	redirect '/login'
end