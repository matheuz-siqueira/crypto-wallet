class WelcomeController < ApplicationController
  def index
    cookies[:course] = "Course of Ruby on Rails"
    @meu_nome = params[:nome]
  end
end
