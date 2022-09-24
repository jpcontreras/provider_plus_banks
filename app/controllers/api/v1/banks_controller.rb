class Api::V1::BanksController < ApplicationController
  before_action :find_bank, only: %i[show update destroy]

  def index
    @banks = Bank.order(name: :desc)
    render json: @banks, status: :ok
  end

  def show
    if @bank.presence
      render json: @bank, status: :ok
      return
    end
    render json: {}, status: :not_found
  end

  def create
    @bank = Bank.new(bank_params)
    @bank.save!
    render json: @bank, status: :created
  rescue => error
    render json: error.message, status: :unprocessable_entity
  end

  def destroy
    @bank.delete
    render json: '', status: :no_content
  end

  def update
    @bank.update(bank_params)
    render json: @bank, status: :ok
  end

  private
  def bank_params
    params.permit(:name)
  end

  def find_bank
    @bank = Bank.find_by_id(params[:id])
  end
end
