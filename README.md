# BigFoos

For tracking foosball games at Bigcommerce. Complete with rankings, auto-matchmaking, team balancing, achievements, and more.

## Setup

```
bundle install
rake db:create
rake db:migrate
rake db:seed_fu
```

## Testing

```
rspec
```

## TODO

* Add `piece` to Score model to pinpoint what piece made the score
* Improve UI to have foosball-table view for score logging and player selection
* Add hash dictionary of all pieces on foosball table for telling what piece is where
