require_relative 'bank_classes'

@customers = []
@accounts = Array.new
@current_customer = ""

def welcome_menu
	puts "Welcome to The Bank"
	puts "PLease choose a number from this list:"
	puts "1. Customer sign in"
	puts "2. New Customer sign up"
	puts "3. Exit"
	user_choice = nil
	until user_choice
		user_choice = gets.chomp.to_i
		case user_choice
		when 1 then sign_in
		when 2 then sign_up("","")
		when 3 then sign_out
		else
			puts "Not a valid entry, please try again."
			welcome_menu
		end
	end
end

def sign_in
	print "Enter username: "
	username = gets.chomp.downcase
	print "Enter PIN: "
	pin = gets.chomp.to_i
	customer_exists = false
	@customers.each do |customer|
		if username == customer.username && pin == customer.pin
			@current_customer = customer
			customer_exists = true
		end
	end
	if customer_exists
		account_menu
	else
		puts "Sorry, no customer found for #{username}"
		puts "1. Try again?"
		puts "2. Sign Up"
		puts "3. Exit"
		choice = gets.chomp.to_i
		case choice
		when 1 then sign_in
		when 2 then sign_up(username, pin)
		when 3 then sign_out
		else
			puts "Not a valid entry."
			welcome_menu
	end
end

def sign_up(username, pin)
	puts "Welcome to sign up, please enter your information as follows."
	print "First name: "
	f_name = gets.chomp
	print "Last name: "
	l_name = gets.chomp
	if username == "" && pin == ""
		print "Enter username: "
		username = gets.chomp.downcase
		print "Enter PIN: "
		pin = gets.chomp.to_i
	end
	@current_customer = Customer.new(f_name, l_name, username, pin)
	@customers << @current_customer
	puts "Thank you, #{@current_customer.f_name} #{@current_customer.l_name} is successfully signed up as #{@current_customer.username}!"
	account_menu
end

def account_menu
	puts "Account Menu"
	puts "1. Create an Account"
	puts "2. Review an Account"
	puts "3. Sign Out"
	choice = gets.chomp.to_i
	case choice
		when 1
			create_account
		when 2
			if @accounts.length > 0
				review_account
			else
				puts "No accounts"
				account_menu
			end
		when 3
			sign_out
		else
			puts "Selection not valid, try again."
			account_menu
	end
end

def create_account
	puts "Choose account type:"
	puts "1. Savings Account"
	puts "2. Checking Account"
	puts "3. Return to Account Menu"
	choice = gets.chomp.to_i
	case choice
	when 1 then
		type = "savings"
		make_acct(type)
	when 2 then
		type = "checking"
		make_acct(type)
	when 3 then account_menu
	else
		puts "Choice not valid, try again."
		create_account
	end
end

def make_acct(type)
	puts "How much money will you deposit?"
	print "$ "
	deposit = gets.chomp.to_f
	account_number = (@accounts.length + 1).to_s
	new_acct = Account.new(account_number, deposit, type, @current_customer)
	@accounts << new_acct
	puts "#{f_name}, congratulations your new #{type} account was successfully created with $#{new_acct.balance}.
	Your account number is #{new_acct.acct_number}."
	account_menu
end

def review_acct
	@current_account = ""
	counter = 0
	puts "Please enter the account number you want to review:"
	@accounts.each do |acct|
		if acct.username == @current_customer.username
			puts "#{acct.acct_number} #{acct.type}"
			counter += 1
		end
	end
	choice = gets.chomp
	@accounts.each do |acct|
		if @current_customer == acct.customer && choice == acct.acct_number
			@current_account = acct
		end
	end
	if @current_account.length > 0
		account_actions
	else
		account_menu
	end
end

def account_actions
	puts "Choose From the Following:"
	puts "1. Check My Balance"
	puts "2. Make a Deposit"
	puts "3. Make a Withdrawal"
	puts "4. Return to Account Menu"
	puts "5. Sign Out"

	choice = gets.chomp.to_i

	case choice
		when 1
			puts "Current balance is $#{'%0.2f'%(@current_account.balance)}"
			account_actions
		when 2
			@current_account.deposit
			account_actions
		when 3
			@current_account.withdrawal
			account_actions
		when 4
			review_account
		when 5
			sign_out
		else
			puts "Invalid selection."
			account_actions
	end
end

def sign_out
	@current_customer = ""
	@current_account = ""
	puts "Thanks for visiting My Bank"
end
