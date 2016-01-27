class BackOffice

  def self.add_registry
    params = {}
    # Read new card
    puts "Please swipe new card."
    params[:card_id] = $port.scan
    # Verify if exist
    card = Card.find_by(card_id: params[:card_id])
    unless card
      # Ask for user name
      puts "Name of card holder:"
      params[:user_name] = gets.chomp
      # Puts initial balance
      puts "Set initial balance:"
      params[:balance] = gets.chomp
      # Saves new card
      card = Card.create(params)
      puts "Card has been added."
    else
      puts "Card has already been added."
    end
  end

  def self.change_card_id
    params = {}
    puts "Name of card holder:"
    params[:user_name] = gets.chomp
    card = Card.find_by(user_name: params[:user_name])
    if card
      puts "Please swipe new card."
      params[:card_id] = $port.scan
      unless Card.exists?(card_id: params[:card_id])
        card.update_attribute(:card_id, params[:card_id])
        puts "User updated."
      else
        puts "Card is in use."
      end
    else
      puts "User not found."
    end
  end

  def self.pay_toll
    params = {}
    puts "Please swipe card."
    params[:card_id] = $port.scan
    card = Card.find_by(card_id: params[:card_id])
    if card 
      if card.balance > 10
        card.update_attribute(:balance, card.balance - 10)
        $port.open_toll
        puts "Your balance is: " + card.balance.to_s 
        puts "Have a good day."
      else
        puts "Not enough money, please make a deposit."
      end
    else
      puts "Card doesn't exist."
    end
  end

  def self.add_founds
    params = {}
    puts "Please swipe card."
    params[:card_id] = $port.scan
    card = Card.find_by(card_id: params[:card_id])
    if card
      puts "Amount to add?"
      params[:balance] = gets.chomp.to_i
      card.update_attribute(:balance, params[:balance] + card.balance)
      puts "Amount updated."
    else
      puts "Card doesn't exist."
    end
  end

end
