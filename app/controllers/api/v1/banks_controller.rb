class Api::V1::BanksController < AuthorizeController
  before_action :find_bank, only: %i[show update destroy]

  def total
    @banks = Bank.select('id').all.count
    render_success_format(@banks)
  end

  def index
    @banks = Bank.order(name: :desc)
    render_success_format(@banks)
  end

  def show
    if @bank.present?
      render json: @bank, status: :ok
      return
    end
    render json: {}, status: :not_found
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.save!
      render_success_format(@bank, I18n.t('messages.models.bank.created'), :created)
    end
  rescue => error
    render_api_error(error, :unprocessable_entity)
  end

  def destroy
    if @bank.present?
      @bank.delete
      render json: {}, status: :no_content
      return
    end
    render json: {}, status: :not_found
  end

  def update
    if @bank.present?
      if @bank.update!(bank_params)
        render json: @bank, status: :ok
        return
      end
    end
    render json: {}, status: :not_found
  rescue => error
    render_api_error(error, :unprocessable_entity)
  end

  private
  def bank_params
    params.permit(:name)
  end

  def find_bank
    @bank = Bank.find_by_id(params[:id])
  end
end
