# README

##Clone project

> git clone https://github.com/Dal-Rai/tribe-digital-interview.git

> _bundle install_


##How to run

_i. Using Rake_

> bundle exec rake services:calc_bundle_price["10 IMG 15 FLAC 13 VID"]

_ii. Using Rails Console_
> _rails c_

> PostService.new("10 IMG 15 FLAC 13 VID").print_result


##How to Add a new format

Search for bundle_price.yml

Add a new submission format

###Eg:

PDF:

  `-` 4: 670
  
     6: 1000
    
     10: 1630

