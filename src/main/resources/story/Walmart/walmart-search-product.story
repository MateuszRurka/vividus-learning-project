Description: Search for the product.

Scenario: Search for the product.
Given I am on a page with the URL 'https://www.walmart.com/'
When I wait until element located `By.xpath(//*[@data-automation-id="header-input-search"])` appears
When I enter `Froot Loops Mega Size//n` in field located `By.xpath(//*[@data-automation-id="header-input-search"])`
When I click on element located `By.xpath(//*[@data-automation-id="headerSignIn"])`
