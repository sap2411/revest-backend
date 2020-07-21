# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u = User.create(email: 'email@email.com', password: 'Password', first_name: "Steven", last_name: "Parsons", income: 3000.0, age: 23)


home = Category.create(name: "Home", min: 400.0, max: 5000.0, percentage: 0.31, tags: "Home Rent House Mortgage Utilities")
food = Category.create(name: "Food", min: 150.0, max: 700.0, percentage: 0.12, tags: "Food Supermarkets and Groceries")
insurance = Category.create(name: "Health and Insurance", min: 0.0, max: 1000.0, percentage: 0.10, tags: "Insurance Medical Health")
transport = Category.create(name: "Transportation", min: 0.0, max: 1000.0, percentage: 0.10, tags: "Public Transportation Services Airlines and Aviation Services Vehicle Gas Travel Service")
expenses = Category.create(name: "Subscriptions and Expenses", min: 0.0, max: 2000.0, percentage: 0.7, tags: "Recurring Recreation Subscription Donations Telecommunication Services")
material_goods = Category.create(name: "Material Goods", min: 0.0, max: 800.0, percentage: 0.9, tags: "Shops")
venmo = Category.create(name: "Venmo", min: 0.0, max: 5000.0, percentage: 0.08, tags: "Venmo")
interest = Category.create(name: "Interest", min: 0.0, max: 5000.0, percentage: 0.08, tags: "Interest Earned")
misc = Category.create(name: "Misc", min: 0.0, max: 5000.0, percentage: 0.08, tags: "null")

# homeb = Budget.create(user_id: 1, amount: 1800.0, category_id: 1)
# foodb = Budget.create(user_id: 1, amount: 430.0, category_id: 2)
# insuranceb = Budget.create(user_id: 1, amount: 0.0, category_id: 3)
# transportb = Budget.create(user_id: 1, amount: 30.0, category_id: 4)
# expensesb = Budget.create(user_id: 1, amount: 350.0, category_id: 5)
# material_goodsb = Budget.create(user_id: 1, amount: 100.0, category_id: 6)
# miscb = Budget.create(user_id: 1, amount: 100.0, category_id: 7)

# th = Transaction.create(amount:1750 , date: "2001", name: "Rent", iso_currency_code: "USD", account_id: 1234, plaid_id: 1234, category_id: 1, user_id:1)
# tb = Transaction.create(amount:50 , date: "2001", name: "Utility", iso_currency_code: "USD", account_id: 1234, plaid_id: 1234, category_id: 1, user_id:1)
# Groceries
# Food
# Transportation and Gas
# Travel and Car Service
# Subscriptions Recurring donation
# Rent - Utilities
# Shops clothing electronics
# Venmo
# Interest
# Misc




