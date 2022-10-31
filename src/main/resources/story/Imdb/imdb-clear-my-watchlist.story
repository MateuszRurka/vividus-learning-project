Description: Login into an existing user account. Go to Watchlist, if there are any movies and shows remove them.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|email	 |wry74954@nezid.com|
|password|wry74954@nezid.com|

Scenario: Login in.
When I login to IMDB with <email> and <password>

Scenario: Go to Watchlist, if there are any movies and shows remove them.
When I click on element located `By.xpath(//a[@role="button"]//*[text()="Watchlist"])`
When I wait until element located `By.xpath(//h1[text()="Your Watchlist"])` appears
When I find > `0` elements by `By.xpath(//*[@class="clearfix"])` and for each element do
|step																						|
|When I click on element located `By.xpath(.//*[@title="Click to remove from watchlist"])`	|
When I refresh the page
Then the text 'Your Watchlist is empty' exists
