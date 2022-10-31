Description: Test that create user account

Scenario: Login in
Given I am on a page with the URL '${reddit-endpoint}'
When I wait until element located `By.xpath(//a[@role="button"][text()="Log In"])` appears
When I click on element located `By.xpath(//a[@role="button"][text()="Log In"])`
When I switch to frame located `By.xpath(//*[contains(@src,"reddit.com/login")])`
When I wait until element located `By.xpath(//main//input[@id="loginUsername"])` appears
When I enter `<login>` in field located `By.xpath(//main//input[@id="loginUsername"])`
When I enter `<password>` in field located `By.xpath(//main//input[@id="loginPassword"])`
When I click on element located `By.xpath(//main//form[@action="/login"]//button[@type="submit"])`
When I wait until element located `By.xpath(//button[@id="USER_DROPDOWN_ID"]//span[text()="<login>"])` appears
Examples:
|login            |password          |
|New-Objective3067|ysj46329@cdfaq.com|

Scenario: Search a post and open it page
When I enter `cute puppy` in field located `By.xpath(//input[@id="header-search-bar"])`
When I wait until element located `By.xpath(//*[@data-testid="search-trigger-item"])` appears
When I click on element located `By.xpath(//*[@data-testid="search-trigger-item"])`
When I wait until element located `By.xpath((//*[@data-testid="post-container" and .//*[@data-click-id="body"]])[1])` appears
When I click on element located `By.xpath((//*[@data-testid="post-container" and .//*[@data-click-id="body"]])[1])`
