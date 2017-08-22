class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = policy_scope(Contact)
    render json: { data: @contacts }
  end

  # GET /contacts/1
  def show
    authorize @contact, :show?
    render json: { data: @contact }
  end

  # POST /contacts
  def create
    @contact = current_user.contacts.new(contact_params)
    authorize @contact, :create?

    if @contact.save
      render json: { data: @contact }
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /contacts/1
  def update
    authorize @contact, :update?

    if @contact.update(contact_params)
      render json: { data: @contact }
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    authorize @contact, :destroy?

    @contact.destroy
    render json: { success: true }
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit( :email, :first_name, :last_name)
  end
end
