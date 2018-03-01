class EmailsController < ApplicationController
  before_action :all_emails, only: [:index, :create, :update, :destroy]
  before_action :set_emails, only: [:edit, :update, :destroy]
  respond_to :html, :js
  def index
    @emails = Email.all
    @email = Email.first
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(emails_params)
    if @email.save #Redirection vers la view 'show' qui affiche les détails et les options du nouveau ragot
      redirect_to root_path
    else
      render 'new' #Redirection vers la page 'new' en cas d'échec de création d'un nouveau ragot
    end
  end

  def show
    all_emails
    @email = Email.find(params[:id])
    @email.save
     
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to emails_path
    
  end

  private #on ne récupère de la view que les données qui nous intéressent (anonyme_user et content) - placé ici dans le script par convention
    def emails_params
      params.permit(:object, :body)

    end
     def all_emails
      @emails = Email.all.sort { |a,b| b.created_at <=> a.created_at }
      @emails_unread = Email.where(read: false)
    end

    def set_emails
      @email = Email.find(params[:id])
    end
end
