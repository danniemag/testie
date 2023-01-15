# Testie
Rails app for scheduling management.

____________

## Setting up environment

```ruby
ruby version: 2.7.7

rails version: 5.2.8.1

database: postgresql

users:
  - email: one@tlink.com | pwd: userOne*
  - email: two@tlink.com | pwd: userTwo*
```

* Clone this project
* Setup project `rake db:setup` (seeds available)
* Start server `rails s`
* Execute it locally on base url [`localhost:3000`](http://localhost:3000).


## Overview 
The application can be accessed through this URL:
[`https://testie.herokuapp.com/users/sign_in`](https://testie.herokuapp.com/users/sign_in)


## Acceptance Criteria

| AC                                         | Completed?        |
|:-------------------------------------------|:------------------|
| `[BE] Ruby on Rails`                       | YES               |
| `[FE] React`                               | NO                |
| `Day and duration as inputs`               | YES               |
| `List of possible times on chosen day`     | YES               |
| `Slot booking on multiples of 15min`       | YES               |
| `Display some form of confirmation`        | YES               |
| `Users shall not book an overlapping slot` | YES               |
| `Automated tests`                          | YES               |
| `Make the app FE look nice`                | Well, I tried! :D |
| `Use WebSockets`                           | NO                |


## Significant External Libraries

```ruby
Devise
  #=> An authentication solution that I simply love!

ToastUI Calendar
  #=> A JS calendar with several customization options for use with vanilla, jquery, react and vue
```
