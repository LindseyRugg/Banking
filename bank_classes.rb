class Account
	attr_reader :acct_number, :balance, :acct_type
	attr_accessor :customer

	def initialize(acct_number, balance, acct_type, customer)
		@acct_number = acct_number
		@balance = balance
		@acct_type = acct_type
		@customer = customer
	end

	def deposit
		puts "How much would you like to deposit?"
		print "$"
		amount = gets.chomp.to_f
		@balance += amount
		puts "Deposit of $#{'%0.2f'%(amount)} successful"
		puts "Your new balance is $#{'%0.2f'%(@balance)}"
	end

	def withdrawal
		puts "How much would you like to withdraw?"
		print "$"
		amount = gets.chomp.to_f
		puts "Please confirm withdrawal of $#{'%0.2f'%(amount)} (Y/N)"
		confirm = gets.chomp.downcase
		if confirm == "y"
			if @balance < amount
				puts "Your account does not have sufficient funds to withdraw $#{'%0.2f'%(amount)}"
			else
				@balance -= amount
				puts "Withdrawal of $#{'%0.2f'%(amount)} successful"
			end
			puts "Your balance is $#{'%0.2f'%(@balance)}"
		else
			withdrawal
		end

	end

end


class Customer
	attr_accessor :f_name, :l_name
	attr_reader :username, :pin

	def initialize(f_name, l_name, username, pin)
		@f_name = f_name
		@l_name = l_name
		@username = username
		@pin = pin
	end

	def change_data
		puts "#{@f_name} #{l_name}, your current username is #{@username} (username is not case sensitive)"
		confirmed = false
		until confirmed
			print "Please enter new username: "
			new_usrnm1 = gets.chomp.downcase
			print "\nPlease confirm new username: "
			new_usrnm2 = gets.chomp.downcase
			if new_usrnm1 == new_usrnm2
				confirmed = true
				@username = new_usrnm1
				puts "Change confirmed! Your new username is #{@username}"
			end
		end

	end

	def change_pin
		puts "#{@f_name} #{l_name}, your current PIN is #{@pin}"
		confirmed = false
		until confirmed
			print "Please enter new PIN (4-digit number): "
			new_pin1 = gets.chomp
			print "\nPlease confirm new PIN: "
			new_pin2 = gets.chomp
			if new_pin1 == new_pin2 && new_pin1.length == 4 && "0123456789".include?(new_pin1)
				confirmed = true
				@pin = new_pin1
				puts "Change confirmed! Your new PIN is #{@pin}"
			else
				puts "Change not valid, try again."
			end
		end

	end

end
