class BackOffice

  def self.add_registry
    params = {}
    # Read new card
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
    user_name = gets.chomp
    card = Card.find_by(user_name: user_name)
    if card
      puts "Swipe new card"
      new_card_id = $port.scan
      unless Card.exists?(card_id: new_card_id)
        card.update_attribute(:card_id, new_card_id)
        puts "Registry updated."
      else
        puts "Card is in use."
      end
    else
      puts "User not found"
    end
  end

  def verify_balace

  end

end