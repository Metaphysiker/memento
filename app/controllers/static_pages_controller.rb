class StaticPagesController < ApplicationController
  def welcome
  end

  def activities

  end

  def playfield
    @people = Person.all.order(:name).page(params[:page])
  end
end
