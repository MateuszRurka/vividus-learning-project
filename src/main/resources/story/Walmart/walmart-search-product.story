Description: Search for the product.

Scenario: Search for the product.
Given I am on a page with the URL '${walmart-endpoint}'
When I wait until element located `By.xpath(//*[@data-automation-id="header-input-search"])` appears
When I enter `<product>` in field located `By.xpath(//*[@data-automation-id="header-input-search"])`
Examples:
|product              |
|Froot Loops Mega Size|
|Froot Loops          |
