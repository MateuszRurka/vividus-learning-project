Description: Login into an existing user account. Go to the fantasy movies&shows and from the first page add 8+ rating movies&shows to the watchlist.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|email	 |wry74954@nezid.com|
|password|wry74954@nezid.com|

Scenario: Login in.
When I login to IMDB with <email> and <password>

Scenario: Go to the fantasy movies&shows and from the first page add 8+ rating movies&shows to the watchlist.
When I click on element located `By.xpath(//*[text()="Menu"])`
When I click on element located `By.xpath(//*[@role="menuitem"]//*[text()="Browse Movies by Genre"])`
When I wait until element located `By.xpath(//*[@title="Fantasy"])` appears
When I click on element located `By.xpath(//*[@title="Fantasy"])`
When I find >= `1` elements by `By.xpath(//*[@class="lister-item mode-advanced" and .//*[contains(@*,"ratings-imdb-rating") and @data-value>=8]])` and for each element do
|step																					|
|When I click on element located `By.xpath(.//*[@title="Click to add to watchlist"])`	|
When I click on element located `By.xpath(//*[text()="Watchlist"])`
When I wait until element located `By.xpath(//*[text()="Your Watchlist"])` appears
