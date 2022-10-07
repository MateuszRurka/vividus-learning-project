Description: Login into an existing user account. Go to Watchlist, locate Your Lists and if they are any remove them.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|email	 |wry74954@nezid.com|
|password|wry74954@nezid.com|

Scenario: Login in.
When I login to IMDB with <email> and <password>

Scenario: Go to Watchlist, if there are any "Your Lists" elements remove them.
When I click on element located `By.xpath(//a[@role="button"]//*[text()="Watchlist"])`
When I wait until element located `By.xpath(//h1[text()="Your Watchlist"])` appears
When I click on element located `By.xpath(//*[contains(a,"See all lists by you")])`
When I wait until element located `By.xpath(//*[text()="Your Lists"])` appears
When I find > `0` elements by `By.xpath(//*[@class="list-name"])` and for each element do
|step																								|
|When I click on element located `By.xpath(.//*[@class="circle"])`									|
|When I click on element located `By.xpath(.//*[@class="pop-up-menu-list-item-link delete-list"])`	|
