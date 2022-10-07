Description: Create user account

Lifecycle:
Examples:
|login							|email												|password						|
|#{generate(Name.firstName)}	|#{generate(regexify '[a-z]{6}[A-Z]{2}')}@test.com	|#{generate(regexify '\d{8}')}	|

Scenario: Signing up a new user
Given I am on a page with the URL 'https://www.imdb.com/'
When I wait until element located `By.xpath(//*[@class="ipc-button__text"][text()="Sign In"])` appears
When I click on element located `By.xpath(//*[@class="ipc-button__text"][text()="Sign In"])`
When I wait until element located `By.xpath(//*[@class="list-group"]/a[text()="Create a New Account"])` appears
When I click on element located `By.xpath(//*[@class="list-group"]/a[text()="Create a New Account"])`
Then field located `By.xpath(//*[@name="customerName"])` exists
Then field located `By.xpath(//*[@name="email"])` exists
When I enter `<login>` in field located `By.xpath(//*[@name="customerName"])`
When I enter `<email>` in field located `By.xpath(//*[@name="email"])`
When I enter `<password>` in field located `By.xpath(//*[@name="password"])`
When I enter `<password>` in field located `By.xpath(//*[@name="passwordCheck"])`
When I click on element located `By.xpath(//*[@type="submit"])`
When I wait until element located `By.xpath(//*[contains(@src, "logo")])` appears
When I wait until element located `By.xpath(//*[@id="cvf-aamation-challenge-iframe"])` appears
