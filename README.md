# Basket [![Build Status](https://travis-ci.org/enemycnt/basket.svg?branch=master)](https://travis-ci.org/enemycnt/basket) [![Code Climate](https://codeclimate.com/github/enemycnt/basket/badges/gpa.svg)](https://codeclimate.com/github/enemycnt/basket) [![Test Coverage](https://codeclimate.com/github/enemycnt/basket/badges/coverage.svg)](https://codeclimate.com/github/enemycnt/basket)

Simple CLI basket application with taxes.

The application is created to read product data from CSV and print product data with tax summary to $stdout.
Additionally it save results to CSV file.

## Installation
Developed and tested on OSX 10.10.1, but should work on linux as well.
Before we start please ensure that you have [rvm](https://rvm.io/rvm/install) and [ruby 2.1.5](https://rvm.io/rubies/installing) installed on your developer workstation.

Pull source from github:

    $ git clone git@github.com:enemycnt/basket.git

Then cd to `basket` dir and install dependencies with bundler:

    $ bundle install


## Usage

The app has executable in `bin` folder.
It takes only one parameter path.

    $ ./bin/basket.rb data/input1.csv

It will parse data from input CSV and calculate gross prices with total summary.
After finish you will see output in console as well as path to CSV export.

```

    Hello. Lets work

    1, book, 12.49
    1, music cd, 16.49
    1, chocolate bar, 0.85

    Sales Taxes: 1.50
    Total: 29.83


    CSV exported to data/input1_exported.csv

    Bye
```

## Input format of CSV
Ensure that you have input CSV in comma separated format as shown in example below:

```
    10, chocolates, 199.50
```

Example with data types:

```
    Integer, String, Float
```


## Testing
App contains rspec tests that you can find in `spec` dir.
To test application simply run rspec command:

    $ rspec