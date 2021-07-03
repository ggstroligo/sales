## Installation
### Dependencies
- Ruby 2.6 >
- Yarn 1.22 >
- SQLite

### Running
```bash
> git clone git@github.com:ggstroligo/sales.git
> bundle install
> yarn
> bin/webpack
> rails s -p 3000
```
Access on browser localhost:3000
You have example of .tab files on [/docs/examples](https://github.com/ggstroligo/sales/blob/master/docs/) to upload on the application.

## About the challenge
You've received a text file (tab separated) with data describing the company sales. We need a way for this data to be imported to a database to be analyzed later.

Your job is to create a web interface that accepts file uploads, normalizes the data and stores it in a relational database.

Your application MUST:

1.  Accept (via HTML form) file uploads of TAB-separated files, with the following columns: `purchaser name`, `item description`, `item price`, `purchase count`, `merchant address`, `merchant name`. You can assume the columns will always be in that order, and that there will always be some value in each column, and that there will always be a header row. An example file called `example_input.tab` is included on this repo.
2.  Interpret (parse) the received file, normalize the data, and save the data correctly in a relational database. Don't forget to model the entities imported from the file data, considering their relationships.
3.  Show the total gross income represented by the sales data after each file upload, and also the total all-time gross income.
4.  Be written in Ruby 2.5 or greater (or, in the language solicited by the job description, if any).
5.  Have good automated tests coverage.
6.  Be simple to configure and execute, running on a Unix-compatible environment (Linux or macOS).
7.  Use only free / open-source language and libraries.

## My thoughts about the solution
I chose to do this challenge using a use-case based architecture, which is a bit of what I've been studying recently. It wasn't exactly as I would have liked due to the lack of time I had to complete it, but I liked the final result.

With that said, let's cut to the chase.

## The solution
At the first, I made an entity relationship diagram (ERD) to have a well-defined path.

![Entity relationship Diagram](https://github.com/ggstroligo/sales/blob/master/docs/ER%20diagram.png)

About the DBMS I chose SQLite, cause of it practicity

Then, I start thinking about the architecture, and as I said, I chose to use a use-case based architecture, instead of bloated services.

At the first I thought a file structure like:
```
models/
..customer.rb
..merchant.rb
..order.rb
..product.rb
..sale.rb
..order/
....item.rb
use_cases/ (hold all complex use case flow logics) 
..sales_report/
....collect.rb
....step/
......parse_entry.rb
......persist_data.rb
services/
..presenters/ (prepare view data based on controller#action)
....sales/
......index.rb
......show.rb
```

## What's next?
- [ ] Abstract queries steps into a base class
- [ ] Add helper/delegator methods to models
- [ ] Improve serialization base
- [ ] Improve front-end with any modern reactive framework (hotwire, react)
- [ ] Improve error handler
