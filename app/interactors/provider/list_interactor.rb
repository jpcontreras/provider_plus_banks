class Provider::ListInteractor
  include Interactor

  def call
    page = context.page
    context.data = Provider.with_paginate_10((page || 1)).order("id desc")
  rescue StandardError => error
    context.fail!(error: error)
  end
end