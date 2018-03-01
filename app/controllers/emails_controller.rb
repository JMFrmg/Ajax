class EmailsController < ApplicationController 
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
    @emails = Email.all
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
end
