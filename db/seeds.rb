# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u = User.create(email: 'email@email.com', password_digest: 'Password', first_name: "Steven", last_name: "Parsons", income: 3000.0, age: 23)


home = Category.create(name: "Home", min: 400.0, max: 5000.0, percentage: 0.30, tags: "Home Rent House Apartment Mortgage Utilities Utility")
food = Category.create(name: "Food", min: 100.0, max: 700.0, percentage: 0.12, tags: "Food Drink Beverage Restaurant Restaurants")
insurance = Category.create(name: "Insurance", min: 0.0, max: 5000.0, percentage: 0.10, tags: "Insurance Medical Health")
transport = Category.create(name: "Transport", min: 0.0, max: 800.0, percentage: 0.12, tags: "Car Vehicle Gas Transportation Travel")
expenses = Category.create(name: "Expenses", min: 0.0, max: 2000.0, percentage: 0.24, tags: "Recurring Subscription Debt Bill Donation Plan")
material_goods = Category.create(name: "Material Goods", min: 0.0, max: 800.0, percentage: 0.04, tags: "Store Shops Goods Clothing Electronics")
misc = Category.create(name: "Misc", min: 0.0, max: 5000.0, percentage: 0.08, tags: "Entertainment Vacation Undefined")

homeb = Budget.create(user_id: 1, amount: 1800.0, category_id: 1)
foodb = Budget.create(user_id: 1, amount: 430.0, category_id: 2)
insuranceb = Budget.create(user_id: 1, amount: 0.0, category_id: 3)
transportb = Budget.create(user_id: 1, amount: 30.0, category_id: 4)
expensesb = Budget.create(user_id: 1, amount: 350.0, category_id: 5)
material_goodsb = Budget.create(user_id: 1, amount: 100.0, category_id: 6)
miscb = Budget.create(user_id: 1, amount: 100.0, category_id: 7)

th = Transaction.create(amount:1750 , date: "2001", name: "Rent", iso_currency_code: "USD", account_id: 1234, plaid_id: 1234, category_id: 1, user_id:1)
tb = Transaction.create(amount:50 , date: "2001", name: "Utility", iso_currency_code: "USD", account_id: 1234, plaid_id: 1234, category_id: 1, user_id:1)




