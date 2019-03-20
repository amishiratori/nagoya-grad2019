require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'
require 'sinatra/base'


enable :sessions

helpers do
  def current_user
    User.find(session[:user])
  end
end

before do
  path = ['/','/login','/active_mentor','/add_question','/add_video','/post_question','/post_video','/count']
  unless path.include?(request.path_info)
    if current_user.nil?
      redirect '/'
    end
  end
end

get '/' do
  erb :index
end

get '/login' do
  if session[:user]
    redirect '/user'
  end
  erb :login
end

post '/login' do
  user = User.find_by(user_name: params[:name])
  date = params[:date].split('-')
  if user.blank?
    @error = "名前#{params[:name]}が見つかりません"
  elsif user.mentor_name == params[:mentor_name] && user.month == date[1].to_i && user.date == date[2].to_i
    session[:user] = user.id
    redirect '/user'
  elsif user.mentor_name != params[:mentor_name]
    @error = "メンター名#{params[:mentor_name]}が見つかりません"
  elsif user.month != date[1] || user.date != date[2]
    @error = '誕生日が違います'
  end
  erb :login
end

get '/user' do
  erb :main_page
end

get '/start_quiz' do
  questions = current_user.questions.where(clear: false)
  number = questions[rand(questions.length)].id
  redirect "/quiz/#{number}"
end

get '/quiz/:id' do
  @quiz = Question.find(params[:id])
  erb :quiz
end

post '/quiz/check/:id' do
  quiz = Question.find(params[:id])
  select_answer = params[:select_answer].to_i
  score = current_user.score
  if quiz.answer == select_answer
    current_user.update_column(:score, score + 1)
    quiz.update_column(:clear, true)
    index = current_user.videos.where(played: false)
    number = index[rand(index.length)].id
    redirect  "/video/#{number}"
  end
  questions = current_user.questions.where(clear: false)
  number = questions[rand(questions.length)].id
  redirect  "/quiz/#{number}"
end

get '/video/:id' do
  @video = current_user.videos.find(params[:id])
  @video.update_column(:played, true)
  erb :video
end

get '/video' do
  @videos = current_user.videos.where(played: true)
  erb :video_all
end


get '/active_mentor' do
  erb :active_mentor
end

get '/add_question' do
  erb :form
end

post '/post_question' do
  user = User.find(params[:mentor].to_i)
  user.questions.create({
    author: params[:author],
    quiz: params[:quiz],
    choice1: params[:choice1],
    choice2: params[:choice2],
    choice3: params[:choice3],
    answer: params[:answer].to_i
  })
  redirect '/active_mentor'
end

get '/add_video' do
  erb :form
end

post '/post_video' do
  user = User.find(params[:mentor].to_i)
  user.videos.create({
    author: params[:author],
    url: params[:url]
  })
  redirect '/active_mentor'
end


get '/count' do
  @users = User.all
  erb :count
end