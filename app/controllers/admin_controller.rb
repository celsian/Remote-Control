class AdminController < ApplicationController
  def index

  end

  def notes
    @notes = Note.all
  end
end
