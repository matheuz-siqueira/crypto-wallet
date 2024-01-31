namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Gerando migrações...") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

  desc "Cadastra de moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
        {
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAyL3JtNDY3LWNyeXB0b2N1cnJlbmN5LTAxMy5wbmc.png",
          mining_type: MiningType.find_by(acronym: 'PoW')
        },

        {
          description: "Etherium",
          acronym: "ETH",
          url_image: "https://banner2.cleanpng.com/20190418/rgf/kisspng-ethereum-portable-network-graphics-computer-icons-developers-icon-request-icon-ethereum-5cb941c1cb12b1.1213852915556448658318.jpg",
          mining_type: MiningType.all.sample
        },

        {
          description: "Dash",
          acronym: "DASH",
          url_image: "https://cryptologos.cc/logos/dash-dash-logo.png",
          mining_type: MiningType.all.sample
        },

        {
          description: "Iota",
          acronym: "IOT",
          url_image: "https://cryptonaute.fr/wp-content/uploads/2021/01/IOTA-logo.png",
          mining_type: MiningType.all.sample
        },

        {
          description: "ZCash",
          acronym: "ZEC",
          url_image: "https://w7.pngwing.com/pngs/85/465/png-transparent-zec-crypto-cryptocurrency-cryptocurrencies-cash-money-bank-payment-icon-thumbnail.png",
          mining_type: MiningType.all.sample
        }
      ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastro os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        { description: "Proof of Work", acronym: "PoW" },
        { description: "Proof of Stake", acronym: "PoS" },
        { description: "Proof of Capacity", acronym: "PoC" }
      ]

      mining_types.each do |mt|
        MiningType.find_or_create_by!(mt)
      end
    end
  end

  private
  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end
