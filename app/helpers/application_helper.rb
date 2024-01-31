module ApplicationHelper

  def locale
    I18n.locale == :en ? "Estados Unidos" : "Português do Brasil"
  end

  def date_br(date_us)
    date_us.strftime("%d/%m/%Y")
  end

  def app_name
    "CRYPTO WALLET APP"
  end

  def enviroment
    if Rails.env.development?
      "Desenvolvimento"
    elsif Rails.env.production?
      "Produção"
    else
      "Teste"
    end
  end
end
