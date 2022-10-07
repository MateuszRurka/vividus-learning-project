Description: Login into an existing user account. Add a movie into a watchlist, sort the watchlist and export it.

Scenario: Login in.
When I login to IMDB with <email> and <password>

Scenario: Search a movie and add it to watchlist.
When I enter `Interstellar` in field located `By.xpath(//*[@id="suggestion-search"])`
When I wait until element located `By.xpath(//*[@data-testid="search-result--const"]//*[text()="Matthew McConaughey, Anne Hathaway"])` appears
When I click on element located `By.xpath(//*[@data-testid="search-result--const"]//*[text()="Matthew McConaughey, Anne Hathaway"])`
When I wait until element located `By.xpath(//*[@data-testid="hero-title-block__title"][text()="Interstellar"])` appears
When I wait until element located `By.xpath(//*[@class="ipc-btn__text"][text()="Add to Watchlist"])` appears
When I click on element located `By.xpath(//*[@class="ipc-btn__text"][text()="Add to Watchlist"])`
When I wait until element located `By.xpath(//*[text()="In Watchlist"])` appears

Scenario: Export watchlist and remove first movie from watchlist.
When I click on element located `By.xpath(//a[@role="button"]//*[text()="Watchlist"])`
When I wait until element located `By.xpath(//h1[text()="Your Watchlist"])` appears
When I select `Release Date` in dropdown located `By.xpath(//*[@id="main"]//*[@id="lister-sort-by-options"])`
When I click on element located `By.xpath(//*[@class="export"]/a[text()="Export this list"])`
When I click on element located `By.xpath(//*[@title="Click to remove from watchlist"])`
When I wait until element located `By.xpath(//*[@title="Click to add to watchlist"])` appears
