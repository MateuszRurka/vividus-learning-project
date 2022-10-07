Description: Login into an existing user account. Go to the watchlist page and create 5 new watchlists.

Lifecycle:
Examples:
{transformer=FROM_LANDSCAPE}
|email	 |wry74954@nezid.com|
|password|wry74954@nezid.com|

Scenario: Login in.
When I login to IMDB with <email> and <password>

Scenario: Go to the watchlist page and create new watchlists.
When I click on element located `By.xpath(//a/*[text()="Watchlist"])`
When I wait until element located `By.xpath(//p[@class="seemore"])` appears
When I click on element located `By.xpath(//p[@class="seemore"])`
When I `5` times do:
|step																										|
|When I enter `#{generate(Cat.name)}` in field located `By.xpath(//*[@id="list-create-name"])`				|
|When I enter `#{generate(Hobbit.quote)}` in field located `By.xpath(//*[@id="list-create-description"])`	|
|When I click on element located `By.xpath(//button[text()="CREATE"])`										|
|When I click on element located `By.xpath(//*[text()="Done"])`												|
|When I click on element located `By.xpath(//*[text()="create a new list"])`								|
