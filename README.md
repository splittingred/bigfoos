# BigFoos

For tracking foosball games at Bigcommerce.


## Setup

```
rake db:create
rake db:migrate
rake db:seed
```

## Testing

```
rspec
```

## TODO

* Add `position` to Player model to track what position (back/front) a user is playing from
* Add `piece` to Score model to pinpoint what piece made the score
* Improve UI to have foosball-table view for score logging and player selection
* Add hash dictionary of all pieces on foosball table for telling what piece is where